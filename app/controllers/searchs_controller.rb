class SearchsController < ApplicationController
  before_action :get_course_with_users

  def index
    Word.reindex
    Course.reindex
    @words = Word.search params[:query], fields: [:content], highlight: :content,
      page: params[:page], per_page: Settings.word.per_page, match: :word_start
    @courses = Course.search params[:query], fields: [:name, :description],
      highlight: [:name, :description], match: :word_start
    # @pagy, @words = pagy Word.all
    # @courses = Course.all
  end
end
