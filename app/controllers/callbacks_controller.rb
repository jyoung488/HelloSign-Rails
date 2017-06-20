class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @event = JSON.parse(params.to_json, symbolize_names: true)
  end

  def create
    event = JSON.parse(params["json"], symbolize_names: true)
    event_type = event[:event][:event_type]
    id = event[:signature_request][:signature_request_id]

    return "Hello API event received" if event_type == "callback_test"
    
    case event_type
    when "signature_request_sent"
      Sign.create(signature_request_id: id,
        status: 'Sent')
    when "signature_request_viewed"
      Sign.find_by(signature_request_id: id,
          status: 'Viewed')
    when "signature_request_all_signed"
      Sign.find_by(signature_request_id: id,
        status: 'All signed')
    when "signature_request_declined"
      Sign.find_by(signature_request_id: id,
        status: 'Declined')
    end
  end
end
