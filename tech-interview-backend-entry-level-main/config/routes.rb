require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products
  get "up" => "rails/health#show", as: :rails_health_check

   # Rotas para o carrinho
   resource :cart, only: [:show] do
    post :add_product, on: :collection
    patch :update_product_quantity, on: :collection
    delete 'remove_product/:product_id', to: 'carts#remove_product', as: :remove_product
  end
  
  root "rails/health#show"
end
