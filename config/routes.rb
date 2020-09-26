Rails.application.routes.draw do
  resources :reminders
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
