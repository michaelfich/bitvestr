class Tick < ActiveRecord::Base
  def moving_avg(range)
    records = last_records(range)
    sum_value(records) / range.to_i
  end

  def exponential_moving_avg(range)
    current = last_records(range).first
    prev_ema = previous_ema(range).last
    multiplier = relevant_multiplier(range)
    (current.last_price - prev_ema) * multiplier + prev_ema
  end


  # def vwap(array)
  #   (array["price"].sum * array["volume"].sum) / array["volume"].sum
  # end

  def macd(fast_range, slow_range, signal_range)
    macd_line = exponential_moving_avg(fast_range) - exponential_moving_avg(slow_range)
    signal_line = exponential_moving_avg(signal_range)
    macd_line - signal_line
  end

  # def atr(array)
  # end

  # def sar(array)
  # end

  # def mfi(array)
  #   typical_price = (array["price"].max + array["price"].min + array["price"].last) / 3
  #   raw_money_flow = typical_price * array["volume"].sum
  #   # money_flow_ratio
  # end

  # def aroon(array)
  #   aroon_up
  #   aroon_down
  # end

  private
  #SMA/General Use Methods
    def last_records(range)
      offset = Tick.where(id: self.id..Tick.last.id).count - 1
      Tick.order("id DESC").offset(offset).limit(range)
    end

    def sum_value(ticks)
      ticks.inject(0) do |total, tick|
        total += tick.last_price
      end
    end

   #EMA Methods
   def relevant_multiplier(range)
    2.0 / (range.to_f + 1.0)
   end

    def relevant_records(range)
      offset_array = (0..19)
      record_array = []
      offset_array.each do |num|
        offset = Tick.where(id: self.id..Tick.last.id).count + num
        record_array << Tick.order("id DESC").offset(offset).limit(range)
      end
      record_array
    end

    def furthest_moving_avg(range)
      old_records = relevant_records(range)
      records = old_records.last
      sum_value(records) / range
    end

    def previous_ema(range)
      avgs = []
      avgs << furthest_moving_avg(range)
      relevant = relevant_records(range).reverse
      multiplier = relevant_multiplier(range)
      relevant.drop(1)
      relevant.each do |array|  
        x = ((array.first.last_price - avgs.last) * multiplier) + avgs.last
        avgs << x
      end
      avgs
    end
end
