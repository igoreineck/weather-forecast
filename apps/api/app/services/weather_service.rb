class WeatherService
  def initialize(lat:, lon:)
    @lat = lat
    @lon = lon
  end

  def retrieve
    { current:, forecast: }
  end

  private

  def current
    data = open_weather_service
      .retrieve_current_weather_by(lat: @lat, lon: @lon)

    WeatherPresenter.new(params: data).to_h
  end

  def forecast
    data = open_weather_service
      .retrieve_forecast_for_five_days_by(lat: @lat, lon: @lon)

    ForecastPresenter.new(params: data).to_h
  end

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end
end
