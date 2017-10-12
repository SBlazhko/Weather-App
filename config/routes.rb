Rails.application.routes.draw do

  get 'weather/index', to: "weather#index"
  post "weather/search", to: "weather#search_weather"
  post "weather/authorise", to: "weather#authorize"

end
