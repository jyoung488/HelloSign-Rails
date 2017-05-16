Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'signs#index'

  get 'account' => 'signs#account'
  get 'signature-request' => 'signs#signature_request'
  get 'all-requests' => 'signs#all_requests'
  get 'send-request' => 'signs#send_request'
  get 'template-request' => 'signs#template_request'
  post 'reminder' => 'signs#reminder'
end
