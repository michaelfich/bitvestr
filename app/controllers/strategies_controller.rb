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
    @comparisons = get_comparators
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
    @comparisons = get_comparators
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

  def get_comparators
    counter = 0;
    Indicator::COMPARATORS.inject([]) do |result, value|
      result.push([value, counter])
      counter += 1;
      result
    end
  end
end
