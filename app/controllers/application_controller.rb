class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    unless logged_in?
      flash[:warning] = "ログインもしくはアカウントを作成してください"
      redirect_to new_session_path
    end
  end

end
