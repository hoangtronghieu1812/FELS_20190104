class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :get_followed_user
  load_and_authorize_resource only: [:create, :destroy]

  def create
    relationship = current_user.active_relationships
      .create! followed_id: params[:followed_id]
    require_details_from @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    if relationship
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
