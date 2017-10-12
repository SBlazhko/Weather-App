require 'open_weather'

class WeatherController < ApplicationController

  # before_action :find_or_create_user

  def index; end

  def authorize
    @user = find_or_create_user
    session[:user_id] = @user.id
    respond_to do |format|
      format.js
    end
  end

  def search_weather
    open_weather_response = open_weather_api.city(
      params[:weather_search_input],
      { units: "metric", APPID: "ab082be8d0b0ed2b3eb6bec1098c2280" }
    )
    @weather_response = create_weather_request(open_weather_response) unless open_weather_response.nil?
    respond_to do |format|
      format.js
    end
  end

  private

  def create_user
    users_collection.create(uniq_identifier: user_key)
  end

  def create_weather_request(weather_data)
    weather_requests_collection.create(
      user_id: current_user.id,
      name: weather_data["name"],
      original_name: params[:weather_search_input],
      min_temp: weather_data["main"]["temp_min"],
      max_temp: weather_data["main"]["temp_max"],
      precipitation_icon: weather_data["weather"][0]["icon"]
    )
  end

  def find_or_create_user
    user = users_collection.find_by(uniq_identifier: params[:secret_user_key])
    user.nil? ? create_user : user
  end

  def open_weather_api
    OpenWeather::Current
  end

  def user_key
    SecureRandom.urlsafe_base64(nil, false)
  end

  def users_collection
    User
  end

  def weather_requests_collection
    WeatherRequest
  end
end

# {"coord"=>{"lon"=>30.73, "lat"=>46.48},
#  "weather"=>[{"id"=>804, "main"=>"Clouds", "description"=>"overcast clouds", "icon"=>"04n"}],
#  "base"=>"stations",
#  "main"=>{"temp"=>15, "pressure"=>1021, "humidity"=>82, "temp_min"=>15, "temp_max"=>15},
#  "visibility"=>10000,
#  "wind"=>{"speed"=>2},
#  "clouds"=>{"all"=>90},
#  "dt"=>1507143600,
#  "sys"=>
#    {"type"=>1,
#     "id"=>7366,
#     "message"=>0.0098,
#     "country"=>"UA",
#     "sunrise"=>1507089640,
#     "sunset"=>1507130975},
#  "id"=>698740,
#  "name"=>"Odessa",
#  "cod"=>200}
