Rails.application.routes.draw do

  get '/' => 'home#index', as: :home

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :tags

  resources :weddings, shallow: true do
    get 'weddings/show_admin' => 'weddings#show_admin', as: :details
    resources :admins
    resources :guests
    resources :gifts
    resources :services do
      resources :notes
    end
  end
end
