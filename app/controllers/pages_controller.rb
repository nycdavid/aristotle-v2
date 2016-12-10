class PagesController < ApplicationController
  layout "guest"

  def home
    redirect_to user_path if user_signed_in?
  end

  def lets_encrypt
    render text: "XXaqt4lDl1INllHOVN8o10fKnRuDLtLPopCns6DX-5o.YcyMFZ13uEF6X5xwbAarteuUWUfXkFrH9awQ1bCOf8k"
  end
end
