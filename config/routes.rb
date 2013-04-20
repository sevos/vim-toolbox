VimToolbox::Application.routes.draw do
  root to: 'plugins#index'
  resources :plugins
end
