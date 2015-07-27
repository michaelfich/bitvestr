class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :strategies

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
