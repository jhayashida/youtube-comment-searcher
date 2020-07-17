Rails.application.routes.draw do
  root to: redirect('/comments')
  get 'comments', to: 'comments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
