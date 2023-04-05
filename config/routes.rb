Rails.application.routes.draw do


#会員
  devise_for :members, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  #homes
    root to: 'homes#top'
    get '/about' => 'homes#about'

  #posts
    resources :posts,only: [:new,:index,:show,:edit,:update,:create,:destroy]

  #members
    resources :members,only: [:index,:show,:edit,:update]

end

#管理者側
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}

namespace :admin do

  #homes
    root to: 'homes#top'

  #posts
    resources :posts,only: [:index, :show, :edit, :update, :destroy]

  #members
    resources :members,only: [:index,:show,:edit,:update]

  #categories
    resources :categories,only: [:index,:edit,:update,:create, :show]

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
