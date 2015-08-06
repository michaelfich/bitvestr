class StrategiesController < ApplicationController
  def index
    @strategies = if current_user
      Strategy.where(user: current_user)
    end
  end

  def new
    @strategy = Strategy.new
    (1..4).each do |strategy|
      @strategy.indicators.build
    end
    @comparisons = Indicator::COMPARATORS
  end

  def create
    @strategy = Strategy.new(strategy_params)
    @strategy.user = current_user
    if @strategy.save
      flash[:notice] = "Successfully created your #{@strategy.name} investment strategy."
      redirect_to @strategy
    else
      flash[:alert] = "Unable to create strategy"
      render :new
    end
  end

  def show
    @strategy = Strategy.find(params[:id])
  end

  def edit
    @strategy = Strategy.find(params[:id])
    @comparisons = Indicator::COMPARATORS
  end

  def update
    @strategy = Strategy.find(params[:id])
    @strategy.update(strategy_params)
    if @strategy.save
      flash[:notice] = "Successfully updated your #{@strategy.name} investment strategy."
      redirect_to @strategy
    else
      flash[:alert] = "Unable to save changes to #{@strategy.name} strategy"
      render :edit
    end
  end

  private
  def strategy_params
    params
      .require(:strategy)
      .permit(:name, :interval,
              indicators_attributes: [
                :id, :name, :value, :comparison, :period, :action, :_destroy
              ])
  end
end
