class ApplicationController < ActionController::Base
  include Pagy::Backend

  def after_sign_in_path_for user
    session[:forward_url] ? session.delete(:forward_url) : super
  end

  def require_login
    unless user_signed_in?
      session[:forward_url] = request.fullpath
      redirect_to new_user_session_path
    end
  end
end
