Rails.application.routes.draw do
  namespace :auth do
    get '/:provider/callback', to: 'sessions#create'
  end

  get :logout, to: 'auth/sessions#destroy'
end
