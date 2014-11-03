class PursuitsController < ApplicationController
  layout 'users'

  def new
    @pursuit = current_user.pursuits.new
  end

  def create
    @pursuit = current_user.pursuits.new(pursuit_params)
    @pursuit.save ? allow_pursuit : refuse_pursuit 
  end

  def show
    @pursuit = Pursuit.find(params[:id])
  end

  private
    def allow_pursuit
      flash[:success] = 'Pursuit successfully created! Now get crackin\'!'
      redirect_to(user_pursuit_path @pursuit)
    end

    def refuse_pursuit
      flash[:danger] = "We're sorry, something went wrong..."
      render :new
    end
  
    def pursuit_params
      params.require(:pursuit).permit(:name)
    end
end
