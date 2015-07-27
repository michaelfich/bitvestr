class StrategiesController < ApplicationController
  def index
    @strategies = if current_user
      Strategy.where(user: current_user)
    end
  end

  def new
    @strategy = Strategy.new
  end

  def create
    @strategy = Strategy.new(strategy_params)
    @strategy.user = current_user
    if @strategy.save
      redirect_to @strategy
    else
      render :new
    end
  end

  private
  def strategy_params
    params.require(:strategy)
          .permit(:name, :interval, indicators_attributes: [:id, :name, :value, :_destroy])
  end
end
