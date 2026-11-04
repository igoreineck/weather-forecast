class WeatherService
  CACHE_TTL = 30.minutes

  def initialize(lat:, lon:, postcode: nil)
    @lat = lat
    @lon = lon
    @postcode = postcode
  end

  def retrieve(refresh: false)
    cached = true
    error = nil

    data = Rails.cache.fetch(cache_key, expires_in: CACHE_TTL, force: refresh, skip_nil: true) do
      cached = false
      result = fetch_fresh_data

      if result[:status] == :error
        error = result

        nil
      else
        result
      end
    end

    return error if error

    data.merge(content: data[:content].merge(cached:))
  end

  private

  def fetch_fresh_data
    current_weather = open_weather_service
      .retrieve_current_weather_by(lat: @lat, lon: @lon)
    return error_response(current_weather) if current_weather.status == :error

    forecast_weather = open_weather_service
      .retrieve_forecast_for_five_days_by(lat: @lat, lon: @lon)
    return error_response(forecast_weather) if forecast_weather.status == :error

    {
      status: :success,
      content: {
        current: WeatherPresenter.new(params: current_weather.content).to_h,
        forecast: ForecastPresenter.new(params: forecast_weather.content).to_h,
        fetched_at: Time.current.iso8601
      }
    }
  end

  def error_response(response)
    {
      status: :error,
      content: {},
      error_message: response.error_message
    }
  end

  def cache_key
    return "weather/#{@postcode}" if @postcode.present?

    "weather/#{@lat.to_f.round(2)},#{@lon.to_f.round(2)}"
  end

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end
end
