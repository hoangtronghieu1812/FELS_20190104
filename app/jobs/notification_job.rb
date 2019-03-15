class NotificationJob < ApplicationJob
  include PublicActivity
  queue_as :default

  def perform(counter,activity)
    ActionCable.server.broadcast 'notification_channel', counter: render_counter(counter), activity: render_notification(activity)
  end

  private

  def render_counter(counter)
    ApplicationController.renderer.render(partial: 'static_pages/counter', locals: { counter: counter })
  end

  def render_notification(activity)
    ApplicationController.renderer.render(partial: 'public_activity/course/finished', locals: { activity: activity })
  end
end
