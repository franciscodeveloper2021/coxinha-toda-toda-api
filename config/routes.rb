Rails.application.routes.draw do
  resources :sectors
  resources :products

  get "/favicon.ico", to: ->(env) { [404, {}, []] }
  root "welcome#welcome"
end
