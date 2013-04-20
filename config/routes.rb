VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resources :plugins

  namespace :admin do
    resources :plugins
  end
end
