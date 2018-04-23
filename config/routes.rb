Rails.application.routes.draw do
  get  'translations'     => 'translations#index'
  get  'translations/new' => 'translations#new'
  root 'translations#new'
  post 'translations'     => 'translations#create'
end
