class FacilitatorsController < ApplicationController
  def index
    @facilitators = Facilitator.all
    render json: @facilitators, status: :ok
  end
end
