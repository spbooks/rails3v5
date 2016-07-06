Rails.application.routes.draw do

  resources :stories do 
    resources :votes
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
