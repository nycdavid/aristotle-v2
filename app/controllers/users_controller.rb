class UsersController < ApplicationController
  before_action :ensure_authentication, only: [:show, :edit, :update]
  before_action :fetch_user, only: [:show, :edit, :update]

  def new
    @user = User.new
    render layout: "guest"
  end

  def edit
    @section_heading = "Edit my Account"
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Account successfully updated.'
      redirect_to user_path
    else
      flash[:danger] = 'Sorry, there was a problem with your last request.'
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    @user.save ? sign_user_in : refuse_signup
  end

  def show
  end

  def change_password
    @section_heading = "Change my Password"
  end

  private
    def fetch_user
      @user = current_user
    end

    def refuse_signup
      flash[:danger] = 'We\'re sorry, but there was a problem...'
      render :new
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :timezone, :first_name, :last_name)
    end
end
