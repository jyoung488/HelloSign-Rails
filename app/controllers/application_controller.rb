class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :client

  private

  def client
    client = ApplicationRecord.initiate_client
  end
end
