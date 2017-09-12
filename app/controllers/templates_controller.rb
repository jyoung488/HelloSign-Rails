class TemplatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    @template = client.update_template_files :template_id =>'74cb63b17da0bc1541dbb6c4f6b2f10004ef0492', :file_url => 'http://che.org.il/wp-content/uploads/2016/12/pdf-sample.pdf', :message => 'updated using new endpoint!'
  end
end
