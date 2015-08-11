require 'open-uri'
require 'json'

def formatDate(date)
  return date.strftime("%Y-%m-%d")
end

end_date = Date.today
start_date = end_date - 3.years

api = "http://api.coindesk.com/v1/bpi/historical/close.json?start=#{start_date}&end=#{end_date}"

data = JSON.parse( open(api).read )
data = data["bpi"]

Tick.destroy_all

data.each do |date, value|
  Tick.create(datetime: date, last_price: value)
end

Formula.create(name: "moving_avg", display: "MA (Moving Average)") if Formula.count < 1
Formula.create(name: "ema", display: "EMA (Exponential Moving Average)") if Formula.count < 2
Formula.create(name: "macd", display: "MACD (Moving Average Convergence Divergence)") if Formula.count < 3
Formula.create(name: "rsi", display: "RSI (Relative Strength Index)") if Formula.count < 4
