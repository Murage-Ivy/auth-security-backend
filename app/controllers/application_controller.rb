class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload, expiration = 24.hours.from_now)
    @api_key = Rails.application.credentials.secret_api_key
    # set the exp claim to now + 1 day in seconds (60 *
    payload[:exp] = expiration.to_i
    @token = JWT.encode(payload, @api_key)
  end

  def auth_header
    request.headers["Authorization"]
  end

  def decode_token
    if auth_header
      @token = auth_header.split(" ")[1]
      begin
        JWT.decode(@token, Rails.application.credentials.secret_api_key, true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decode_token
      user_id = decode_token[0]["user_id"]
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end
end
