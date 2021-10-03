Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  resources :locations do
    get 'temperatures', to: 'temperatures#index'
    get 'temperatures/forecast', to: 'temperatures#forecast'
    get 'temperatures/high_low', to: 'temperatures#high_low'
  end
end
