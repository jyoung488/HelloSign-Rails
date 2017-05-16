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

  def send_request
    client = Sign.initiate_client
    client.send_signature_request(
      :test_mode => 1,
      :title => 'Test Contract',
      :subject => 'Test Signature Request',
      :message => 'This is a test from my Rails app',
      :signers => [
        {
          :email_address => 'jyoung488@gmail.com',
          :name => 'Jen',
          :order => 0,
        }
        ],
      :file_url => 'http://hrcouncil.ca/docs/samplecontract.pdf'
    )
    flash[:notice] = "Request sent"
    redirect_to root_path
  end

  def template_request
    client = Sign.initiate_client
    client.send_signature_request_with_template(
        :test_mode => 1,
        :template_id => 'feb796545f869222c6bd67a6eb276a7573700704',
        :subject => 'Offer Letter',
        :message => 'Glad we could come to an agreement.',
        :signers => [
            {
                :email_address => 'jyoung488@gmail.com',
                :name => 'Jen Candidate',
                :role => 'Candidate'
            },
            {
                :email_address => 'jyoung488+1@gmail.com',
                :name => 'Jen Hiring Manager',
                :role => 'Hiring Manager'
            }
        ],
        :custom_fields =>
            {
                :Salary => '$10,000',
            }
    )
    flash[:notice] = "Request sent"
    redirect_to root_path
  end

  def reminder
    client = Sign.initiate_client
    client.remind_signature_request :signature_request_id => params[:signature_id], :email_address => params[:email]
    redirect_to root_path
  end

end
