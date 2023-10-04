class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def create
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password])
      @token = encode_token({ user_id: @user.id })
      @refresh_token = refresh_token(@user.id)
      render json: { user: UserSerializer.new(@user), access_token: @token, refresh_token: @refresh_token }, status: :created
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def refresh_token(user_id)
    token_object = RefreshToken.find_by(user_id: user_id).token
  end
end
