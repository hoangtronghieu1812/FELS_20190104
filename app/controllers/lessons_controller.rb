class LessonsController < ApplicationController
  before_action :require_login
  before_action only: %i(edit update) do
    get_lesson params[:id]
  end
  load_and_authorize_resource only: %i(create edit update)

  def index
    @words = Word.with_learned(current_user.id).with_correct_answer
    @pagy, @lessons = pagy current_user.lessons
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    words = @lesson.course.words.with_unlearned(@lesson.user_id).random_words

    unless words.blank?
      words.each do |word|
        @lesson.lesson_answers.build word_id: word.id
      end
      if @lesson.save
        redirect_to edit_lesson_path @lesson.id
      else
        flash[:danger] = t ".fail"
        redirect_to courses_path
      end
    else
      flash[:danger] = t ".learned_all_words"
      redirect_to courses_path
    end
  end

  def edit
    @lesson_answers = @lesson.lesson_answers
  end

  def update
    ActiveRecord::Base.transaction do
      @lesson.update_attributes! lesson_params
      @lesson.update_attributes! results: WordAnswer
        .get_result_of_lesson(@lesson.id)
      SendResultsJob.perform_later @lesson.user , @lesson
      redirect_to lesson_results_path @lesson
    end
    if @lesson.course.words.with_unlearned(@lesson.user_id).empty?
      @lesson.user.followers.each do |recipient|
        notification = @lesson.course.create_activity(:finished,
          owner: @lesson.user, recipient: recipient)
        if notification
          NotificationJob.perform_later recipient
            .number_of_activities , notification
        end
      end
    end
    rescue StandardError
      flash.now[:error] = t ".error"
      render :edit

  end

  private

  def lesson_params
    params.require(:lesson).permit :course_id, :user_id,
      lesson_answers_attributes: [:id, :word_id, :word_answer_id]
  end
end
