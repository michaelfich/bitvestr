class Strategy::CrossoversController < ApplicationController
  def new
    @strategy = Strategy.new
    @strategy.classification = "crossover"
    (1..4).each do |n|
      indicator = @strategy.indicators.build
      indicator.action = if n < 3
        'buy'
      else
        'sell'
      end
    end
    @indicators = @strategy.indicators
    @comparisons = Indicator::COMPARATORS
    @path = strategy_crossovers_path(@strategy)
    @method = :post
  end

  def create
    @strategy = Strategy.new(crossover_params)
    @strategy.user = current_user
    @strategy.classification = "crossover"
    if @strategy.save
      flash[:notice] = "Successfully created your #{@strategy.name} investment strategy."
      redirect_to strategy_crossover_path(@strategy)
    else
      flash[:alert] = "Unable to create strategy"
      @path = strategy_crossovers_path(@strategy)
      @method = :post
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

  def edit
    @strategy = Strategy.find(params[:id])
    @indicators = @strategy.indicators.order('id ASC')
    @path = strategy_crossover_path(@strategy)
    @method = :patch
  end

  def update
    @strategy = Strategy.find(params[:id])
    @strategy.update_attributes(crossover_params)
    if @strategy.save
      flash[:notice] = "Successfully updated #{@strategy.name}!"
      redirect_to strategy_crossover_url(@strategy)
    else
      flash[:alert] = "Unable to update #{@strategy.name}."
      @path = strategy_crossover_path(@strategy)
      @method = :patch
      render :edit
    end
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
