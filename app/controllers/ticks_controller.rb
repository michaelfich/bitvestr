class TicksController < ApplicationController
  def index
    count = if params['count']
      params['count']
    else
      100
    end

   render json: Tick.last(count).to_json
  end
end
