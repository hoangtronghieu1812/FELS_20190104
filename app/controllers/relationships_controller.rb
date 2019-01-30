class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :get_followed_user

  def create
    relationship = current_user.active_relationships
      .create! followed_id: params[:followed_id]
    relationship.create_activity :create,
      owner: current_user, recipient: @user if relationship
    require_details_from @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    if relationship
      relationship.create_activity :destroy,
        owner: current_user, recipient: @user
      current_user.unfollow @user
      require_details_from @user
    else
      flash[:danger] = t".none"
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def get_followed_user
    @user = User.find_by id: params[:followed_id]
    return if @user
    flash[:danger] = t".failed"
    redirect_to root_path
  end

end
