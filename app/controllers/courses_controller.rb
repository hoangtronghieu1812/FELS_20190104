class CoursesController < ApplicationController
  before_action :require_login
  load_and_authorize_resource only: :index

  def index
    @course_with_users = Course.with_users
    @pagy, @courses = pagy Course.all
  end
end
