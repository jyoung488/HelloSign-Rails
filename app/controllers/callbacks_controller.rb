class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @event = JSON.parse(params.to_json, symbolize_names: true)
  end

  def create
    event = JSON.parse(params["json"], symbolize_names: true)
    # event = @response["json"]
    # object = JSON.parse(event, symbolize_names: true)
    # p "***** EVENT TYPE"
    # p event_type = object[:event][:event_type]

    # client = Sign.initiate_client

    event_type = event[:event][:event_type]

  end
end
