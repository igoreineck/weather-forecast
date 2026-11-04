class WeatherService
  CACHE_TTL = 30.minutes

  def initialize(lat:, lon:, postcode: nil)
    @lat = lat
    @lon = lon
    @postcode = postcode
  end

  def retrieve(refresh: false)
    # @TODO: move this variable to inside the cache.
    cached = !refresh && Rails.cache.exist?(cache_key)

    current_weather = open_weather_service.retrieve_current_weather_by(
      lat: @lat, lon: @lon
    )
    if current_weather.status == :error
      return {
        status: current_weather.status,
        content: {},
        error_message: current_weather.error_message
      }
    end

    forecast_weather = open_weather_service.retrieve_forecast_for_five_days_by(
      lat: @lat, lon: @lon
    )
    if forecast_weather.status == :error
      return {
        status: forecast_weather.status,
        content: {},
        error_message: forecast_weather.error_message
      }
    end

    data = Rails.cache.fetch(cache_key, expires_in: CACHE_TTL, force: refresh) do
      {
        status: :success,
        content: {
          current: WeatherPresenter.new(params: current_weather.content).to_h,
          forecast: ForecastPresenter.new(params: forecast_weather.content).to_h,
          fetched_at: Time.current.iso8601,
          cached:
        }
      }
    end

    data
  end

  private

  def cache_key
    "weather/#{@postcode}"
  end

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end
end
