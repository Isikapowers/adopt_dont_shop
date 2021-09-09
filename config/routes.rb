Rails.application.routes.draw do
  get "/", to: "application#welcome"
  get "/application/:id", to: "application#show"

  get "/admin/shelters", to: "admin_shelters#index"
  get "/admin/shelters/:id", to: "admin_shelters#show"
  get "/admin/shelters/:id/pets", to: "admin_shelters#show"

  get "/admin/applications", to: "admin_applications#index"
  get "/admin/applications/:id", to: "admin_applications#show"
  patch "/admin/applications/:id", to: "admin_applications#update"
  delete "/admin/applications/:id", to: "admin_applications#destroy"
  # resources :applications, :pets, :shelters

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  get '/shelters/:shelter_id/pets/:pet_id', to: 'pets#show'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/shelters/:shelter_id/pets/:pet_id/edit', to: 'shelter_pets#edit'
  patch '/shelters/:shelter_id/pets/:pet_id', to: 'pets#update'
  delete '/shelters/:shelter_id/pets/:pet_id', to: 'pets#destroy'

  get '/veterinary_offices', to: 'veterinary_offices#index'
  get '/veterinary_offices/new', to: 'veterinary_offices#new'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  post '/veterinary_offices', to: 'veterinary_offices#create'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  get '/veterinarians', to: 'veterinarians#index'
  get '/veterinarians/:id', to: 'veterinarians#show'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  patch '/veterinarians/:id', to: 'veterinarians#update'
  delete '/veterinarians/:id', to: 'veterinarians#destroy'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'

  get '/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: "applications#show"
  post '/applications', to: 'applications#create'
  get '/applications/:id/edit', to: 'applications#edit'
  patch '/applications/:id', to: 'applications#update'
  delete '/applications/:id', to: "applications#destroy"

  get "/applications/:application_id/pets", to: "pets#index"
  get "/applications/:application_id/pets/:pet_id", to: "applications#show"

  get "/applications/:id/new", to: "pet_applications#new"
  post "/applications/:id/new", to: "pet_applications#create"

end
