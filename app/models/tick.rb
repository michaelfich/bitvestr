class Tick < ActiveRecord::Base
  def ma(range)
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
  def last_records(range, interval=1)
    current_tick = Tick.where(id: self.id..Tick.last.id).count - 1

    ticks = Tick.order(id: :desc).offset(current_tick).limit(range * interval)

    result = []
    ticks.each.with_index do |tick, index|
      if index % interval == 0
        result << tick
      end
    end
    result
  end

  def all_prices(range, interval=1)
    records = last_records(range, interval)
    prices = []
    records.each do |tick|
      prices << tick.last_price
    end
    prices
  end
end