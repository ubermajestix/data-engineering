require 'resque/server'
DataEngineering::Application.routes.draw do
  resources :subsidiary_data
  mount Resque::Server.new, :at => "/resque"
  root :to => 'subsidiary_data#index'
end
