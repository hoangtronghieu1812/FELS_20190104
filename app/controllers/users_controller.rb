class UsersController < ApplicationController
  def show
    @current_user = current_user
    @user = User.find_by id: params[:id]
  end
end
