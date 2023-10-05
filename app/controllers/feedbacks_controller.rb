class FeedbacksController < ApplicationController
  load_and_authorize_resource
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def create
    @feedback = Feedback.create!(feedback_params)
    render json: { feedback: FeedbackSerializer.new(@feedback) }, status: :created
  end

  private

  def feedback_params
    params.permit(:user_id, :content, :request_id)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
