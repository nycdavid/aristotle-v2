class AdminsController < ApplicationController
  def show
    authorize! :manage, :all
    @section_heading = "Administrators"
    render "admin/show", layout: "users"
  end
end
