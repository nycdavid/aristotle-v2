class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
    
    def sign_user_in
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in!'
      redirect_to account_path
    end
    
    helper_method :current_user, :sign_user_in
  
end
