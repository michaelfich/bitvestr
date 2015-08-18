Formula.destroy_all
Formula.create(name: "sma", abbreviation: "SMA", full_name: "Simple Moving Average", order_number: 1)
Formula.create(name: "ema", abbreviation: "EMA", full_name: "Exponential Moving Average", order_number: 2)
Formula.create(name: "macd", abbreviation: "MACD", full_name: "Moving Average Convergence Divergence", order_number: 3)
Formula.create(name: "rsi", abbreviation: "RSI", full_name: "Relative Strength Index", order_number: 4)

User.destroy_all
User.create(
  first_name: "michael",
  last_name: "fich",
  email: 'michael@michaelfich.com',
  password: '1234',
  password_confirmation: '1234'
)