Rails.application.routes.draw do

  resources :merchants, controller: 'merchants' do
    post 'remove_from_chain', on: :member
  end

  resources :chains, controller: 'chains' do
    post 'remove_merchant', on: :member
  end


  get 'users/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
