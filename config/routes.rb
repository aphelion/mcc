Rails.application.routes.draw do
  root to: redirect('/builds')

  resources :builds , only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    post 'hook/:service', to: 'builds#hook', as: :hook, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
