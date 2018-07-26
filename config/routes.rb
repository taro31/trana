Rails.application.routes.draw do
  get  'translations'     => 'translations#index'
  get  'translations/new' => 'translations#new'
  root 'translations#new'
  post 'translations'     => 'translations#create'
  
  get   'upimgs/new' => 'upimgs#new'
  post  'upimgs' => 'upimgs#create'
  
  get   'translations/new2' => 'translations/new2'
  post  'translations/create2' => 'translations/create2'
  
end
