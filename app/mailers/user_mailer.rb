class UserMailer < ApplicationMailer
  helper ApplicationHelper
  helper FontAwesome::Rails::IconHelper

  def send_lesson_result
    @user = params[:user]
    @lesson = params[:lesson]
    mail to: @user.email, subject: t(".your_result",
      course: @lesson.course.name)
  end
end
