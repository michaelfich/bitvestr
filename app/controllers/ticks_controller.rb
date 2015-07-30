class TicksController < ApplicationController
  def index
    render json: Tick.all.limit(120).to_json
  end
end
