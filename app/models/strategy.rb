class Strategy < ActiveRecord::Base
  belongs_to :user
  has_many :indicators

  accepts_nested_attributes_for :indicators, reject_if: :all_blank, allow_destroy: true

  validates :period, numericality: { only_integer: true, greater_than: 0 }
end
