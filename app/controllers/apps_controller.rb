class AppsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def info
    client = App.initiate_client

    app = client.get_api_app :client_id => params[:client_id]

    render json: app
  end
end
