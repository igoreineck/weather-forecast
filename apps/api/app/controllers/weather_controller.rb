class WeatherController < ActionController::API
  # @TODO: add serializers to produce a better output for the frontend
  # @TODO: modify the resource name. The address doesn't belong here.
  # @TODO: verify if extra params are being properly blocked

  def current
    # @TODO: add caching by params[:zip_code]
    result = open_weather_service.retrieve_current_weather_by(
      lat: params[:lat],
      lng: params[:lng]
    )

    render status: :ok, json: result
  end

  def forecast
    # @TODO: add caching by params[:zip_code]
    result = open_weather_service.retrieve_forecast_for_five_days_by(
      lat: params[:lat],
      lng: params[:lng]
    )

    render status: :ok, json: result
  end

  private

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end

  # @TODO: review permitted params
  def permitted_params
    params.permit(:zip_code, :lat, :lng)
  end
end
