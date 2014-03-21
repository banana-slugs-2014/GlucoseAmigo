DiabeticBud::Application.routes.draw do

  resources :accounts do
    resources :users do
      resources :records, :preferences, except: [:delete]
    end
  end
  resources :doctors, except: [:edit, :delete]
end
