class Strategy::CrossoversController < ApplicationController
  def new
    @strategy = Strategy.new
    @strategy.classification = "crossover"
    (1..4).each do |n|
      indicator = @strategy.indicators.build
    end
    @indicators = @strategy.indicators
    @comparisons = Indicator::COMPARATORS
    @path = strategy_crossovers_path(@strategy)
    @method = :post
    @formulas = get_formulas
    @intervals = get_intervals
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
    @collaborator = Collaboration.new
    @formulas = get_formulas
  end

  def edit
    @strategy = Strategy.find(params[:id])
    @indicators = @strategy.indicators.order('id ASC')
    @path = strategy_crossover_path(@strategy)
    @method = :patch
    @formulas = get_formulas
    @intervals = get_intervals
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

  def destroy
    @strategy = Strategy.find(params[:id])
    @strategy.destroy

    flash[:notice] = "Successfully deleted strategy: #{@strategy.name}"
    redirect_to strategies_url
  end

  private
  def crossover_params
    params.require(:strategy).permit(:name, :interval,
      indicators_attributes: [
        :id, :name, :value, :comparison, :period, :_destroy
      ]
    )
  end
end
