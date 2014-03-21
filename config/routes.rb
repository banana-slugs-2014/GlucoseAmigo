GlucoseAmigo::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority

  resources :accounts do
    resources :users
  end

  resources :users, only: [] do
    resources :records, :preferences, except: [:delete]
  end
  resources :doctors, except: [:edit, :delete]
end
