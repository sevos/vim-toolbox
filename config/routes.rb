VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resource :session, only: [:create, :destroy]
  resources :plugins do
    member do
      post :install
    end
  end

  namespace :admin do
    resources :plugins, only: %i(index destroy) do
      member do
        put :approve
      end
    end
  end

  get "/auth/:provider/callback" => "sessions#create"
end
