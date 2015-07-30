class TicksController < ApplicationController
  def index
    count = params[:count] || 120
    render json: Tick.last(count).to_json
  end
end
