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

    response_object = JSON.parse(signature_event.to_json, symbolize_names: true)

    signature_id = response_object[:raw_data][:signatures][0][:signature_id]

    get_url = client.get_embedded_sign_url :signature_id => signature_id

    url_response = JSON.parse(get_url.to_json, symbolize_names: true)

    @sign_url = url_response[:raw_data][:sign_url]
  end
end
