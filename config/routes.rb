Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :signs
  # resources :callbacks

  root 'signs#index'

  post '/' => 'signs#index'

  get '/callbacks' => 'callbacks#index'
  post '/callbacks' => 'callbacks#create'

  get 'account' => 'signs#account'
  get 'signature-request' => 'signs#signature_request'
  get 'all-requests' => 'signs#all_requests'
  post 'send-request' => 'signs#send_request'
  get 'template-request' => 'signs#template_request'

  post 'reminder' => 'signs#reminder'
  get 'update-email' => 'signs#update_email'
  post 'cancel' => 'signs#cancel'

  get 'file' => 'signs#file'

  get '/embeddeds' => 'embeddeds#index'
  get '/embeddeds/template' => 'embeddeds#template'
  get '/embeddeds/file-request' => 'embeddeds#file_request'
  get '/embeddeds/unclaimed-draft' => 'embeddeds#unclaimed_draft'
  get '/embeddeds/unclaimed-draft-template' => 'embeddeds#unclaimed_draft_template'
  get '/embeddeds/template-draft' => 'embeddeds#template_draft'
  get '/embeddedds/edit-unclaimed-draft' => 'embeddeds#edit_unclaimed_draft'

  get '/templates/update' => 'templates#update'

  get '/apps/info' => 'apps#info'
  get '/apps/list' => 'apps#list'
end
