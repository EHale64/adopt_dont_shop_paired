Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get    '/shelters',          to: 'shelters#index'
  get    '/shelters/new',      to: 'shelters#new'
  post   '/shelters',          to: 'shelters#create'
  get    '/shelters/:id/pets', to: 'shelters#pets'
  get    '/shelters/:id/edit', to: 'shelters#edit'
  get    '/shelters/:id',      to: 'shelters#show'
  patch  '/shelters/:id',      to: 'shelters#update'
  delete '/shelters/:id',      to: 'shelters#destroy'

  get    '/pets',                          to: 'pets#index'
  get    '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post   '/shelters/:shelter_id/pets',     to: 'pets#create'
  get    '/pets/:id/edit',                 to: 'pets#edit'
  get    '/pets/:id',                      to: 'pets#show'
  patch  '/pets/:id',                      to: 'pets#update'
  delete '/pets/:id',                      to: 'pets#destroy'
end
