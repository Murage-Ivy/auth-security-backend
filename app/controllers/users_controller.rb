class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def create
    @user = User.create!(user_params)
    @token = encode_token({ user_id: @user.id })
    @refresh_token = SecureRandom.uuid
    RefreshToken.create(user_id: @user.id, token: @refresh_token, expires_at: 7.days.from_now)
    render json: { user: UserSerializer.new(@user), access_token: @token, refresh_token: @refresh_token }, status: :created
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
