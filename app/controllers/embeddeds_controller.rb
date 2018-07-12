class EmbeddedsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :client

  def index
  end

  def template
    email = "george@example.com"
    name = "George",
    role = "Dispensary Owner or Manager"
    request = client.create_embedded_signature_request_with_template(
      :test_mode => 1,
      :client_id => ENV['CLIENT_ID'],
      :template_id => '75483a9f0674c1b23fbc42ae8006a0b73fd36736',
      :file_url => 'http://www.pdf995.com/samples/pdf.pdf',
      :allow_decline => 1,
      :message => 'Glad we could come to an agreement.',
      signers: [
          {
              email_address: "#{email}",
              name: "#{name}",
              role: 'Client'
          }
      ],

      :custom_fields => [
        {
          name: "Address",
          value: "123 Main St."
        }
      ]
    )
    p request
    signatures = request.signatures

    url_request = client.get_embedded_sign_url :signature_id => signatures[0].signature_id
    p "****"
    p url_request
    @sign_url = url_request.sign_url
  end

  def file_request
    request = client.create_embedded_signature_request(
      :test_mode => 1,
      :client_id => ENV['CLIENT_ID'],
      :subject => 'test subject',
      :message => 'Rails Embedded Signature Request',
      :signers => [
        {
          :email_address => 'jyoung488@gmail.com',
          :name => 'Jen Rails'
        }
      ],
      :use_text_tags => 1,
      :hide_text_tags => 1,
      :files => ['public/Text_Tags_Merge.pdf'],
      :custom_fields => [
        {"name": "address", "value": "PSYDUCK"}
      ]
      # :files => ['/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc1.pdf', '/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/doc2.pdf']
      # :file_url => 'http://www.pdf995.com/samples/pdf.pdf'
    )

    p request

    signatures = request.signatures

    url_request = client.get_embedded_sign_url :signature_id => signatures[0].signature_id
    @sign_url = url_request.sign_url
  end

  def unclaimed_draft
    request = client.create_embedded_unclaimed_draft(
        test_mode: 1,
        # :file_url => 'http://www.pdf995.com/samples/pdf.pdf',
        client_id: ENV['CLIENT_ID'],
        files: ['public/Text_Tags_Merge.pdf'],
        signers: [
          {
            'email_address' => ENV["EMAIL"],
            'name' => 'Jen'
          },
          {
            'email_address' => "jen@test.com",
            'name' => "Jen Second Signer",
          }
        ],
        subject: 'Your signature is required',
        requester_email_address: ENV['EMAIL'],
        :type => "request_signature",
        # :custom_fields => [
        #   {"name": "address", "value": "PSYDUCK"}
        # ],
        # :use_text_tags => 1
        # :form_fields_per_document => [
          #   [{
          #     "api_id": "test",
          #     "name": "hi",
          #     "type": "signature",
          #     "x": 0,
          #     "y": 52,
          #     "height": 30,
          #     "width": 20,
          #     "required": true,
          #     "signer": 0,
          #     "page": 1
          #   }]
          # ]
    )

    @sign_url = request.claim_url
  end

  def unclaimed_draft_template
    request = client.create_embedded_unclaimed_draft_with_template(
      :test_mode => 1,
      :client_id => ENV['CLIENT_ID'],
      :requester_email_address => ENV['EMAIL'],
      :template_id => '1159636818bce0549c40d3477a937da0abb1b92a',
      :message => 'Glad we could come to an agreement.',
      :signers => [
          {
              :email_address => "jyoung488@gmail.com",
              :name => "Jen Test",
              :role => "Client"
          }
      ],
      # :custom_fields => [
      #   {
      #     :name => "Name",
      #     :value => "SDK TEST"
      #   }
      # ]
    )

    @sign_url = request.claim_url
  end

  def template_draft
    request = client.create_embedded_template_draft(
      :test_mode => 1,
      :client_id => ENV['CLIENT_ID'],
      :file_url => 'http://www.pdf995.com/samples/pdf.pdf',
      :title => 'Embedded Template Draft from Rails',
      :signer_roles => [
        {
          :name => 'Cient',
          :order => 0
        },
        {
          :name => 'Manager',
          :order => 1
        }
      ]
    )

    @sign_url = request.edit_url
  end

  def edit_unclaimed_draft
    @draft = client.edit_and_resend_unclaimed_draft(
      :signature_request_id => '596e1b9288c7c726c603fc3080689e6c89c1a397',
      :client_id => ENV['CLIENT_ID'],
      :test_mode => true
    )
    p "***"

    @sign_url = @draft.claim_url
  end

end
