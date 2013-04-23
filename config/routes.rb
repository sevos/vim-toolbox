VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resource :session, only: [:create, :destroy]
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
