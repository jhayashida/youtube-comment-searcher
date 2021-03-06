Rails.application.routes.draw do
  devise_for :users, path: '', 
    path_names: { sign_in: 'login', sign_out: 'logout'},
    controllers: {
      sessions: 'users/sessions'
    }

  root to: redirect('comments')
  get 'comments', to: 'comments#index'
  authenticated :user do
    mount RailsDb::Engine => '/rails/db', :as => 'rails_db'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
