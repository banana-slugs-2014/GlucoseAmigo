DiabeticBud::Application.routes.draw do

  resources :accounts do
    resources :users
  end

  resources :users, only: [] do
    resources :records, :preferences, except: [:delete]
  end
  resources :doctors, except: [:edit, :delete]
end
