class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @number_of_memorised_words = Word.with_learned(@user.id).count.to_s
    @number_of_followers = @user.followers.count.to_s
    @number_of_followings = @user.following.count.to_s
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @number_of_memorised_words = Word.with_learned(@user.id).count.to_s
    @number_of_followers = @user.followers.count.to_s
    @number_of_followings = @user.following.count.to_s
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
