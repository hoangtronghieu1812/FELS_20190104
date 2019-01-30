class CoursesController < ApplicationController
  before_action :require_login
  before_action :get_user, only: :index

  def index
    @course_with_users = Course.with_users
    @pagy, @courses = pagy Course.all
  end
end
