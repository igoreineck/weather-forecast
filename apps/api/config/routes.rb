Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "api/location/search", to: "location#search"
  get "api/weather", to: "weather#show"
end
