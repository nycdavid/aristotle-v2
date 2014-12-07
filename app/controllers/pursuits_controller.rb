class PursuitsController < ApplicationController
  layout 'users'
  before_action :ensure_authentication
  before_action :fetch_pursuit, only: [:show, :edit, :update]

  def index
    @pursuits = current_user.pursuits
  end

  def new
    @pursuit = current_user.pursuits.new
  end

  def create
    @pursuit = current_user.pursuits.new(pursuit_params)
    @pursuit.save ? allow_pursuit : refuse_pursuit 
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @pursuit.to_json }
    end
  end

  def edit
  end

  def update
    @pursuit.update_attributes(pursuit_params) ? allow_pursuit : refuse_pursuit
  end

  private
    def allow_pursuit
      flash[:success] = 'Pursuit successfully created! Now get crackin\'!'
      redirect_to user_pursuits_path
    end

    def refuse_pursuit
      flash[:danger] = "We're sorry, something went wrong..."
      render :new
    end
  
    def pursuit_params
      params.require(:pursuit).permit(:name, :pomodoro_length_in_minutes, :pomodoro_length_in_seconds)
    end

    def fetch_pursuit
      @pursuit = Pursuit.find(params[:id])
    end
end
