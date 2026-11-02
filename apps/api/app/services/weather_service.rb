class WeatherService
  CACHE_TTL = 30.minutes

  def initialize(lat:, lon:, postcode:)
    @lat = lat
    @lon = lon
    @postcode = postcode
  end

  def retrieve(refresh: false)
    cached = !refresh && Rails.cache.exist?(cache_key)

    data = Rails.cache.fetch(cache_key, expires_in: CACHE_TTL, force: refresh) do
      { current:, forecast:, fetched_at: Time.current.iso8601 }
    end

    {
      current: data[:current],
      forecast: data[:forecast],
      cached:,
      fetched_at: data[:fetched_at]
    }
  end

  private

  def cache_key
    "weather/#{@postcode}"
  end

  def current
    data = open_weather_service.retrieve_current_weather_by(
      lat: @lat, lon: @lon
    )

    WeatherPresenter.new(params: data).to_h
  end

  def forecast
    data = open_weather_service.retrieve_forecast_for_five_days_by(
      lat: @lat, lon: @lon
    )

    ForecastPresenter.new(params: data).to_h
  end

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end
end
