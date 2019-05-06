class ResultsController < ApplicationController
  before_action only: :index do
    get_lesson params[:lesson_id]
  end

  def index
  end

end
