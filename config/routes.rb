Rails.application.routes.draw do

root :to => 'section/homes#top'
resources :report_pdfs, only: [:index]

#管理者用ページのroute
  devise_for :admin,skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'monthly_report' => 'send_letters#monthly_report'
    get 'sections' => 'sections#index'
    patch 'sections/:id' => 'sections#logical_delete'
    patch 'send_letters/update_all' => 'send_letters#update_all'
    patch 'budget/:id' => 'budgets#logical_delete'
    resources :post_offices, only: [:new, :create, :edit, :update]
    resources :send_letters, only: [:index]
    resources :budgets, only: [:index, :create, :edit, :update, :destroy]
  end


#部署用ページのroute
  devise_for :sections, controllers: {
    registrations: "section/registrations",
    sessions: 'section/sessions'
  }

  scope module: :section do
    get 'section' => 'sections#show'
    get 'section/information' => 'sections#edit'
    patch 'section/information' => 'sections#update'
    get 'payment_budgets' => 'payment_budgets#index'
    patch 'payment_budgets/:id' => 'payment_budgets#register'
    get 'letters' => 'letters#index'
    post 'letters' => 'letters#create'
    patch 'letters/:id' => 'letters#update'
    delete 'letters/destroy_all' => 'letters#destroy_all'
    delete 'letters/:id' => 'letters#destroy'
    get 'send_letters/new' => 'send_letters#new'
    post 'send_letters' => 'send_letters#create'
    get 'send_letters/:id' => 'send_letters#show'
    get 'send_letters' => 'send_letters#index'
    delete 'send_letters/:id' => 'send_letters#destroy'
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
