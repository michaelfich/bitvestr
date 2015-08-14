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

if Formula.count < 1
  Formula.create(
    name: "ma",
    abbreviation: "SMA",
    full_name: "Moving Average",
    order_number: 1
  )
end
if Formula.count < 2
  Formula.create(
    name: "ema",
    abbreviation: "EMA",
    full_name: "Exponential Moving Average",
    order_number: 2
  )
end
if Formula.count < 3
  Formula.create(
    name: "macd",
    abbreviation: "MACD",
    full_name: "Moving Average Convergence Divergence",
    order_number: 3
  )
end
if Formula.count < 4
  Formula.create(
    name: "rsi",
    abbreviation: "RSI",
    full_name: "Relative Strength Index",
    order_number: 4
  )
end