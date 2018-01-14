Rails.application.routes.draw do

  post '/call', to: 'voices#call', as: 'call'
  post '/connect/:sales_number', to: 'voices#connect', as: 'connect'

  get '/search', to: 'welcome#search'
  get '/teacher', to: 'welcome#teacher'
  get '/calendar', to: 'welcome#calendar'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
