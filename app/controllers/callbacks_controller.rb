class CallbacksController < ApplicationController
  def index
    @event = params
    render json: @event, status: 200
  end
end
