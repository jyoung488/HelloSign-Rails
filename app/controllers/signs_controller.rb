class SignsController < ApplicationController

  def index
    client = Sign.initiate_client
  end

  def account
    client = Sign.initiate_client
    @account = client.get_account
  end

  def signature_request
    client = Sign.initiate_client
    request = client.get_signature_request :signature_request_id => 'bb00fafdac12fd2dd61eca7be23a839f24302dd3'
    render json: request
  end

  def all_requests
    client = Sign.initiate_client
    @signatures = client.get_signature_requests :page_size => 2
  end

end
