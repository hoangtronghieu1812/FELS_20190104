class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    Relationship.find_by(followed_id: params[:followed_id],
      follower_id: current_user.id).create_activity :create,
      owner: current_user, recipient: @user
    @number_of_memorised_words = Word.with_learned(@user.id).count.to_s
    @number_of_followers = @user.followers.count.to_s
    @number_of_followings = @user.following.count.to_s
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find_by(id: params[:id])
    @user = @relationship.followed
    current_user.unfollow @user
    @relationship.create_activity :destroy,
      owner: current_user, recipient: @user
    @number_of_memorised_words = Word.with_learned(@user.id).count.to_s
    @number_of_followers = @user.followers.count.to_s
    @number_of_followings = @user.following.count.to_s
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
