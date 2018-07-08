Rails.application.routes.draw do
  get "/" => "games#index"
  resources :games do
    resources :players
  end

  put "/session" => "session#create", as: :session
  delete "/session" => "session#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
