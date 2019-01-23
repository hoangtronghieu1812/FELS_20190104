class UsersController < ApplicationController
  before_action :require_login

  def show
    @current_user = current_user
    @user = User.find_by id: params[:id]
    @activities = PublicActivity::Activity.where owner_id: @user.id
    @number_of_memorised_words = Word.with_learned(@user.id).count.to_s
    @number_of_followers = @user.followers.count.to_s
    @number_of_followings = @user.following.count.to_s
  end
end
