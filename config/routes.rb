Rails.application.routes.draw do
  root 'player#index'

  get 'player/profile/:id' => 'player#profile'
  get 'player/profile/:name/:realm/:bnetid/add' => 'player#save_player'
  get 'player/ladders/:id' => 'player#ladders'

  get 'clan/:tag' => 'clan#info'
  get 'clan/:tag/add' => 'clan#create'

  get 'ladder/:player' => 'ladder#show'

  get 'middleman' => 'middleman#load'

end
