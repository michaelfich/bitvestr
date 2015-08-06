class TicksController < ApplicationController
  def index
    if count = params[:count]
      render json: Tick.last(count).to_json
    else
      render json: Tick.last(120).to_json
    end
  end
end
