class EmbeddedsController < ApplicationController
  def index
  end

  def template
  end

  def file_request
  end

  def unclaimed_draft
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
