module OpenWeather
  class Client
    API_KEY = ENV["OPEN_WEATHER_API_KEY"]
    CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast"

    def initialize
      @connection = Faraday.new do |instance|
        instance.options.timeout = 5
        instance.options.open_timeout = 2
      end
    end

    # @TODO: handle status codes accordingly to make the adapter resilient
    def retrieve_current_weather_by(lat:, lon:)
      return if lat.nil? || lon.nil?

      response = @connection.get(CURRENT_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      JSON.parse(response.body, symbolize_names: true)
    rescue StandardError, RuntimeError => e
      puts "API error: #{e}"
    end

    def retrieve_forecast_for_five_days_by(lat:, lon:)
      return if lat.nil? || lon.nil?

      response = @connection.get(FORECAST_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      JSON.parse(response.body, symbolize_names: true)
    rescue StandardError, RuntimeError => e
      puts "API error: #{e}"
    end
  end
end
