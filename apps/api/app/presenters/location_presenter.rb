class LocationPresenter
  def initialize(params: {})
    raise StandardError if params.empty?

    @params = params
  end

  def to_h
    {
      display_name:,
      lat:,
      lon:,
      state:,
      country:,
      postcode:
    }
  end

  def display_name
    @params[:display_name]
  end

  def lat
    @params[:lat]
  end

  def lon
    @params[:lon]
  end

  def state
    @params.dig(:address, :state)
  end

  def country
    @params.dig(:address, :country)
  end

  def postcode
    @params.dig(:address, :postcode)
  end
end
