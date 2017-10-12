$(".forecast-block").append("<%= j render "weather/weather_block", weather_response: @weather_response %>")
