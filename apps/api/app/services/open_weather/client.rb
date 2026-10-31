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

    # @TODO: handle status codes accordingly to make the adapter resilient
    # @TODO: improve method names to be better readable

    def retrieve_current_weather_by(lat:, lon:)
      response = @connection.get(CURRENT_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      JSON.parse(response.body)
    rescue StandardError, RuntimeError => e
      # raise "API error: #{response.status}" unless response.success?
      puts "API error: #{e}"
    end

    # forecast: api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    def retrieve_forecast_for_five_days_by(lat:, lon:)
      response = @connection.get(FORECAST_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      JSON.parse(response.body)
    rescue StandardError, RuntimeError => e
      # raise "API error: #{response.status}" unless response.success?
      puts "API error: #{e}"
    end
  end
end
