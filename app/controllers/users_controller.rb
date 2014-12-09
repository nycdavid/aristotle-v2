class UsersController < ApplicationController
  before_action :ensure_authentication, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save ? sign_user_in : refuse_signup
  end

  def show
    @user = current_user
  end

  private
    def refuse_signup
      flash[:danger] = 'We\'re sorry, but there was a problem...'
      render :new
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
