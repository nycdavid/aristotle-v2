class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new
  end

  def create
    user_has_valid_credentials? ? sign_user_in : refuse_login
  end
  
  private
    def find_user
      @user = User.find_by_email(params[:user][:email])

      refuse_login if @user.nil?
    end

    def user_has_valid_credentials?
      @user.authenticate(params[:user][:password]) 
    end

    def refuse_login
      flash[:danger] = 'Invalid email/password.'
      redirect_to login_path
    end
end
