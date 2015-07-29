class TicksController < ApplicationController
  def index
   render json: Tick.last(50).to_json
  end
end
