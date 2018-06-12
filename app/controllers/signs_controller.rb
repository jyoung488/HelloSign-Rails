class SignsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :client

  def index

    # @response = params
    # event = @response["json"]
    # object = JSON.parse(event, symbolize_names: true)
    # p "***** EVENT TYPE"
    # p event_type = object[:event][:event_type]

    # client = Sign.initiate_client
  end

  def signature_request
    request = client.get_signature_request :signature_request_id => params[:request_id]
    data = JSON.parse(request.to_json, symbolize_names: true)
    id = data[:raw_data][:signatures][0][:signature_id]
    render json: request
  end

  def all_requests
    @signatures = client.get_signature_requests
    # @headers = @signatures.headers
    # p @signatures
    render json: @signatures
  end

  def send_request
    # file = File.join(Rails.root, 'app', 'text_tag.pdf')

    response = client.send_signature_request(
      :test_mode => 1,
      :title => 'Test Contract',
      :subject => 'Test Signature Request',
      :message => 'This is a test from my Rails app',
      :signers => [
        {
          :email_address => ENV["EMAIL"],
          :name => 'Jen'
        }
      ],
      :use_text_tags => 1,
      # :hide_text_tags => 1,
    #   :files => ['/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc1.pdf', '/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc2.pdf']
    # )
      # :form_fields_per_document => [
      #   	[{
      #   		"api_id": "test",
      #   		"name": "hi",
      #   		"type": "signature",
      #   		"x": 0,
      #   		"y": 52,
      #   		"height": 30,
      #   		"width": 20,
      #   		"required": true,
      #   		"signer": 0,
      #   		"page": 1
      #   	}],
      #     [{
      #       "api_id": "secondDoc",
      #       "name": "secondPage",
      #       "type": "text",
      #       "x": 50,
      #       "y": 52,
      #       "height": 30,
      #       "width": 20,
      #       "required": true,
      #       "signer": 0,
      #       "page": 1
      #     }]
      #   ],
        :files => ['public/Text_Tags_Merge.pdf'],
        :custom_fields => [
          {"name": "address", "value": "PSYDUCK"}
        ]
        # :file_urls => ['http://www.pdf995.com/samples/pdf.pdf', 'http://www.africau.edu/images/default/sample.pdf']
    )


    data = JSON.parse(response.to_json, symbolize_names: true)
    id = data[:raw_data][:signatures][0][:signature_id]

    p id
    #
    render json: response
  end

  def template_request
    request = client.send_signature_request_with_template(
        :test_mode => 1,
        :template_id => '51d63d2b4c9f4740e6096e5100df26a82a02612b',
        :subject => 'Offer Letter',
        :message => 'Glad we could come to an agreement.',
        :signers => [
            # {
            #     :email_address => 'jyoung488@gmail.com',
            #     :name => 'Jen Candidate',
            #     :role => 'Candidate'
            # },
            {
                :email_address => 'jyoung488+1@gmail.com',
                :name => 'Jen Hiring Manager',
                :role => 'Hiring Manager'
            }
        ]
      # :files => ['/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc1.pdf', '/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc2.pdf']

    )
    p request.warnings
    flash[:notice] = "Request sent"
    redirect_to root_path
  end

  def reminder
    client.remind_signature_request :signature_request_id => params[:signature_id], :email_address => params[:email]

    redirect_to root_path
  end

  def update_email
    client.update_signature_request(
        :signature_request_id => '33e7a1d839e98797d633fb8b47247c4aa9a5936d',
        :signature_id => '5064ca698bde9581ad75f6d62450eb4b',
        :email_address => 'jen.young+1@hellosign.com'
        )
  end

  def cancel
    client.cancel_signature_request :signature_request_id => params[:request_id]

    redirect_to root_path
  end

  def file
    file_bin = client.signature_request_files :signature_request_id => params[:request_id], :file_type => 'zip'

    File.open("without-attachment.zip", "wb") do |file|
      file.write(file_bin)
    end
  end

  def unclaimed_draft
    draft = client.create_unclaimed_draft(
      test_mode: 1,
      type: 'request_signature',
      # file_url: 'http://www.pdf995.com/samples/pdf.pdf',
      signers: [
          email_address: 'jen.young+2@hellosign.com',
          name: "Ruby HelloSign",
      ],
      :files => ['public/Text_Tags_Merge.pdf'],
      :custom_fields => [
        {"name": "address", "value": "PSYDUCK"}
      ],
      :use_text_tags => 1
      # form_fields_per_document: [
      #   [
      #     {
      #       "api_id": "uniqueID",
      #       "name": "TextFieldName",
      #       "type": "signature",
      #       "x": 30,
      #       "y": 52,
      #       "height": 30,
      #       "width": 100,
      #       "required": true,
      #       "signer": 0,
      #       "page": 1
      #     }
      #   ]
      # ]
    )

    redirect_to draft.claim_url
  end

end
