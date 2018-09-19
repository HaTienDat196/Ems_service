Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'blogs/index'
  get 'blogs/new'
  get 'blogs/show'
  post 'blogs/change', to: 'blogs#change'
  root to: 'blogs#index'
  resources :blogs
end
