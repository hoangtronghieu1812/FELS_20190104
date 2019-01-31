class LessonsController < ApplicationController
  before_action :require_login

  def index
    @user ||= current_user
    @words = Word.with_learned(@user.id).with_correct_answer
    @pagy, @lessons = pagy @user.lessons
  end

  # def update
  #   if params[:see_correct]
  #     redirect_to lesson_path Lesson.find_by id: params[:id]
  #   elsif params[:new_lesson]
  #     redirect_to courses_path
  #   elsif params[:homepage]
  #     redirect_to root_path
  #   else
  #   end
  # end
end
