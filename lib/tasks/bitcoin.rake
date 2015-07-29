namespace :bitcoin do
  desc "TODO"
  task get: :environment do
    bitcoin = HTTParty.get('https://www.bitstamp.net/api/ticker/')

    tick_params = {
      last_price: bitcoin['last'],
      volume: bitcoin['volume'],
      datetime: Time.now.utc
    }

    Tick.create(tick_params)
  end

end
