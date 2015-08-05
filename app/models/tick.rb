class Tick < ActiveRecord::Base

  # def sma(array)
  #   array.sum / array.count
  # end

  # def ema(array)
  #   multiplier =  2 / (array.sum + 1)
  #   # array.last  
  # end

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
end
