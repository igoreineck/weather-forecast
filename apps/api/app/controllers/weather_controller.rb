class WeatherController < ActionController::API
  # @TODO: verify if extra params are being properly blocked

  def show
    result = WeatherService
      .new(lat: params[:lat], lon: params[:lon], postcode: params[:postcode])
      .retrieve(refresh:)

    render status: :ok, json: result
  end

  private

  def refresh
    return false unless params[:refresh]

    ActiveModel::Type::Boolean.new.cast(params[:refresh])
  end

  # @TODO: review permitted params
  def permitted_params
    params.permit(:postcode, :lat, :lon, :refresh)
  end
end
