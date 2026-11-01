class WeatherController < ActionController::API
  # @TODO: verify if extra params are being properly blocked

  def show
    current = open_weather_service.retrieve_current_weather_by(
      lat: params[:lat], lng: params[:lng]
    )

    forecast = open_weather_service.retrieve_forecast_for_five_days_by(
      lat: params[:lat], lng: params[:lng]
    )

    # @TODO: evaluate how to better structure this output
    result = {
      current: JSON.parse(WeatherBlueprint.render(current)),
      forecast: JSON.parse(WeatherBlueprint.render(forecast[:list]))
    }

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
