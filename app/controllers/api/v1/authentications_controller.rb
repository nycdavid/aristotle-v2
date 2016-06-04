module Api::V1
  class AuthenticationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate

    def create
      payload = { iss: "Aristotle API", user_type: "user", id: @user.id }
      jwt = JWT.encode payload, Rails.application.secrets[:secret_key_base]
      render json: { jwt: jwt }
    end

    private

    def authenticate
      email = authentication_params[:email]
      @user = User.find_by_email(email)
      render json: {}, status: 401 if @user.nil?
      check_password
    end

    def check_password
      render json: {}, status: 401 unless @user.authenticate authentication_params[:password]
    end

    def authentication_params
      params.require(:authentication).permit(:email, :password)
    end

  end
end
