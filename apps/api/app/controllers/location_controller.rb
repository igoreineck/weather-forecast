class LocationController < ActionController::API
  # @TODO: think how to structure the output to be better consumed in the FE
  def search
    # render status: :no_content, json: {} if params[:address].blank?

    result = open_street_map_service.search_by(address: params[:address])

    render status: :ok, json: result
  end

  private

  def open_street_map_service
    @open_street_map_service ||= OpenStreetMap::Client.new
  end

  def permitted_params
    params.permit(:address)
  end
end
