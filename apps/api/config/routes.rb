Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "api/location", to: "location#index"
  get "api/weather", to: "weather#index"
end
