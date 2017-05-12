class SignsController < ApplicationController

  def index
    client = Sign.initiate_client
    @signatures = client.get_signature_requests :page => 1
  end

end
