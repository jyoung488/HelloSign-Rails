Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :signs
  # resources :callbacks

  root 'signs#index'

  post '/' => 'signs#index'

  get '/callbacks' => 'callbacks#index'
  post '/callbacks' => 'callbacks#create'

  get 'account' => 'accounts#get_account'
  post 'update-account' => 'accounts#update_account'
  post 'verify-account' => 'accounts#verify_account'

  get 'signature-request' => 'signs#signature_request'
  get 'all-requests' => 'signs#all_requests'
  post 'send-request' => 'signs#send_request'
  get 'template-request' => 'signs#template_request'
  get 'unclaimed-draft' => 'signs#unclaimed_draft'

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

  get '/templates/info' => 'templates#get_template'
  get '/templates/update' => 'templates#update'
  get '/templates/list' => 'templates#list'
  post '/templates/add-access' => 'templates#add_access'
  post '/templates/remove-access' => 'templates#remove_access'
  post '/templates/delete' => 'templates#delete'
  get '/templates/download' => 'templates#download'

  get '/teams' => 'teams#index'
  post '/teams/new' => 'teams#new'
  post '/teams/update' => 'teams#update'
  post '/teams/add-user' => 'teams#add_user'

  get '/apps/info' => 'apps#info'
  get '/apps/list' => 'apps#list'
  get '/apps/create' => 'apps#create'
  get '/apps/update' => 'apps#update'
  get '/apps/delete' => 'apps#delete'

  get '/helloworks' => 'helloworks#index'
  post '/helloworks' => 'helloworks#create'
  get '/helloworks/new' => 'helloworks#new_instance'
  post '/helloworks/new' => 'helloworks#new_instance'

  get '/helloworks/v3/new' => 'helloworks#v3_instance'
end
