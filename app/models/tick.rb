class Tick < ActiveRecord::Base


  def moving_avg(range)
    x = Indicators::Data.new(all_prices(range))
    y = x.calc(:type => :sma, :params => range).output
    y.last
  end

  def ema(range)
    x = Indicators::Data.new(all_prices(range))
    y = x.calc(:type => :ema, :params => range).output
    y.last
  end

  def macd(fast_period, slow_period, signal)
    x = Indicators::Data.new(all_prices(slow_period))
    y = x.calc(:type => :macd, :params => [fast_period, slow_period, signal]).output
    y.last
  end

  def rsi(range)
    x = Indicators::Data.new(all_prices(range))
    y = x.calc(:type => :rsi, :params => range).output
    y.last
  end


  # def vwap(array)



  # def atr(array)
  

  # def sar(array)
 

  # def mfi(array)
 

  # def aroon(array)
 


private

  def last_records(range)
    offset = Tick.where(id: self.id..Tick.last.id).count - 1
    Tick.order("id DESC").offset(offset).limit(range)
  end

  def all_prices(range)
    records = last_records(range)
    prices = []
    records.each do |tick|
      prices << tick.last_price
    end
    prices
  end


end
