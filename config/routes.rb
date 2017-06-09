Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/search', to: 'search#search', as:'new_search'
  post '/search', to: 'search#search_players', as: 'search_players'
end
