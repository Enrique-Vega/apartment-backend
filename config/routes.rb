Rails.application.routes.draw do
  resources :apartments
  devise_for :users, defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
