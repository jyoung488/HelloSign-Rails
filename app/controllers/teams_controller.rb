class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @team = client.get_team
  end

  def new
    @team = client.create_team :name => params[:name]
  end

  def update
    @team = client.update_team :name => params[:name]
  end

  def add_user
    @team = client.add_member_to_team :email_address => params[:email]
  end
end
