Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'feeds', to: 'feeds#index'
    get 'feeds/philippines', to: 'feeds#philippines'
    get 'location', to: 'locations#index'
  end
end
