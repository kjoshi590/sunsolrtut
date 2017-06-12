Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/search', to: 'search#new_search', as:'new_search'
  post '/search', to: 'search#search_players', as: 'search_players'

  get '/search_teams', to: 'search#new_search_team', as:'new_search_team'
  post '/search_teams', to: 'search#search_teams', as: 'search_teams'

end
