class TicksController < ApplicationController
  def index
    ticks = Tick.last(params[:count] || 60).to_a

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
    buy_first_calc = params[:b1_calc]
    buy_first_range = params[:b1_range].to_i

    buy_last_calc = params[:b2_calc]
    buy_last_range = params[:b2_range].to_i

    sell_first_calc = params[:s1_calc]
    sell_first_range = params[:s1_range].to_i

    sell_last_calc = params[:s2_calc]
    sell_last_range = params[:s2_range].to_i

    ticks.map do |tick|
      result = {
        id: tick.id,
        last_price: tick.last_price,
        datetime: tick.datetime,
      }

      buy_first = calculate_price(tick, buy_first_calc, buy_first_range)
      buy_last = calculate_price(tick, buy_last_calc, buy_last_range)
      sell_first = calculate_price(tick, sell_first_calc, sell_first_range)
      sell_last = calculate_price(tick, sell_last_calc, sell_last_range)

      result[:good_buy] = buy_first < buy_last
      result[:good_sell] = sell_first < sell_last

      result
    end
  end

  def momentum(ticks)
    buy_calc = params[:buy_calc]
    buy_range = params[:buy_range].to_i

    sell_calc = params[:sell_calc]
    sell_range = params[:sell_range].to_i

    ticks.map! do |tick|
      result = {
        id: tick.id,
        last_price: tick.last_price,
        datetime: tick.datetime,
        buy_calc: buy_calc,
        sell_calc: sell_calc
      }

      buy_price = calculate_price(tick, buy_calc, buy_range)
      sell_price = calculate_price(tick, sell_calc, sell_range)

      result[:good_buy] = buy_price < tick.last_price
      result[:good_sell] = tick.last_price < sell_price

      result
    end
  end

  def calculate_price(tick, calculation, range)
    if calculation = "ma"
      tick.ma(range)
    elsif calculation = "ema"
      tick.ema(range)
    elsif calculation = "macd"
      tick.macd(range)
    elsif calculation = "rsi"
      tick.rsi(range)
    end
  end
end
