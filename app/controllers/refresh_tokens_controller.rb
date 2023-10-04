class RefreshTokensController < ApplicationController
  def create
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])
    if refresh_token && refresh_token.user_id.present?
      if refresh_token.expires_at > Time.now
        @user = User.find(refresh_token.user_id)
        @token = encode_token({ user_id: @user.id })
        render json: { user: UserSerializer.new(@user), access_token: @token }, status: :created
      else
        render json: { error: "Refresh token has expired" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid refresh token" }, status: :unprocessable_entity
    end
  end

  def destroy
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])
    if refresh_token
      refresh_token.destroy
      render json: { message: "Refresh token destroyed" }, status: :ok
    else
      render json: { error: "Invalid refresh token" }, status: :unprocessable_entity
    end
  end
end
