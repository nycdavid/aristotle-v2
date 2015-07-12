class PagesController < ApplicationController
  layout "guest"

  def home
    redirect_to user_path if user_signed_in?
  end
end
