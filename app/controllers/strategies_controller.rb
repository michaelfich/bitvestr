class StrategiesController < ApplicationController
  def index
    @strategies = if current_user
      Strategy.where(user: current_user)
    end
  end
end
