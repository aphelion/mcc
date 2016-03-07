Rails.application.routes.draw do
  root to: redirect('/jobs')

  resources :jobs , only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      get 'display'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
