Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :signs
  resources :embeddeds
  root 'signs#index'

  post '/' => 'signs#index'

  get 'account' => 'signs#account'
  get 'signature-request' => 'signs#signature_request'
  get 'all-requests' => 'signs#all_requests'
  post 'send-request' => 'signs#send_request'
  get 'template-request' => 'signs#template_request'

  post 'reminder' => 'signs#reminder'
  post 'update-email' => 'signs#update_email'
  post 'cancel' => 'signs#cancel'

  get 'file' => 'signs#file'
end
