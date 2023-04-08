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
    resources :posts,only: [:new, :index, :show, :edit, :update, :create, :destroy] do
      #いいね
      resource :favorites, only: [:create, :destroy]
      #コメント機能
      resources :post_comments,only: [:create,:destroy]
    end

  #members
    resources :members,only: [:index, :show, :edit, :update] do
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
         get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      # 気になる一覧
      get :favorites, on: :member
    end
     # 退会機能
      get '/members/:id/quitcheck' => 'members#quit_check', as: 'quitcheck'
      patch '/members/:id/quit' => 'members#quit', as: 'quit'
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
    get '/posts/member_post/:id' => 'posts#member_post'

  #members
    resources :members,only: [:index, :show, :edit, :update]

  #categories
    resources :categories,only: [:index, :create, :edit, :update, :destroy]

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
