The2ofus::Application.routes.draw do
  resources :pages
  root "pages#index"

  # namespace :api, defaults: {format: :json} do
  #   resources :results, only: [:index, :create, :update] do
  #     member do
  #       post :publish
  #     end
  #     collection do
  #       get :all
  #     end
  #   end
  #   resources :players, only: [:index, :create, :update] do
  #     member do
  #       get :show
  #     end
  #     collection do
  #       get :all
  #     end
  #   end
  # end

  namespace :api, defaults: { format: :json } do
    resources :photos, only: :index
    # resources :facebook_imports, only: :create
  end

  resources :photos, only: :show

  ActiveAdmin.routes(self)
end
