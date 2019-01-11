class WordsController < ApplicationController
  before_action :require_login

  def index
    if params[:condition].eql?("1")
      @lesson_answers = LessonAnswer.get_answer current_user.id
      @word_ids = @lesson_answers.pluck(:word_id).uniq
      @pagy, @words = pagy Word.by_ids(@word_ids)
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
