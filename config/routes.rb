Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :playlists
  resources :playlists_tracks
  resources :groups
  resources :user_groups
  resources :albums
  resources :artists
  resources :tracks
end
