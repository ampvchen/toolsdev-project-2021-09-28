require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  resources :locations do
    get 'temperatures', to: 'temperatures#index'
    get 'temperatures/high_low', to: 'temperatures#high_low'
  end

  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == 'admin' && password == ENV['SIDEKIQ_PASSWORD']
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
