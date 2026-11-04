module OpenWeather
  class Client
    API_KEY = ENV["OPEN_WEATHER_API_KEY"]
    CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast"

    Result = Struct.new(:status, :content, :error_message)

    def initialize
      @connection = Faraday.new do |instance|
        instance.options.timeout = 5
        instance.options.open_timeout = 2
      end
    end

    def retrieve_current_weather_by(lat:, lon:)
      return Result.new(status: :success, content: {}) if lat.nil? || lon.nil?

      response = @connection.get(CURRENT_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      Result.new(
        status: :success,
        content: JSON.parse(response.body, symbolize_names: true)
      )
    rescue StandardError, RuntimeError => e
      Rails.logger.error("#{self.class.name}: #{e.message}")
      Result.new(status: :error, error_message: e.message)
    end

    def retrieve_forecast_for_five_days_by(lat:, lon:)
      return Result.new(status: :success, content: {}) if lat.nil? || lon.nil?

      response = @connection.get(FORECAST_WEATHER_URL, {
        lat:,
        lon:,
        units: "metric",
        appid: API_KEY
      })

      Result.new(
        status: :success,
        content: JSON.parse(response.body, symbolize_names: true)
      )
    rescue StandardError, RuntimeError => e
      Rails.logger.error("#{self.class.name}: #{e.message}")
      Result.new(status: :error, error_message: e.message)
    end
  end
end
