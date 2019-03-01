class MailWorker
  include Sidekiq::Worker

  def perform user
    UserMailer.with(user: user).welcome_email
  end
end
