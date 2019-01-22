class CoursesController < ApplicationController
  before_action :require_login

  def index
    @course_with_users = Course.with_users
    @pagy, @courses = pagy Course.all
  end
end
