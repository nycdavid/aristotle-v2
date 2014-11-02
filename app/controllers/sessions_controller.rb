class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new
  end

  def create
    sign_user_in if user_has_valid_credentials?
  end
  
  private
    def find_user
      @user = User.find_by_email(params[:user][:email])

      if @user.nil?
        flash[:danger] = 'Invalid email/password.'
        redirect_to login_path
      end
    end

    def user_has_valid_credentials?
      @user.authenticate(params[:user][:password]) 
    end
end
