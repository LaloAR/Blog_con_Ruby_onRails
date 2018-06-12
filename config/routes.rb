Rails.application.routes.draw do
  # REST => Arquitectura Web basada en los recursos --- Las URL representan a un recurso y no una acción
  # Métodos http => Para las acciones a realizar
  # El recurso va en plural
  resources :posts
  resources :usuarios, as: :user, only: [:show,:update]
  resources :friendships, only: [:create,:update]
  #GET /posts => posts_controller # index
  #GET /posts/new => posts_controller # new
  #POST /posts => posts_controller # create
  #GET /posts/:id => posts_controller # show
  #PUTCH/PUT /posts/:id => posts_controller # update
  #GET /posts/:id/edit => posts_controller # edit
  #DELETE /posts/:id => posts_controller # destroy

  devise_for :users, controllers:{
  	omniauth_callbacks: "users/omniauth_callbacks"
  }

  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"

  
  authenticated :user do
    root 'main#home'
  end

  unauthenticated :user do
    root 'main#unregistered'
  end

  # 1 Mandar una petición a Facebook
  # 2 Facebook retorna a nuestra app callback_url
  # 3 Procesar la info Fbook
  # 4 Autenticar al usuario o crear un nuevo usuario

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
