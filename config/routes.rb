The2ofus::Application.routes.draw do
  resources :pages
  root "pages#index"
  get 'auth/:provider/callback', to: 'authentications#create'
  get 'auth/failure', to: 'authentications#failure'

  get :gallery, to: 'pages#gallery'

  namespace :api, defaults: { format: :json } do
    resources :photos, only: :index
    resources :likes, only: :create
    # resources :facebook_imports, only: :create
  end

  resources :photos, only: :show

  ActiveAdmin.routes(self)
end
