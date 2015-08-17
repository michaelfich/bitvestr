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
    @formulas = get_formulas
    @intervals = get_intervals
  end

  def create
    @strategy = Strategy.new(momentum_params)
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
    @collaborator = Collaboration.new
    @formulas = get_formulas
  end

  def edit
    @strategy = Strategy.find(params[:id])
    @indicators = @strategy.indicators.order('id ASC')
    @path = strategy_momentum_path(@strategy)
    @method = :patch
    @formulas = get_formulas
    @intervals = get_intervals
  end

  def update
    @strategy = Strategy.find(params[:id])
    @strategy.update_attributes(momentum_params)
    if @strategy.save
      flash[:notice] = "Successfully updated #{@strategy.name}!"
      redirect_to strategy_momentum_url(@strategy)
    else
      flash[:alert] = "Unable to update #{@strategy.name}."
      @path = strategy_momentum_path(@strategy)
      @method = :patch
      render :edit
    end
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
