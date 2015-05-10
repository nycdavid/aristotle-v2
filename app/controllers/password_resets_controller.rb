class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :check_token, only: [:edit]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Password reset instructions sent."
      redirect_to root_url
    else
      flash[:danger] = "Invalid email address."
      redirect_to login_path
    end
  end

  def edit
  end

  def update
    if @user
      @user.update_attributes user_params
      flash[:success] = "Password successfully reset."
      redirect_to login_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find_by email: params[:email]
  end

  def check_token
    unless @user.valid_reset_token? params[:id]
      flash[:danger] = "Invalid/expired reset request."
      redirect_to login_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Invalid/expired reset request."
      redirect_to new_password_reset_path
    end
  end
end
