class WeatherController < ActionController::API
  # @TODO: change these params to be dynamic
  # @TODO: add serializers to produce a better output for the frontend

  def address
    result = open_street_map_service.search_by(address: params[:address])

    render status: :ok, json: result
    # @TODO: now, I should consider using the lat, lng from here
  end

  def current
    result = open_weather_service.retrieve_current_weather_by(
      params[:lat],
      params[:lon]
    )

    render status: :ok, json: result
  end

  def forecast
    result = open_weather_service.retrieve_forecast_for_five_days_by(
      params[:lat],
      params[:lon]
    )

    render status: :ok, json: result
  end

  private

  def open_weather_service
    @open_weather_service ||= OpenWeather::Client.new
  end

  def open_street_map_service
    @open_street_map_service ||= OpenStreetMap::Client.new
  end

  def permitted_params
    params.permit(:address, :lat, :lon)
  end
end
