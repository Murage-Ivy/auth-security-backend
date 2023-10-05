class RequestsController < ApplicationController
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def create
    @request = Request.create!(request_params)
    render json: { request: RequestSerializer.new(@request) }, status: :created
  end

  private

  def request_params
    params.permit(:user_id, :request)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
