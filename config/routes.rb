DataEngineering::Application.routes.draw do
  resources :subsidiary_data
  root :to => 'subsidiary_data#index'
end
