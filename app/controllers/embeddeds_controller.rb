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
      :template_id => '60266b319ca6f27c1da5899369883d5e29408a76',
      :message => 'Glad we could come to an agreement.',
      :signers => [
          {
              :email_address => "#{email}",
              :name => "#{name}",
              :role => 'Dispensary Owner or Manager'
          },
          {
              :email_address => "ceo@example.com",
              :name => "CEO ROle",
              :role => 'WoahStork CEO'
          }
      ],
      :custom_fields => [
      ]
    )

    signatures = request.signatures
    p "*****"
    p signatures[0].signature_id

    url_request = client.get_embedded_sign_url :signature_id => signatures[0].signature_id

    @sign_url = url_request.sign_url
  end

  def file_request

  end

  def unclaimed_draft
    @request = client.create_unclaimed_draft(
        :test_mode => 1,
        :file => 'images/sales_contract.pdf'
    )

    p @request
  end

  def unclaimed_draft_template
  end

  def template_draft
  end

  def edit_unclaimed_draft
    @draft = client.edit_and_resend_unclaimed_draft(
      :signature_request_id => '596e1b9288c7c726c603fc3080689e6c89c1a397',
      :client_id => ENV['CLIENT_ID'],
      :test_mode => true
    )
    p "***"
    p @draft.claim_url
  end

end
