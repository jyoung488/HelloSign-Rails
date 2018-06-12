class AppsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def info
    app = client.get_api_app :client_id => params[:client_id]

    render json: app
  end

  def list
    app_list = client.get_api_apps :page => 2
    p app_list.headers

    render json: app_list
  end

  def create

    white_labeling = {
      "primary_button_color":"#778899",
      "primary_button_text_color":"#ffffff"
    }

    app = client.create_api_app(
      :name => params[:app_name],
      :domain => 'www.rubyonrails.com',
      :white_labeling_options => white_labeling.to_json
    )

    render json: app
  end

  def update
    app = client.update_api_app(
      :name => params[:app_name],
      :client_id => params[:client_id]
    )

    render json: app
  end

  def delete
    client.delete_api_app :client_id => params[:client_id]

    flash[:notice] = "App deleted!"
    redirect_to root_path
  end
end
