class Tick < ActiveRecord::Base


  def moving_avg(range)
    x = Indicators::Data.new(all_prices)
    y = x.calc(:type => :sma, :params => range).output
    y.last
  end

  def exponential_moving_avg(range)
    x = Indicators::Data.new(all_prices)
    y = x.calc(:type => :ema, :params => range).output
    y.last
  end

  def macd(fast_period, slow_period, signal)
    x = Indicators::Data.new(all_prices)
    y = x.calc(:type => :macd, :params => [fast_period, slow_period, signal]).output
    y.last
  end

  def rsi(range)
    x = Indicators::Data.new(all_prices)
    y = x.calc(:type => :rsi, :params => range).output
    y.last
  end

  # def vwap(array)


  # def macd(array)


  # def atr(array)
  

  # def sar(array)
 

  # def mfi(array)
 

  # def aroon(array)
  

private

  def all_prices
    prices = []
    Tick.all.each do |tick|
      prices << tick.last_price
    end
    prices
  end


  

end
