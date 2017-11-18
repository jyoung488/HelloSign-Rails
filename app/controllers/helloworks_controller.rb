class HelloworksController < ApplicationController
  skip_before_action :verify_authenticity_token

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

  end

  def new_instance
    response = HTTParty.get('https://api.helloworks.com/v2/token/HwraymrpuUIvwQd3', headers: { "Authorization" => "Bearer #{ENV['HW_KEY']}", "cache-control" => "no-cache" })
    data = JSON.parse(response.to_json, symbolize_names: true)
    token = data[:object][:value]

    request = HTTParty.post("https://api.helloworks.com/v2/view/tKyC6RWS9TA1zqWo/instance",
      headers: {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/x-www-form-urlencoded"
    },
      body: {
        "identity[type]" => "email",
        "identity[value]" => ENV["EMAIL"],
        "identity[verification]" => "link",
        "identity[full_name]" => "HelloWorks Test",
        "settings[callback_url]" => "https://2d64d5c6.ngrok.io/helloworks"
        }
      )

    p request
    url = request["object"]["url"]
    p url
    redirect_to url
  end
end
