class StaticPagesController < ApplicationController

  def home
    @courses = Course.all.sort_by{|course| Course.with_users[course.id] || 0}
      .reverse!.take Settings.courses.popular_course
    @course_with_users = Course.with_users
  end
end
