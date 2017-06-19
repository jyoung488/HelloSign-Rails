class CallbacksController < ApplicationController
  def index
    @event = params["json"]
  end
end
