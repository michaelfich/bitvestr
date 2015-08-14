class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :profile
  has_many :strategies

  validates :password, length: { minimum: 4 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :first_name, presence: true
  # validates :first_name, length: { minimum: 2, maximum, 20 }

  validates :last_name, presence: true
  # validates :last_name, length: { minimum: 2, maximum, 20 }
end
