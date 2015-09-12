class Admin::UsersController < ApplicationController
  layout "users"

  def index
    authorize! :manage, :all
    @section_heading = "All Users"
    @users = User.all
  end
end
