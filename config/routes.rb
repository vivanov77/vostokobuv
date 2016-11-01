Rails.application.routes.draw do
  
  namespace :users do
    get 'omniauth_callbacks/facebook'
    get 'omniauth_callbacks/vkontakte'
    # get 'omniauth_callbacks/odnoklassniki'
  end

  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions", :omniauth_callbacks => "users/omniauth_callbacks", registrations: "users/registrations" }

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end  
  
  # if Rails.env.production?

    root 'store_components#index'

  # else

  #   root 'store_shoes#index'

  # end  

  namespace :admin do

    resources :component_subtypes
    resources :component_category_values
    resources :component_category_types
    resources :component_types
    resources :components
    resources :categories

    resources :category_values
    resources :category_types
    resources :shoes
    resources :images
    resources :opinions
    resources :articles

    resources :users, only: [:index, :show, :edit, :update, :destroy] # after devise_for :users!!!!

    resources :orders

    resources :user_news

    resources :news

    resources :configurables, only: [:index, :show, :edit, :update, :destroy]

  end

  # resources :store_shoes, only: [:index]
  # resources :shoes, only: [:index, :show]

  resources :store_components, only: [:index]
  resources :components, only: [:index, :show]

  # resources :opinions

  # resources :articles

  # get "about" => "info#about"

  get "under_construction" => "info#under_construction"

  get "faq" => "info#faq"

  get "delivery" => "info#delivery"  

  get 'search' => 'search#index'

  post '/tinymce_assets' => 'tinymce_assets#create' 

  resources :users, only: [:show, :edit, :update, :destroy, :index] # after devise_for :users!!!!   

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :orders, only: [:new, :create, :show]

  # resources :user_news

  # resources :news  

  # get '/reset' => 'reset#reset'

  # http://stackoverflow.com/questions/13388715/rails-catch-all-route

  # get "p/*business_card/user_news/*id" => "user_news#show"
# 
  # get "p/*business_card" => "users#show"

end