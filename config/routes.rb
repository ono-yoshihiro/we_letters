Rails.application.routes.draw do

root :to => 'section/homes#top'
resources :report_pdfs, only: [:index]

#管理者用ページのroute
  devise_for :admin,skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :budgets, only: [:index, :create, :edit, :update, :destroy]
    patch 'budget/:id' => 'budgets#logical_delete'
    resources :post_offices, only: [:new, :create, :edit, :update]
    get 'sections' => 'sections#index'
    patch 'sections/:id' => 'sections#logical_delete'
    patch 'send_letters/update_all' => 'send_letters#update_all'
    resources :send_letters, only: [:index]
    get 'monthly_report' => 'send_letters#monthly_report'
  end

#部署用ページのroute
  devise_for :sections, controllers: {
    registrations: "section/registrations",
    sessions: 'section/sessions'
  }

  scope module: :section do
    resources :boards, only: [:new, :create, :show, :destroy]
    resources :payment_budgets, only: [:index]
    patch 'payment_budgets/:id' => 'payment_budgets#register'
    get 'section/information' => 'sections#edit'
    patch 'section/information' => 'sections#update'
    delete 'letters/destroy_all' => 'letters#destroy_all'
    resources :letters, only: [:index, :create, :update, :destroy]
    resources :send_letters, only: [:new, :create, :index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end