Rails.application.routes.draw do

  get '/' => 'home#index', as: :home

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :tags

  resources :weddings, shallow: true do
    resources :admins
    resources :guests
    resources :gifts
    resources :services do
      resources :notes
    end
  end
end
