require "rails_helper"

RSpec.describe OpenStreetMap::Client do
  describe "#search_by" do
    let(:client) { described_class.new }

    context "when the address is given correctly" do
      let(:address) { "Berlin" }
      let(:fixture) { file_fixture("services/success_response/locations.json").read }
      let(:url) do
        "https://nominatim.openstreetmap.org/search?q=Berlin&addressdetails=1&format=json"
      end

      before do
        stub_request(:get, url).and_return(body: fixture.to_json)
      end

      it "returns locations based on the given address" do
        call = client.search_by(address:)

        expect(call).to have_attributes(
          status: :success,
          content: fixture
        )
      end
    end

    context "when the address is blank" do
      let(:address) { nil }

      it "returns sucess with an empty respose" do
        call = client.search_by(address:)

        expect(call).to have_attributes(
          status: :success,
          content: []
        )
      end
    end

    context "when something unexpected happens" do
      let(:url) do
        "https://nominatim.openstreetmap.org/search?q=error&addressdetails=1&format=json"
      end

      before do
        stub_request(:get, url)
          .to_raise(RuntimeError.new("Something unexpected happened"))

        allow(Rails.logger).to receive(:error)
      end

      it "returns an error status with a message" do
        call = client.search_by(address: "error")

        expect(call).to have_attributes(
          status: :error,
          content: nil,
          error_message: "Something unexpected happened"
        )

        expect(Rails.logger).to have_received(:error)
          .with("OpenStreetMap::Client: Something unexpected happened")
      end
    end
  end
end
