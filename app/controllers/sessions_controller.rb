class SessionsController < ApplicationController
  def new
  end

  def create
    user_has_valid_credentials? ? sign_user_in : refuse_login
  end
  
  private
    def sign_user_in
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in!'
      redirect_to account_path
    end

    def refuse_login
      flash[:danger] = 'Invalid email/password.'
      redirect_to login_path
    end

    def user_has_valid_credentials?
      @user = User.find_by_email(params[:user][:email])
      return false if @user.nil?
      @user.authenticate(params[:user][:password]) 
    end
end
