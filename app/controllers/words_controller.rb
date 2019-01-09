class WordsController < ApplicationController
  def index
    @pagy, @words = pagy Word.with_correct_answer
  end
end
