class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def ensure_authentication
      redirect_to errors_not_found_path unless user_signed_in?
    end

    def user_signed_in?
      session[:user_id] ? true : false
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
    
    def sign_user_in
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in!'
      redirect_to user_path
    end
    
    helper_method :current_user, :sign_user_in, :user_signed_in?
  
end
