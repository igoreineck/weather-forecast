module OpenStreetMap
  class Client
    API_URL = "https://nominatim.openstreetmap.org/search"

    # @TODO: if possible, think about API throttling.
    # To avoid more than 1 request per second

    def initialize
      @connection = Faraday.new do |instance|
        instance.options.timeout = 5
        instance.options.open_timeout = 2
      end
    end

    def search_by(address:)
      return if address.blank?

      response = @connection.get(API_URL, {
        q: address,
        addressdetails: 1,
        format: "json"
      })

      JSON.parse(response.body, symbolize_names: true)
    rescue StandardError, RuntimeError => error
      puts "API error: #{error}"
    end
  end
end
