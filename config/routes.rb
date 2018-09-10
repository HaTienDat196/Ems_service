Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'blogs/index'
  get 'blogs/new'
  get 'blogs/show'
  post 'blogs/show', to: 'blogs#show'
  get '/create', to: 'blogs#new'
  post '/create',  to: 'blogs#create'
  root to: 'blogs#index'
  resources :blogs
end
