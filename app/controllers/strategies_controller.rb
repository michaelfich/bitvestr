class StrategiesController < ApplicationController
  before_filter :require_login

  def index
    @strategies = if current_user
      Strategy.where(user: current_user)
    end
  end
end
