class LocationController < ActionController::API
  def search
    result = LocationService
      .new(address: params[:address])
      .retrieve

    render status: :ok, json: result
  end

  private

  def permitted_params
    params.permit(:address)
  end
end
