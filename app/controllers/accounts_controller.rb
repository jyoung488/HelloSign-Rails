class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_account
    @account = client.get_account
  end

  def update_account
    @account = client.update_account :callback_url => params[:callback_url]
  end

  def verify_account
    @account = client.verify :email_address => params[:email]
  end
end
