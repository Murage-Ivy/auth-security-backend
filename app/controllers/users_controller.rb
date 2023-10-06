class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  #  before_filter :set_user
  #   def set_user
  #     if params[:id]
  #       user = User.find(params[:id])
  #     else
  #       user = User.new
  #     end
  #   end

  def show
    @user = User.find(params[:id])
    render json: { user: UserSerializer.new(@user) }, status: :ok
  end

  def create
    @user = User.create!(user_params.except(:role))
    if @user.save
      @user.add_role(user_params[:role])

      if user_params[:email].include?("i.murage@alustudent.com")
        @user.add_role(user_params[:role])
      end
    end

    if user_params[:role].include?("facilitator")
      Facilitator.create(email: user_params[:email], role: user_params[:role])
    end
    @token = encode_token({ user_id: @user.id })
    @refresh_token = encode_token({ user_id: @user.id }, expiration = 7.days.from_now.to_i)
    RefreshToken.create(user_id: @user.id, token: @refresh_token, expires_at: 7.days.from_now)

    render json: { user: UserSerializer.new(@user), access_token: @token, refresh_token: @refresh_token }, status: :created
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :role)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
