class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    require_details_from @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by(id: params[:id])
    @user = @relationship.followed
    current_user.unfollow @user
    require_details_from @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
