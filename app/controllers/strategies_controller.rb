class StrategiesController < ApplicationController
  
  def index
    @strategies = Strategies.all
  end

  def new
    @strategy = Strategies.new
  end

  def create
    @strategy = Strategies.new(strategy_params)
    if @strategy.save
      redirect_to @strategy
    else
      render :new
    end
  end

  private
  def strategy_params
    params.require(:strategy).permit(:name, :interval)
  end
end
