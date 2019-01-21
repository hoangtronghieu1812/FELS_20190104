class WordsController < ApplicationController
  before_action :require_login
  UNLEARNED = "0"
  LEARNED = "1"

  def index
    @search = Word.ransack(course_id_eq: params[:course_id_eq],
      content_start: params[:content_start])
    @courses = Course.all

    if params[:learning_condition].eql?(LEARNED)
      @pagy, @words = pagy @search.result.with_learned(current_user.id)
        .with_correct_answer
    elsif params[:learning_condition].eql?(UNLEARNED)
      @pagy, @words = pagy @search.result.with_unlearned(current_user.id)
        .with_correct_answer
    else
      @pagy, @words = pagy @search.result
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

end
