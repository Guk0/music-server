Rails.application.routes.draw do
  resources :playlists do
    get :my_playlist, on: :collection
  end
  resources :playlist_tracks, only: [:create, :destroy]
  resources :groups
  resources :user_groups, only: [:create, :destroy]
  resources :albums
  resources :artists
  resources :tracks
end
