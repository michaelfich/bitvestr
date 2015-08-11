class Strategy::MomentumsController < ApplicationController
  def new
    @strategy = Strategy.new
    @strategy.classification = "momentum"
    (1..2).each do |n|
      indicator = @strategy.indicators.build
    end
    @indicators = @strategy.indicators
    @comparisons = Indicator::COMPARATORS
    @path = strategy_momentums_path(@strategy)
    @method = :post
  end

  def create
    @strategy = Strategy.new()
    @strategy.user = current_user
    @strategy.classification = "momentum"
    if @strategy.save
      flash[:notice] = "Successfully created your #{@strategy.name} investment strategy."
      redirect_to strategy_momentum_path(@strategy)
    else
      flash[:alert] = "Unable to create strategy"
      @path = strategy_momentums_path(@strategy)
      @method = :post
      render :new
    end
  end

  def show
    @strategy = Strategy.find(params[:id])
    @buy = @strategy.indicators.first
    @sell = @strategy.indicators.second
  end

  private
  def momentum_params
    params.require(:strategy).permit(:name, :interval,
      indicators_attributes: [
        :id, :name, :value, :comparison, :period, :_destroy
      ]
    )
  end
end
