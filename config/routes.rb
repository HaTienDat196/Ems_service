Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  get 'blogs/index'
  get 'blogs/new'
  get 'blogs/show'
  post 'blogs/change', to: 'blogs#change'
  get 'blogs/view_model', to: 'blogs#updatebolean'
  root to: 'blogs#index'
  resources :blogs do
    post 'private_case', on: :member
    post 'public_case', on: :member
    post 'change_publictime', on: :member
  end
end
