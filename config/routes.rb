Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'blogs/index'
  get 'blogs/new'
  get 'blogs/show'
  post 'blogs/show', to: 'blogs#show'
  post 'blogs/edit', to: 'blogs#edit'
  root to: 'blogs#index'
  resources :blogs
end
