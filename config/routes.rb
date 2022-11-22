Rails.application.routes.draw do

root :to => 'section/homes#top'
resources :postage_slip, only: [:index]

#管理者用ページのroute
  devise_for :admin,skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'send_letters_all' => 'send_letters#index_all'
    patch 'send_letters/update_all' => 'send_letters#update_all'
    resources :types, only: [:index, :edit, :update]
    resources :post_offices, only: [:new, :create, :edit, :update]
    resources :send_letters, only: [:index]
  end


#部署用ページのroute
  devise_for :sections, controllers: {
    registrations: "section/registrations",
    sessions: 'section/sessions'
  }

  scope module: :section do
    get 'sections/mypage' => 'sections#show'
    get 'sections/information' => 'sections#edit'
    patch 'sections/information' => 'sections#update'
    get 'budgets' => 'budgets#index'
    post 'budgets' => 'budgets#create'
    get 'budgets/:id/edit' => 'budgets#edit', as: 'edit_section_budget'
    patch 'budgets/:id' => 'budgets#update'
    patch 'budget/:id' => 'budgets#logical_delete'
    post 'payment_budgets' => 'payment_budgets#create'
    patch 'payment_budget/:id' => 'payment_budgets#logical_delete'
    get 'letters' => 'letters#index'
    post 'letters' => 'letters#create'
    patch 'letters/:id' => 'letters#update'
    delete 'letters/destroy_all' => 'letters#destroy_all'
    delete 'letters/:id' => 'letters#destroy'
    get 'send_letters/new' => 'send_letters#new'
    post 'send_letters' => 'send_letters#create'
    get 'send_letters' => 'send_letters#index'
    get 'send_letters/:id' => 'send_letters#show'
    get 'hoge' => 'homes#hoge'

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

##以下、nagano_cakeのモデルコード
#Rails.application.routes.draw do

#  devise_for :admin, controllers: {
#    sessions: 'admin/sessions',
#  }

#  namespace :admin do
#    get 'top' => 'homes#top', as: 'top'
#    get 'search' => 'homes#search', as: 'search'
#    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
#    resources :customers, only: [:index, :show, :edit, :update]
#    resources :items, except: [:destroy]
#    resources :genres, only: [:index, :create, :edit, :update]
#    resources :orders, only: [:index, :show, :update] do
#      resources :order_details, only: [:update]
#    end
#  end


#  devise_for :customers, controllers: {
#    sessions: 'public/sessions',
#    registrations: 'public/registrations',
#  }

#  scope module: :public do
#    root 'homes#top'

#    get 'customers/mypage' => 'customers#show', as: 'mypage'
#    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
#    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
#    patch 'customers/information' => 'customers#update', as: 'update_information'
#    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
#    put 'customers/information' => 'customers#update'
#    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
#    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
#    post 'orders/confirm' => 'orders#confirm'
#    get 'orders/confirm' => 'orders#error'
#    get 'orders/thanks' => 'orders#thanks', as: 'thanks'

#    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
#    resources :items, only: [:index, :show] do
#    resources :cart_items, only: [:create, :update, :destroy]
#    end
#    resources :cart_items, only: [:index]
#    resources :orders, only: [:new, :index, :create, :show]
#
#  end
#
#end
