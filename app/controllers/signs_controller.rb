class SignsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index

    # @response = params
    # event = @response["json"]
    # object = JSON.parse(event, symbolize_names: true)
    # p "***** EVENT TYPE"
    # p event_type = object[:event][:event_type]

    # client = Sign.initiate_client
  end


  def account
    client = Sign.initiate_client
    @account = client.get_account
  end

  def signature_request
    client = Sign.initiate_client

    request = client.get_signature_request :signature_request_id => params[:request_id]
    render json: request
  end

  def all_requests
    client = Sign.initiate_client
    @signatures = client.get_signature_requests

    render json: @signatures
  end

  def send_request
    client = Sign.initiate_client
    response = client.send_signature_request(
      :test_mode => 1,
      :title => 'Test Contract',
      :subject => 'Test Signature Request',
      :message => 'This is a test from my Rails app',
      :signers => [
        {
          :email_address => 'jen.young@hellosign.com',
          :name => 'Jen',
          :order => 0
        }
        ],
    #   :form_fields_per_document => [
    #     [
    #         {
    #             "api_id": "uniqueIdHere_1",
    #             "name": "",
    #             "type": "text",
    #             "x": 112,
    #             "y": 328,
    #             "width": 100,
    #             "height": 16,
    #             "required": true,
    #             "signer": 1,
    #             "page": 1,
    #             "validation_type": "numbers_only"
    #         },
    #         {
    #             "api_id": "uniqueIdHere_2",
    #             "name": "",
    #             "type": "signature",
    #             "x": 530,
    #             "y": 415,
    #             "width": 120,
    #             "height": 30,
    #             "required": true,
    #             "signer": 0,
    #             "page": 1
    #         }
    #     ]
    # ],
      :file_url => 'http://www.pdf995.com/samples/pdf.pdf'
    )

    data = JSON.parse(response.to_json, symbolize_names: true)
    id = data[:raw_data][:signatures][0][:signature_id]
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

  def update_email
    # client = Sign.initiate_client
    # client.update_signature_request(
    #     :signature_request_id => params[:signature_request_id],
    #     :signature_id => params[:signature_id],
    #     :email_address => params[:email]
    #     )
  end

  def cancel
    client = Sign.initiate_client
    client.cancel_signature_request :signature_request_id => params[:request_id]

    redirect_to root_path
  end

  def file
    client = Sign.initiate_client
    file_bin = client.signature_request_files :signature_request_id => params[:request_id], :get_url => true
    File.open("files.zip", "wb") do |file|
      file.write(file_bin)
    end
  end



end
