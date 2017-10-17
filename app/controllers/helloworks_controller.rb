class HelloworksController < ApplicationController
  skip_before_action :verify_authenticity_token
  include SendGrid

  def index
  end

  def create
    response = HTTParty.get('https://api.helloworks.com/v2/token/HwraymrpuUIvwQd3', headers: { "Authorization" => "Bearer #{ENV['HW_KEY']}", "cache-control" => "no-cache" })
    data = JSON.parse(response.to_json, symbolize_names: true)
    token = data[:object][:value]
    
    urls = []

    req = JSON.parse(request.raw_post, symbolize_names: true)
    req[:forms].each do |form|
      urls << form[:document][:url]
    end


    urls.each_with_index do |url, index|
      file = HTTParty.get(url, headers: { "Authorization" => "Bearer #{token}", "cache-control" => "no-cache" })
      File.open("../../HW-doc-#{index}.pdf", "wb+") { |f|
        f.write(file)
      }
    end

    # sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])
    # from = Email.new(email: 'test@example.com')
    # to = Email.new(email: 'jen.young@hellosign.com')
    # subject = 'Your HelloWorks Info'
    # content = Content.new(type: 'text/plain', value: "hey")
    #
    # mail = Mail.new(from, subject, to, content)
    # email = sg.client.mail._('send').post(request_body: mail.to_json)
    # p email.status_code

  end

end
