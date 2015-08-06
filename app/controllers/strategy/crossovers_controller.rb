class Strategy::CrossoversController < ApplicationController
  def new
    @strategy = Strategy.new
    @strategy.type = "crossover"
    (1..4).each do |n|
      indicator = @strategy.indicators.build
      indicator.action = if n < 3
        'buy'
      else
        'sell'
      end
    end
    @comparisons = Indicator::COMPARATORS
  end

  def create
    @strategy = Strategy.new(strategy_params)
    @strategy.user = current_user
    @strategy.type = "crossover"
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
    @buy_low = @strategy.indicators.first
    @buy_high = @strategy.indicators.second
    @sell_low = @strategy.indicators.third
    @sell_high = @strategy.indicators.fourth
  end

  private
  def crossover_params
    params.require(:strategy).permit(:name, :interval,
      indicators_attributes: [
        :id, :name, :value, :comparison, :period, :action, :_destroy
      ]
    )
  end
end
