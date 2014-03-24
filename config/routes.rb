GlucoseAmigo::Application.routes.draw do
  get '/test', :to => 'accounts#test'

  # The priority is based upon order of creation:
  # first created -> highest priority

  resources :sessions, only: [ :new, :create, :destroy ]
  root to: 'accounts#index'

  get 'accounts/menu',  :to => 'accounts#menu'
  get 'accounts/submenu', :to => 'accounts#getSubmenu', :as => 'get_submenu'
  put 'accounts/changepassword', :to => 'accounts#change_password'
  resources :accounts do
    resources :diabetics, except: [ :show, :index, :delete ]
  end

  resources :diabetics, only: [] do
    resources :records, :preferences, :doctors, except: [:delete]
  end

end
