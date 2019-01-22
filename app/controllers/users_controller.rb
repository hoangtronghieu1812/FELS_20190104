class UsersController < ApplicationController
  before_action :require_login

  def show
    @current_user = current_user
    @user = User.find_by id: params[:id]
    require_details_from @user
  end

end
