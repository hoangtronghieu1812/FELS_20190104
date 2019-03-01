# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :add_hpbd_jobs_for_user, only: :create

  private

  def add_hpbd_jobs_for_user
    current_user.three_next_birthdays.each do |day|
      HappyBirthdayJob.set(wait_until: (day - Date.current)
        .days.from_now).perform_later current_user
    end
  end
end
