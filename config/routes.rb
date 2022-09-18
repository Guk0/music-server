Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :playlists do
    get :my_playlist, on: :collection
  end
  resources :playlist_tracks, only: [:create, :destroy]
  resources :groups
  resources :user_groups, only: [:create, :destroy]
  resources :albums
  resources :artists
  resources :tracks
  resources :users
end
