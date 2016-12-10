class PagesController < ApplicationController
  layout "guest"

  def home
    redirect_to user_path if user_signed_in?
  end

  def lets_encrypt
    render text: "Rg_tl68gjvM5f3b7IWzA27ENQW-xQEd0btMDuJDoMdk.YcyMFZ13uEF6X5xwbAarteuUWUfXkFrH9awQ1bCOf8k"
  end
end
