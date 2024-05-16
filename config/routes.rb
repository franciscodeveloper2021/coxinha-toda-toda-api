Rails.application.routes.draw do
  resources :sectors

  root "welcome#welcome"
end
