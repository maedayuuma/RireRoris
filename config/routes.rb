Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  scope module: :user do
  root to: "homes#top"
  get "homes/about"=>"homes#about", as: "about"

  resources :items, only: [:index,:show]

  delete "/cart_items/destroy_all" => "cart_items#destroy_all"
  resources :cart_items, only: [:index, :update, :destroy, :create]



  post "/orders/comfirm" => "orders#comfirm"
  get "/orders/complete" => "orders#complete"
  resources :orders, only: [:new, :create, :index, :show]

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  get "/customers/check" => "customers#check"
  patch "/customers/withdraw" => "customers#withdraw"
  get "customers/mypage" => "customers#show"
  get "customers/information/edit" => "customers#edit"
  patch "customers/information" => "customers#update"
  end

  namespace :admin do

  get "/" => "homes#top"

  resources :items

  resources :genres, only: [:index, :create, :edit, :update]

  resources :customers, only: [:index, :show, :edit,:update]

  resources :orders, only: [:show, :index, :update]

  resources :orders_details, only: [:update]

 end
end
