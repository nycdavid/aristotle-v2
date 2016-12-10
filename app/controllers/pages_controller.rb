class PagesController < ApplicationController
  layout "guest"

  def home
    redirect_to user_path if user_signed_in?
  end

  def lets_encrypt
    render text: "8M1uxnFhyG7ig6M73kthxpTa7KDvIbERscUWfXqorwI.YcyMFZ13uEF6X5xwbAarteuUWUfXkFrH9awQ1bCOf8k"
  end
end
