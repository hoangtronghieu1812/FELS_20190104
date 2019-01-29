class LessonsController < ApplicationController
  before_action :require_login

  def index
    @user ||= current_user
    @words = Word.with_learned(@user.id).with_correct_answer
    @pagy, @lessons = pagy @user.lessons
  end
end
