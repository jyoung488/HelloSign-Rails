class TemplatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_template
    @template = client.get_template :template_id => params[:template_id]
  end

  def update
    @template = client.update_template_files :template_id =>'74cb63b17da0bc1541dbb6c4f6b2f10004ef0492', :file_url => 'http://che.org.il/wp-content/uploads/2016/12/pdf-sample.pdf', :message => 'updated using new endpoint!'
  end

  def list
    @templates = client.get_templates(
      :page_size => 1,
      :page => 1
    )

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
