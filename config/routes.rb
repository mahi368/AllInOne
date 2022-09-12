Rails.application.routes.draw do

  devise_for :users , controllers: { sessions: "sessions" , omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :posts do
    collection do
      post :create_comment
      delete :destroy_comment
      post :create_reply
      delete :delete_reply
      post :like_dislike
      delete :like_dislike
    end
  end
  resources :categories
  root 'homes#index'
  get 'homes/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
