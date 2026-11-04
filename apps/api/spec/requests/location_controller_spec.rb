require "rails_helper"

RSpec.describe LocationController, type: :request do
  describe "GET /api/location" do
    context "when an address is given" do
      let(:payload) do
        { address: "Berlin" }
      end

      let(:expected_body) do
        [
          {
            "display_name": "Berlin, Deutschland",
            "lat": "52.5173885",
            "lon": "13.3951309",
            "state": nil,
            "country": "Deutschland",
            "postcode": nil
          }
        ]
      end

      let(:location_service_instance) { instance_double("LocationService") }

      before do
        allow(LocationService)
          .to receive(:new)
          .with(address: payload[:address])
          .and_return(location_service_instance)

        allow(location_service_instance)
          .to receive(:retrieve)
          .and_return({
            status: :success,
            content: expected_body
          })

        get "/api/location", params: payload
      end

      it "returns a status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns a list of locations for the given address" do
        expect(response.body).to eq(expected_body.to_json)
      end
    end

    context "when multiple locations are found for the same address" do
      let(:payload) do
        { address: "Joinville" }
      end

      let(:expected_body) do
        [
          {
            "display_name": "Joinville, Saint-Dizier, Haute-Marne, Grand Est, France métropolitaine, 52300, France",
            "lat": "48.4433253",
            "lon": "5.1377537",
            "state": "Grand Est",
            "country": "France",
            "postcode": "52300"
          },
          {
            "display_name": "Joinville, Santa Catarina, Região Sul, Brasil",
            "lat": "-26.3044898",
            "lon": "-48.8486726",
            "state": "Santa Catarina",
            "country": "Brasil",
            "postcode": nil
          }
        ]
      end

      let(:location_service_instance) { instance_double("LocationService") }

      before do
        allow(LocationService)
          .to receive(:new)
          .with(address: payload[:address])
          .and_return(location_service_instance)

        allow(location_service_instance)
          .to receive(:retrieve)
          .and_return({
            status: :success,
            content: expected_body
          })

        get "/api/location", params: payload
      end

      it "returns a status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns a list of locations for the given address" do
        expect(response.body).to eq(expected_body.to_json)
      end
    end

    context "when no address is given" do
      let(:payload) { { address: nil } }

      let(:location_service_instance) { instance_double("LocationService") }

      before do
        allow(LocationService)
          .to receive(:new)
          .with(address: payload[:address])
          .and_return(location_service_instance)

        allow(location_service_instance)
          .to receive(:retrieve)
          .and_return({
            status: :success,
            content: []
          })

        get "/api/location", params: payload
      end

      it "returns a status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns an empty list" do
        expect(response.body).to eq([].to_json)
      end
    end

    context "when something unexpected happens" do
      let(:location_service_instance) { instance_double("LocationService") }

      before do
        allow(LocationService)
          .to receive(:new)
          .with(address: nil)
          .and_return(location_service_instance)

        allow(location_service_instance)
          .to receive(:retrieve)
          .and_return({
            status: :error,
            content: {},
            error_message: "Some unexpected error happened"
          })

        get "/api/location", params: {}
      end

      it "returns a status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns an empty list" do
        expect(response.body).to eq({ error: "Some unexpected error happened" }.to_json)
      end
    end
  end
end
