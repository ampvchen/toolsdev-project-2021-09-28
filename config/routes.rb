require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  resources :locations do
    get 'temperatures', to: 'temperatures#index'
    get 'temperatures/forecast', to: 'temperatures#forecast'
    get 'temperatures/high_low', to: 'temperatures#high_low'
  end

  # Limit access to Development
  # TODO: Setup Devise to make the WebUI only available to :admin
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

end
