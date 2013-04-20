VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resources :plugins

  namespace :admin do
    resources :plugins do
      member do
        put :approve
      end
    end
  end
end
