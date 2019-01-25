class UsersController < ApplicationController
  before_action :require_login

  def show
    @current_user = current_user
    @user = User.find_by id: params[:id]
    require_details_from @user
    @activities = PublicActivity::Activity.where(owner_id: @user.id)
      .order created_at: :desc
  end

end
