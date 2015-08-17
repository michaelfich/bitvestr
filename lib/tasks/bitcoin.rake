require 'open-uri'
require 'json'

namespace :bitcoin do
  # whenever --set environment=development --update-crontab
  desc "Queries the Bitstamp.net API to get the current value of bitcoin and save it as a Tick"
  task get: :environment do
    bitcoin = HTTParty.get('https://www.bitstamp.net/api/ticker/')

    tick_params = {
      last_price: bitcoin['last'],
      volume: bitcoin['volume'],
      datetime: Time.now.utc
    }

    Tick.create(tick_params)
  end

  desc "Seed the Tick table of the database with daily Bitcoin valuations from the past 3 years"
  task seed: :environment do
    def formatDate(date)
      return date.strftime("%Y-%m-%d")
    end

    end_date = Date.today
    start_date = end_date - 3.years

    api = "http://api.coindesk.com/v1/bpi/historical/close.json?start=#{start_date}&end=#{end_date}"

    data = JSON.parse( open(api).read )
    data = data["bpi"]

    Tick.destroy_all if Tick.count > 0

    data.each do |date, value|
      Tick.create(datetime: date, last_price: value)
    end
  end
end
