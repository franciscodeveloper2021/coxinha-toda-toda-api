Rails.application.routes.draw do
  resources :sectors

  get "/favicon.ico", to: ->(env) { [404, {}, []] }
  root "welcome#welcome"
end
