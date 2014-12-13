class PomodoriController < ApplicationController
  layout 'users'
  before_action :ensure_authentication
  before_action :fetch_pursuit, only: [:new, :create, :show]
  before_action :fetch_pomodoro, only: [:show]

  def new
  end

  def create
    @pomodoro = @pursuit.pomodori.new(pomodoro_params)

    if @pomodoro.save
      respond_to do |format|
        format.html { render :json => @pomodoro.to_json }
      end
    else
      raise 'Error saving pomodoro.'
    end
  end

  def show
  end

  private
    def fetch_pomodoro
      @pomodoro = Pomodoro.find(params[:id])
    end

    def fetch_pursuit
      @pursuit = Pursuit.find(params[:pursuit_id])
    end

    def pomodoro_params
      params.require(:pomodoro).permit(:pursuit_id, :elapsed_time)
    end
end
