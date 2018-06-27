Rails.application.routes.draw do
  get  'translations'     => 'translations#index'
  get  'translations/new' => 'translations#new'
  root 'translations#new'
  post 'translations'     => 'translations#create'
  get  'translations/new/upimg' => 'translations#upimg' #場所間違ってるかも
end
