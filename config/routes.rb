Rails.application.routes.draw do
  devise_for :sections,skip: [:passwords], controllers: {
    registrations: "section/registrations",
    sessions: 'section/sessions'
  }

  devise_for :admin,skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: 'admin/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
