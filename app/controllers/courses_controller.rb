class CoursesController < ApplicationController
  before_action :require_login
  before_action :get_course_with_users
  load_and_authorize_resource only: :index

  def index
    @pagy, @courses = pagy Course.all
  end
end
