GlucoseAmigo::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority
  resources :sessions, only: [ :new, :create, :destroy ]


  put 'accounts/changepassword', :to => 'accounts#change_password'
  resources :accounts do
    resources :diabetics, except: [ :show, :index, :delete ]
  end

  resources :diabetics, only: [] do
    resources :records, :preferences, except: [:delete]
  end

  resources :doctors, except: [:edit, :delete]


end
