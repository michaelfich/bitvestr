class StrategiesController < ApplicationController
  def index
    @strategies = Strategy.all
  end

  def new
    @strategy = Strategy.new
  end

  def create
    @strategy = Strategy.new(strategy_params)
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
