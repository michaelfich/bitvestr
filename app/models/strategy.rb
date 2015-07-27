class Strategy < ActiveRecord::Base
  belongs_to :user
  has_many :indicators
end
