class WeatherController < ActionController::API
  # @TODO: change these params to be dynamic
  # @TODO: add serializers to produce a better output for the frontend

  def coordenates
    result = open_weather_service.search_by_city(
      params[:city],
      params[:state_code],
      params[:country_code]
    )[0]

    render status: :ok, json: result
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

  def permitted_params
    params.permit(:city, :state_code, :country_code, :lat, :lon)
  end
end
