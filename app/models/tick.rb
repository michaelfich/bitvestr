class Tick < ActiveRecord::Base
  def less_than(start, finish)
    self.moving_avg(start) < self.moving_avg(finish)
  end

  def moving_avg(range)
    records = last_records(range)
    sum_value(records) / range
  end

  private
  def last_records(range)
    offset = Tick.where(id: self.id..Tick.last.id).count - 1
    Tick.order("id DESC").offset(offset).limit(range)
  end

  def sum_value(ticks)
    ticks.inject(0) do |total, tick|
      total += tick.last_price
    end
  end
end
