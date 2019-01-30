class LessonsController < ApplicationController
  before_action :require_login
  before_action only: :edit do
    get_lesson params[:id]
  end

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
  def new
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      redirect_to edit_lesson_path @lesson.id
    else
      flash[:danger] = t ".fail"
      redirect_to courses_path
    end
  end

  def edit
    course = @lesson.course
    words = course.words.with_unlearned(@lesson.user_id).random_words

    unless words.blank?
      words.each do |word|
        @lesson.lesson_answers.build word_id: word.id
      end
    else
      flash[:danger] = t ".learned_all_words"
      redirect_to courses_path
    end
  end

  def update
  end

  private

  def lesson_params
    params.require(:lesson).permit :course_id, :user_id, :results,
      lesson_anwers_attributes: [:id, :word_id, :word_answer_id]
  end
end
