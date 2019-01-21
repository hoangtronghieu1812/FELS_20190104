class SearchsController < ApplicationController
  def index
    @words = Word.search params[:query], fields: [:content], highlight: true,
      match: :word_start, page: params[:page], per_page: Settings.word.per_page
    @courses = Course.search params[:query], fields: [:name, :description],
      highlight: true, match: :word_start
    # @pagy, @words = pagy Word.all
    # @courses = Course.all
  end
end
