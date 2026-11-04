class WeatherController < ActionController::API
  def index
    result = WeatherService
      .new(
        lat: params[:lat],
        lon: params[:lon],
        postcode: params[:postcode]
      )
      .retrieve(refresh:)

    if result[:status] == :success
      render status: :ok, json: result[:content]
    else
      render status: :not_found,
        json: { error: result[:error_message] }
    end
  end

  private

  def refresh
    return false unless params[:refresh]

    ActiveModel::Type::Boolean.new.cast(params[:refresh])
  end

  def permitted_params
    params.permit(:postcode, :lat, :lon, :refresh)
  end
end
