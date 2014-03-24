GlucoseAmigo::Application.routes.draw do
  root to: 'accounts#index'

  # The priority is based upon order of creation:
  # first created -> highest priority
  resources :sessions, only: [ :new, :create, :destroy ]

  # get 'accounts/menu',  :to => 'accounts#menu'
  # get 'accounts/submenu', :to => 'accounts#getSubmenu', :as => 'get_submenu'
  get 'dashboard/get', :to => 'dashboard#get', :as => 'get_submenu'
  get 'diabetics/:id/dashboard', :to => 'dashboard#diabetic', :as => 'diabetic_dashboard'

  put 'accounts/changepassword', :to => 'accounts#change_password'
  resources :accounts do
    resources :diabetics, except: [ :index, :delete ]
  end

  resources :diabetics, only: [] do
    resources :records, :preferences, :doctors, except: [:delete]
  end

end
