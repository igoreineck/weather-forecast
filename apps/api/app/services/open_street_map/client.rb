module OpenStreetMap
  class Client
    API_URL = "https://nominatim.openstreetmap.org/search"

    Result = Struct.new(:status, :content, :error_message)

    def initialize
      @connection = Faraday.new do |instance|
        instance.options.timeout = 5
        instance.options.open_timeout = 2
      end
    end

    def search_by(address:)
      return Result.new(status: :success, content: []) if address.blank?

      response = @connection.get(API_URL, {
        q: address,
        addressdetails: 1,
        format: "json"
      })

      Result.new(
        status: :success,
        content: JSON.parse(response.body, symbolize_names: true)
      )
    rescue StandardError, RuntimeError => e
      Rails.logger.error(self.class.name, { message: e.message })
      Result.new(status: :error, error_message: e.message)
    end
  end
end
