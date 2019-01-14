class WordsController < ApplicationController
  before_action :require_login
  UNLEARNED = "0"
  LEARNED = "1"

  def index
    @search = Word.ransack(params[:q])
    @courses = Course.all
    if !params[:condition].blank?
      if params[:condition].eql?(LEARNED)
        @pagy, @words = pagy Word.with_learned(current_user.id)
          .with_correct_answer
      elsif params[:condition].eql?(UNLEARNED)
        @pagy, @words = pagy Word.with_unlearned(current_user.id)
          .with_correct_answer
      end
    elsif params[:q]
      @pagy, @words = pagy @search.result.includes(:course)
        .with_correct_answer
    else
      @pagy, @words = pagy Word.with_correct_answer
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
end
