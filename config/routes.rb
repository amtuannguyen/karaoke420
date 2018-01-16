Rails.application.routes.draw do
  get 'karaoke/index'
  get 'karaoke/add'
  get 'karaoke/play'
  get 'karaoke/next'
  get 'karaoke/prev'
  get 'karaoke/stop'
  get 'karaoke/audio'
  get 'karaoke/clear'
  get 'karaoke/load'
  get 'karaoke/onplay'
  get 'karaoke/onstop'
  get 'songs/import'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :songs do
    collection do
      get :search
      get :browse
    end
    get :add_to_playlist
    get :remove_from_playlist
  end
  
  resources :singers do
    resources :songs, shallow: true
    collection do
      get :search
      get :browse
    end
  end
  
  resources :youtubes do
    collection do
      get :search
      get :browse
    end
  end
  
  resources :playlists do 
    resources :songs, shallow: true
  end
  
  root 'karaoke#index'
end
