class StaticPagesController < ApplicationController
  before_action :get_user, only: :home

  def home
    @courses = Course.all.sort_by{|course| Course.with_users[course.id]}
      .reverse!.take Settings.courses.popular_course
    @course_with_users = Course.with_users
  end
end
