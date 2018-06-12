class TemplatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_template
    @template = client.get_template :template_id => params[:template_id]
  end

  def update
    @template = client.update_template_files(
      :template_id =>'1edd04e79d173f80d164444e0503e73621a60838',
      :files => ['/Users/jenyoung/Documents/Testing/Rails-Test/app/assets/exampledoc.pdf'],
      :message => 'updated using new endpoint!',
      :client_id => "513c9bcded6de4e70ffca114573540d9"
    )
    p @template
  end

  def list
    list = client.get_templates

    p list

    @templates = list.first


    render json: @templates
  end

  def add_access
    @template = client.add_user_to_template :template_id => params[:template_id], :email_address => params[:email]
  end

  def remove_access
    @template = client.remove_user_from_template :template_id => params[:template_id], :email_address => params[:email]
  end

  def delete
    @template = client.delete_template :template_id => params[:template_id]
  end

  def download
    @template = client.get_template_files :template_id => params[:template_id]
  end

end
