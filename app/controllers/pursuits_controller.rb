class PursuitsController < ApplicationController
  layout 'users'
  before_action :ensure_authentication
  before_action :fetch_pursuit, only: [:show, :edit, :update, :destroy]

  def index
    @pursuits = current_user.pursuits
    @range = params[:range].nil? ? "overall" : params[:range]
    @inspirational_quote = InspirationalQuote.random
    @section_heading = "Your Pursuits"
  end

  def new
    @pursuit = current_user.pursuits.new
    @section_heading = "Create a new Pursuit"
  end

  def create
    @pursuit = current_user.pursuits.new(pursuit_params)
    @pursuit.save ? allow_pursuit : refuse_pursuit 
  end

  def show
    @data = PursuitChartData.new(@pursuit).count_backward_from_today(6)
    @section_heading = @pursuit.name
    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @pursuit.to_json }
    end
  end

  def edit
    @section_heading = "Edit: #{@pursuit.name}"
  end

  def update
    @pursuit.update_attributes(pursuit_params) ? allow_pursuit : refuse_pursuit
  end

  def destroy
    if @pursuit.destroy
      flash[:success] = 'Pursuit deleted.'
      redirect_to user_pursuits_path
    else
      flash[:danger] = "Sorry! We weren't able to delete your pursuit. Please try again."
      redirect_to user_pursuit_path(@pursuit.id)
    end
  end

  private
    def allow_pursuit
      flash[:success] = 'Pursuit successfully created! Now get crackin\'!'
      redirect_to user_pursuit_path @pursuit.id
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
