class EmbeddedsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def template
    client = Embedded.initiate_client
    event = client.create_embedded_signature_request_with_template(
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

    response_object = JSON.parse(event.to_json, symbolize_names: true)

    signature_id = response_object[:raw_data][:signatures][0][:signature_id]
  end
end
