class UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find_by id: params[:id]
    if @user
      require_details_from @user
      @activities = User.get_activities_of @user.id
    else
      redirect_to root_path
      flash[:danger] = t".failed"
    end
  end

end
