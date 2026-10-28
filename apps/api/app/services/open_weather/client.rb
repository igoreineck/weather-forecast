module OpenWeather
  class Client
    API_KEY = ENV["OPEN_WEATHER_API_KEY"]
    BASE_URL = "http://api.openweathermap.org"
    GEOCODING_URL = "#{BASE_URL}/geo/1.0/direct"
    CURRENT_WEATHER_URL = "#{BASE_URL}/data/2.5/weather"
    FORECAST_WEATHER_URL = "#{BASE_URL}/data/2.5/forecast"

    def initialize
      @connection = Faraday.new(url: BASE_URL) do |instance|
        instance.options.timeout = 5
        instance.options.open_timeout = 2
      end
    end

    # Direct Geocoding. Search by City name, State code, Country code. ISO 3166.
    # http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
    # http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid={API key}

    #
    # Search by ZIP code and Country code.
    # http://api.openweathermap.org/geo/1.0/zip?zip={zip code},{country code}&appid={API key}
    # http://api.openweathermap.org/geo/1.0/zip?zip=E14,GB&appid={API key}

    # @TODO: improve method names to be better readable
    def search_by_city(city_name, state_code = nil, country_code = nil)
      return if city_name.blank?

      params = city_name
      params += ",#{state_code}" if state_code
      params += ",#{country_code}" if country_code

      response = @connection.get("#{GEOCODING_URL}?q=#{params}&appid=#{API_KEY}")

      # @TODO: improve errors for this.
      raise "API error: #{response.status}" unless response.success?

      JSON.parse(response.body)
    end

    def search_by_zip_code(zip_code, country_code)
      # @TODO: implement
    end

    #
    # current: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    def retrieve_current_weather_by(latitute, longitude)
      response = @connection.get("#{CURRENT_WEATHER_URL}?lat=#{latitute}&lon=#{longitude}&units=metric&appid=#{API_KEY}")
      JSON.parse(response.body)
    rescue StandardError, RuntimeError => e
      # raise "API error: #{response.status}" unless response.success?
      puts "API error: #{e}"
    end

    # Response example:
    # "main": {
    #     "temp": 298.48,
    #     "feels_like": 298.74,
    #     "temp_min": 297.56,
    #     "temp_max": 300.05,
    #     "pressure": 1015,
    #     "humidity": 64,
    #     "sea_level": 1015,
    #     "grnd_level": 933
    #   },
    # "dt" -> time of data calculation (daytime)
    # "timezone" ...

    # forecast: api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    def retrieve_forecast_for_five_days_by(lat, lon)
      response = @connection.get("#{FORECAST_WEATHER_URL}?lat=#{lat}&lon=#{lon}&units=metric&appid=#{API_KEY}")
      JSON.parse(response.body)
    rescue StandardError, RuntimeError => e
      # raise "API error: #{response.status}" unless response.success?
      puts "API error: #{e}"
    end

    # Response example:
    # {
    #   "dt": 1661871600,
    #   "main": {
    #     "temp": 296.76,
    #     "feels_like": 296.98,
    #     "temp_min": 296.76,
    #     "temp_max": 297.87,
    #     "pressure": 1015,
    #     "sea_level": 1015,
    #     "grnd_level": 933,
    #     "humidity": 69,
    #     "temp_kf": -1.11
    #   },
    #   "weather": [
    #     {
    #       "id": 500,
    #       "main": "Rain",
    #       "description": "light rain",
    #       "icon": "10d"
    #     }
    #   ],
    #   "dt_txt": "2022-08-30 15:00:00"
    # }
  end
end

# adapter = OpenWeather::Client.new
# information = adapter.search_by_city("Joinville", "SC", "BR")[0]
# lt = information["lat"]
# lg = information["lon"]

# current = adapter.retrieve_current_weather_by(lt, lg)
# weather = current["weather"]
# main = current["main"]
# daytime = current["dt"]
#
# Chunks of 3 hour each
# Increment by 9 to reach the next day
# forecast = adapter.retrieve_forecast_for_five_days_by(lt, lg)
# list = forecast["list"]
# second_day = list[8]
# second_day["dt"]
# second_day["main"]
# second_day["weather"]
# second_day["dt_txt"]
