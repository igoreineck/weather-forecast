class LocationService
  def initialize(address:)
    @address = address
  end

  def retrieve
    { locations: }
  end

  private

  def locations
    data = open_street_map_service.search_by(address: @address)

    data.map do |location|
      LocationPresenter.new(params: location).to_h
    end
  end

  def open_street_map_service
    @open_street_map_service ||= OpenStreetMap::Client.new
  end
end
