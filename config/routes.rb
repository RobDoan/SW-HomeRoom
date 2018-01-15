Rails.application.routes.draw do

  resources :bookings
  resources :users do
    collection do
      get 'teacher', default: {role: 'teacher'}
      get 'parent_register', default: {role: 'teacher'}
    end
  end
  get '/voices', to: 'voices#index'
  post '/call', to: 'voices#call', as: 'call'
  get '/calling', to: 'voices#calling'
  post '/connect/:sales_number', to: 'voices#connect', as: 'connect'

  get '/search', to: 'welcome#search'
  get '/psychologists', to: 'welcome#psychologists'
  get '/chat', to: 'welcome#chat'
  get '/calendar', to: 'welcome#calendar'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
