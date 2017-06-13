class EmbeddedsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def template
    client = Embedded.initiate_client
    signature_event = client.create_embedded_signature_request_with_template(
      test_mode: 1,
      client_id: ENV['CLIENT_ID'],
      template_id: 'e918bf31ce40b1a66b593992a9ebfcfde2c72648',
      signers: [
        {
          email_address: 'jen.young+1@hellosign.com',
          name: 'Jen Test',
          role: 'Client'
        }
      ]
    )

    @sign_url = render_url(signature_event)
  end

  def file_request
    client = Embedded.initiate_client
    file = params[:file]

    signature_event = client.create_embedded_signature_request(
      test_mode: 1,
      client_id: ENV['CLIENT_ID'],
      subject: 'Embedded Signature Request with File',
      message: 'Hey!',
      signers: [
        {
          email_address: 'jen.young+1@hellosign.com',
          name: 'Jen Test'
        }
      ],
      files: file
    )

    @sign_url = render_url(signature_event)
  end

  def unclaimed_draft
    client = Embedded.initiate_client
    file = params[:file]

    signature_event = client.create_embedded_unclaimed_draft(
      test_mode: 1,
      client_id: ENV['CLIENT_ID'],
      type: 'request_signature',
      subject: 'Embedded Unclaimed Draft',
      requester_email_address: 'jen.young@hellosign.com',
      files: file,
      is_for_embedded_signing: 1
    )

    @sign_url = render_url(signature_event)
  end

  def unclaimed_draft_template
    client = Embedded.initiate_client

    signature_event = client.create_embedded_unclaimed_draft_with_template(
      test_mode: 1,
      client_id: ENV['CLIENT_ID'],
      template_id: 'e918bf31ce40b1a66b593992a9ebfcfde2c72648',
      requester_email_address: 'jen.young@hellosign.com',
      signing_redirect_url: 'http://www.google.com',
      requesting_redirect_url: 'http://www.google.com',
      signers: [
        {
          email_address: 'jen.young+1@hellosign.com',
          name: 'Jen Test',
          role: 'Client'
        }
      ]
    )

    response = JSON.parse(signature_event.to_json, symbolize_names: true)
    @sign_url = response[:raw_data][:claim_url]
  end

  def template_draft
    client = Embedded.initiate_client
    file = params[:file]

    request = client.create_embedded_template_draft(
      test_mode: 1,
      client_id: ENV['CLIENT_ID'],
      file_url: 'http://www.pdf995.com/samples/pdf.pdf',
      title: 'Test title',
      subject: 'test subject',
      message: 'test message',
      signer_roles: [
        {
          name: 'Client',
          order: 0
        },
        {
          name: 'Client 2',
          order: 1
        }
      ],
      merge_fields: '[
        {
          "name":"Test Merge",
          "type":"text"
        },
        {
          "name":"Test Merge 2",
          "type":"text"
        }]'
    )

    p request
    p "*****"
    p request.data['template_id']
    @sign_url = request.data['edit_url']
  end

  private

  def render_url(response)
    client = Embedded.initiate_client

    response_object = JSON.parse(response.to_json, symbolize_names: true)
    signature_id = response_object[:raw_data][:signatures][0][:signature_id]

    get_url = client.get_embedded_sign_url :signature_id => signature_id

    url_response = JSON.parse(get_url.to_json, symbolize_names: true)
    url_response[:raw_data][:sign_url]
  end
end
