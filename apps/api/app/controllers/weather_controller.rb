class WeatherController < ActionController::API
  # @TODO: verify if extra params are being properly blocked

  def show
    result = WeatherService
      .new(lat: params[:lat], lon: params[:lon])
      .retrieve

    render status: :ok, json: result
  end

  private

  # @TODO: review permitted params
  def permitted_params
    params.permit(:zip_code, :lat, :lon)
  end
end
