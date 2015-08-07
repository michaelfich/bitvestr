class Tick < ActiveRecord::Base
  def less_than(start, finish)
    self.moving_avg(start) < self.moving_avg(finish)
  end

  def moving_avg(range)
    records = last_records(range)
    sum_value(records) / range
  end


  # def exponential_moving_avg(range)
  #   curr_array = last_records(range)

  #   prev_array = second_last_records(range)
  #   multiplier =  2 / (range + 1)
  #   close = curr_array.first["last_price"]

  #   (close - last_moving_avg(range)) * multiplier + last_moving_avg(range)

  # end

  def test(range)
    furthest_records(range)
  end

  def test2(range)
    furthest_moving_avg(range)
  end


  # def vwap(array)
  #   (array["price"].sum * array["volume"].sum) / array["volume"].sum
  # end

  # def macd(array)
  #   EMA1 - EMA2
  # end

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

 #EMA Methods

  def furthest_records(range)
    offset_array = (0..19)
    record_array = []
    offset_array.each do |num|
      offset = Tick.where(id: self.id..Tick.last.id).count + num
      record_array << Tick.order("id DESC").offset(offset).limit(range)
    end
    record_array
  end

  def furthest_moving_avg(range)
    old_records = furthest_records(range)
    records = old_records.first
    sum_value(records) / range
  end

  

  
  
    end
  end
end
