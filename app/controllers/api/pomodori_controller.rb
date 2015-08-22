module Api
  class PomodoriController < ApplicationController
    before_action :ensure_authentication
    respond_to :json

    def create
      @pursuit = Pursuit.find(params[:pursuit_id])
      @pomodoro = @pursuit.pomodori.new elapsed_time: params[:pomodoro][:elapsed_time]

      if @pomodoro.save
        render json: @pomodoro
      end
    end
  end
end
