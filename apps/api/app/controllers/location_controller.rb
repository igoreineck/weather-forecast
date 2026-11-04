class LocationController < ActionController::API
  def index
    result = LocationService
      .new(address: params[:address])
      .retrieve

    if result[:status] == :success
      render status: :ok, json: result[:content]
    else
      render status: :not_found,
        json: { error: result[:error_message] }
    end
  end

  private

  def permitted_params
    params.permit(:address)
  end
end
