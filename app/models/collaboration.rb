class Collaboration < ActiveRecord::Base
  belongs_to :strategy
  belongs_to :user

  scope :pending, -> (user) do
    self.where(user: user, confirmed: nil)
  end

  scope :approved, -> (user) do
    self.where(user: user, confirmed: true)
  end

  scope :declined, -> (user) do
    self.where(user: user, confirmed: false)
  end

  scope :pending?, -> (strategy, user) do
    self.where(strategy: strategy, user: user, confirmed: nil)
  end

  scope :approved?, -> (strategy, user) do
    self.where(strategy: strategy, user: user, confirmed: true)
  end

  scope :declined?, -> (strategy, user) do
    self.where(strategy: strategy, user: user, confirmed: false)
  end
end
