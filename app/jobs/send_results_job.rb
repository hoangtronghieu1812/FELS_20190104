class SendResultsJob < ApplicationJob
  queue_as :default

  def perform user , lesson
    UserMailer.with(user: user, lesson: lesson)
     .send_lesson_result.deliver_now
  end
end
