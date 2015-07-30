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
    @comparisons = get_comparators
  end

  def create
  end

  private
  def crossover_params
    # params.require(:)
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
