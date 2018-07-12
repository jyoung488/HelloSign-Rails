class HelloworksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    response = HTTParty.get('https://api.helloworks.com/v3/token/AUkXNTxDHGtr2zRn', headers: { "Authorization" => "Bearer #{ENV['HW_KEY']}", "cache-control" => "no-cache" })
    data = JSON.parse(response.to_json, symbolize_names: true)
    token = data[:object][:value]

    p data
    urls = []

    req = JSON.parse(request.raw_post, symbolize_names: true)

    p req
    # req[:forms].each do |form|
    #   urls << form[:document][:url]
    # end


    urls.each_with_index do |url, index|
      file = HTTParty.get(url, headers: { "Authorization" => "Bearer #{token}", "cache-control" => "no-cache" })
      File.open("../../HW-doc-#{index}.pdf", "wb+") { |f|
        f.write(file)
      }
    end

  end

  def new_instance
    response = HTTParty.get('https://api.helloworks.com/v3/token/AUkXNTxDHGtr2zRn', headers: { "Authorization" => "Bearer #{ENV['HW_KEY']}", "cache-control" => "no-cache" })
    data = JSON.parse(response.to_json, symbolize_names: true)
    token = data[:object][:value]

    p response

    request = HTTParty.post("https://api.helloworks.com/v3/view/fons6pkRW8qasrwb/instance",
      headers: {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/x-www-form-urlencoded"
    },
      body: {
        "identity[type]" => "email",
        "identity[value]" => ENV["EMAIL"],
        "identity[verification]" => "code",
        "identity[full_name]" => "HelloWorks Test",
        "settings[callback_url]" => "https://45e3a0ab.ngrok.io/helloworks"
      }
      )

    url = request["object"]["url"]
    p url
    redirect_to url
  end

  def v3_instance
    response = HTTParty.get('https://api.helloworks.com/v3/token/AUkXNTxDHGtr2zRn', headers: { "Authorization" => "Bearer #{ENV['HW_KEY']}", "cache-control" => "no-cache" })
    data = JSON.parse(response.to_json, symbolize_names: true)
    token = data[:object][:value]

    p response

    request = HTTParty.post("https://api.helloworks.com/v3/workflow/fons6pkRW8qasrwb/instance",
      headers: {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/x-www-form-urlencoded"
    },
      body: {
        "participants[signer][type]" => "email",
        "participants[signer][value]" => ENV["EMAIL"],
        "participants[signer][full_name]" => "HelloWorks Test",
        "settings[global][callback_url]" => "https://45e3a0ab.ngrok.io/helloworks"
      }
      )

    p request
  end
end
