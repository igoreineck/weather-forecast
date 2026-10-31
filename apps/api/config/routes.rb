Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # @TODO: I may have to change from POST to GET requests, to respect RESTful patterns.
  # Analyze later.

  # get "api/location/search?address="
  #
  # get "api/weather/current?zip_code=&lat=&lng="
  # get "api/weather/forecast?zip_code=&lat=&lng="
  #
  get "api/location/search", to: "location#search"
  get "api/weather/current", to: "weather#current"
  get "api/weather/forecast", to: "weather#forecast"
end
