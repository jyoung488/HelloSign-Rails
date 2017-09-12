class App < ApplicationRecord
    def self.initiate_client
      HelloSign::Client.new :api_key => ENV['HS_KEY']
    end
end
