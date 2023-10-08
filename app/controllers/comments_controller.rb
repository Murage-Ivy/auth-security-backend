class CommentsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied, with: :render_unauthorized_entity_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  wrap_parameters format: []

  def index
    @comments = Comment.all
    render json: @comments, status: :ok
  end

  def create
    @comment = Comment.create!(comment_params)
    render json: @comment, status: :created
  end

  private

  def comment_params
    params.permit(:request_id, :content)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
