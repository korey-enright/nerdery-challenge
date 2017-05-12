Rails.application.routes.draw do
  devise_for :users

  root to: "snacks#index"
  resources :snacks do
    member do
      post "vote"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
