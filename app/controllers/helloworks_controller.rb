class HelloworksController < ApplicationController
  skip_before_action :verify_authenticity_token
  include SendGrid

  def index
  end

  def create
    event = params.to_s
    email = send_email(event)
    p email.status_code
  end

  private

  def send_email(data)
    from = Email.new(email: 'test@example.com')
    to = Email.new(email: 'jen.young@hellosign.com')
    subject = 'Your HelloWorks Info'
    content = Content.new(type: 'text/plain', value: data)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
