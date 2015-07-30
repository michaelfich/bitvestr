class TicksController < ApplicationController
  def index
    render json: Tick.last(120).to_json
  end
end
