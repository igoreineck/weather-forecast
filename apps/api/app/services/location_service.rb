class LocationService
  def initialize(address:)
    @address = address
  end

  def retrieve
    data = open_street_map_service.search_by(address: @address)
    if data.status == :error
      return {
        status: data.status,
        content: {},
        error_message: data.error_message
      }
    end

    {
      status: data.status,
      content: data.content.map do |location|
        LocationPresenter.new(params: location).to_h
      end
    }
  end

  private

  def open_street_map_service
    @open_street_map_service ||= OpenStreetMap::Client.new
  end
end
