class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    render json: @comments, status: :ok
  end

  def create
    @comment = Comment.new(comment_params)
    render json: @comment, status: :created
  end

  private

  def comment_params
    params.permit(:request_id, :content)
  end
end
