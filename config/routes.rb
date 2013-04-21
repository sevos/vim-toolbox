VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resources :sessions, only: [:create]
  resources :plugins

  namespace :admin do
    resources :plugins do
      member do
        put :approve
      end
    end
  end

  get "/auth/:provider/callback" => "sessions#create"
end
