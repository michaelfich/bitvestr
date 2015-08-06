class TicksController < ApplicationController
  def index
    ticks = Tick.last(params[:count] || 120)

    buy_first_calc = params[:b1_calc]
    buy_first_range = params[:b1_range].to_i

    buy_last_calc = params[:b2_calc]
    buy_last_range = params[:b2_range].to_i

    ticks.map! do |tick|
      buy_first = tick.moving_avg(buy_first_range)
      buy_last = tick.moving_avg(buy_last_range)
      good_buy = buy_first < buy_last

      hash = {
        id: tick.id,
        last_price: tick.last_price,
        datetime: tick.datetime,
        moving_avg_buy_low: buy_first,
        moving_avg_buy_high: buy_last,
        good_buy: good_buy
      }
    end

    render json: ticks.to_json
  end
end
