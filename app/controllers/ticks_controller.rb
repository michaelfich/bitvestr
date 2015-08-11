class TicksController < ApplicationController
  def index
    ticks = Tick.last(params[:count] || 60)

    if params[:type] && params[:type] == 'crossover'
      render json: crossover(ticks).to_json
    elsif params[:type] && params[:type] == 'momentum'
      render json: momentum(ticks).to_json
    else
      render nothing: true
    end
  end

  private
  def crossover(ticks)
    if params[:b1_calc] && params[:b1_range]
      buy_first_calc = params[:b1_calc]
      buy_first_range = params[:b1_range].to_i
    end

    if params[:b2_calc] && params[:b2_range]
      buy_last_calc = params[:b2_calc]
      buy_last_range = params[:b2_range].to_i
    end

    if params[:s1_calc] && params[:s1_range]
      sell_first_calc = params[:s1_calc]
      sell_first_range = params[:s1_range].to_i
    end

    if params[:s1_calc] && params[:s2_range]
      sell_last_calc = params[:s2_calc]
      sell_last_range = params[:s2_range].to_i
    end

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
  end

  def momentum(ticks)
    if params[:buy_calc] && params[:buy_range]
      buy_calc = params[:buy_calc]
      buy_range = params[:buy_range].to_i
    end

    if params[:sell_calc] && params[:sell_range]
      sell_calc = params[:sell_calc]
      sell_range = params[:sell_range].to_i
    end

    ticks.map! do |tick|
      result = {
        id: tick.id,
        last_price: tick.last_price,
        datetime: tick.datetime,
        buy_calc: buy_calc,
        sell_calc: sell_calc
      }

      buy_price = tick.moving_avg(buy_range)
      sell_price = tick.moving_avg(sell_range)

      result[:buy_price] = buy_price
      result[:sell_price] = sell_price

      if tick.last_price < buy_price
        result[:good_buy] = true
      else
        result[:good_buy] = false
      end

      if tick.last_price < sell_price
        result[:good_sell] = true
      else
        result[:good_sell] = false
      end

      result
    end
  end
end
