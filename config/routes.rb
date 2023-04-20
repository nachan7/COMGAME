Rails.application.routes.draw do

  namespace :public do
    #DM機能
    get 'chats/show'
  end
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
      # 検索機能
      get :search, on: :collection
    end

    #members
    resources :members,only: [:index, :show, :edit, :update] do
      #フォロー機能
      resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      #気になる一覧
      get :favorites, on: :member
      #会員投稿一覧
      get :member_post, on: :member
      #検索機能
      get :search, on: :collection
    end
     #退会機能
      get '/members/:id/quitcheck' => 'members#quit_check', as: 'quitcheck'
      patch '/members/:id/quit' => 'members#quit', as: 'quit'
     #DM機能
      resources :chats, only: [:show, :create,]
end

#管理者側
  devise_for :admins, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do

    #homes
    root to: 'homes#top'

    #posts
    resources :posts,only: [:index, :show, :edit, :update, :destroy] do
      #コメント機能
      resources :post_comments,only: [:create, :destroy]
      #検索機能
      get :search, on: :collection
    end


    #members
    resources :members,only: [:index, :show, :edit, :update] do
      member do
        #会員投稿一覧
        get :member_post
      end
      #検索機能
      get :search, on: :collection
    end
    #categories
    resources :categories,only: [:index, :create, :edit, :update, :destroy]
    #退会機能
    patch '/members/:id/quit' => 'members#quit', as: 'quit'
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end