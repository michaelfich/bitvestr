class Indicator < ActiveRecord::Base
  belongs_to :strategy
  validates :period, numericality: { only_integer: true, greater_than: 0 }

  COMPARATORS = [">=", ">", "=", "<", "<="]
end
