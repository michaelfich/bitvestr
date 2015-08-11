class TicksController < ApplicationController
  def index
    ticks = Tick.last(params[:count] || 60)

    buy_first_calc = params[:b1_calc]
    buy_first_range = params[:b1_range].to_i

    buy_last_calc = params[:b2_calc]
    buy_last_range = params[:b2_range].to_i

    sell_first_calc = params[:s1_calc]
    sell_first_range = params[:s1_range].to_i

    sell_last_calc = params[:s2_calc]
    sell_last_range = params[:s2_range].to_i

    ticks.map! do |tick|
      result = {
        id: tick.id,
        last_price: tick.last_price,
        datetime: tick.datetime,
      }

      if buy_first_calc && buy_first_calc == "moving_avg"
        buy_first = tick.moving_avg(buy_first_range)
        result[:moving_avg_buy_low] = buy_first
      end

      if buy_first_calc && buy_last_calc == "moving_avg"
        buy_last = tick.moving_avg(buy_last_range)
        result[:moving_avg_buy_high] = buy_last
      end

      if buy_first && buy_last
        result[:good_buy] = buy_first < buy_last
      end

      if sell_first_calc && sell_first_calc == "moving_avg"
        sell_first = tick.moving_avg(sell_first_range)
        result[:moving_avg_sell_low] = sell_first
      end

      if sell_last_calc && sell_last_calc == "moving_avg"
        sell_last = tick.moving_avg(sell_last_range)
        result[:moving_avg_sell_high] = sell_last
      end

      if sell_first && sell_last
        result[:good_sell] = sell_first < sell_last
      end

      result
    end
    render json: ticks.to_json
  end
end
