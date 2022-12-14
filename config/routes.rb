Rails.application.routes.draw do
  root to: "public/homes#top"
  get "public/homes/about"=>"homes#about", as: :about

  namespace :admin do
    get "homes/top" => "homes#top"
    resource :admins
    resources :customers
    resources :genres
    resources :items
    resources :orders
    resources :order_details
  end
  # 顧客用
  # /customers/sign_in ...
  devise_for :customer,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    resource :customers
    get "customers/confirmation"
    patch "customers/withdraw"
    resources :items
    resources :cart_items
    delete "cart_items/destroy"
    resources :addresses
    get "orders/complete"
    post "orders/confirmation"
    post "orders/confirm"
    resources :orders
  end
end
