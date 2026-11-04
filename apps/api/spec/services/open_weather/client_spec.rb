require "rails_helper"

RSpec.describe OpenWeather::Client do
  describe "#retrieve_current_weather_by" do
    let(:client) { described_class.new }

    context "when lat and lon are given correctly" do
      let(:lat) { "44.34" }
      let(:lon) { "10.99" }

      let(:current_weather_fixture) do
        file_fixture("services/success_response/current_weather.json").read
      end

      let(:current_weather_url) do
        "http://api.openweathermap.org/data/2.5/weather?appid&lat=44.34&lon=10.99&units=metric"
      end

      before do
        stub_request(:get, current_weather_url).and_return(body: current_weather_fixture.to_json)
      end

      it "returns the current weather" do
        call = client.retrieve_current_weather_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :success,
          content: current_weather_fixture
        )
      end
    end

    context "when lat and lon are NOT given" do
      let(:lat) { nil }
      let(:lon) { nil }

      it "returns an empty content" do
        call = client.retrieve_current_weather_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :success,
          content: {}
        )
      end
    end

    context "when something unexpected happens" do
      let(:lat) { "44.34" }
      let(:lon) { "10.99" }

      let(:current_weather_url) do
        "http://api.openweathermap.org/data/2.5/weather?appid&lat=44.34&lon=10.99&units=metric"
      end

      before do
        stub_request(:get, current_weather_url)
          .and_raise(RuntimeError.new("Something unexpected happened"))

        allow(Rails.logger).to receive(:error)
      end

      it "returns an error with a message" do
        call = client.retrieve_current_weather_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :error,
          content: nil,
          error_message: "Something unexpected happened"
        )

        expect(Rails.logger).to have_received(:error)
          .with("OpenWeather::Client: Something unexpected happened")
      end
    end
  end

  describe "#retrieve_forecast_for_five_days_by" do
    let(:client) { described_class.new }

    context "when lat and lon are given correctly" do
      let(:lat) { "44.34" }
      let(:lon) { "10.99" }

      let(:forecast_weather_fixture) do
        file_fixture("services/success_response/forecast_weather.json").read
      end

      let(:forecast_weather_url) do
        "http://api.openweathermap.org/data/2.5/forecast?appid&lat=44.34&lon=10.99&units=metric"
      end

      before do
        stub_request(:get, forecast_weather_url).and_return(body: forecast_weather_fixture.to_json)
      end

      it "returns the forecast weather" do
        call = client.retrieve_forecast_for_five_days_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :success,
          content: forecast_weather_fixture
        )
      end
    end

    context "when lat and lon are NOT given" do
      let(:lat) { nil }
      let(:lon) { nil }

      it "returns an empty content" do
        call = client.retrieve_forecast_for_five_days_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :success,
          content: {}
        )
      end
    end

    context "when something unexpected happens" do
      let(:lat) { "44.34" }
      let(:lon) { "10.99" }

      let(:forecast_weather_url) do
        "http://api.openweathermap.org/data/2.5/forecast?appid&lat=44.34&lon=10.99&units=metric"
      end

      before do
        stub_request(:get, forecast_weather_url)
          .and_raise(RuntimeError.new("Something unexpected happened"))

        allow(Rails.logger).to receive(:error)
      end

      it "returns an error with a message" do
        call = client.retrieve_forecast_for_five_days_by(lat:, lon:)

        expect(call).to have_attributes(
          status: :error,
          content: nil,
          error_message: "Something unexpected happened"
        )

        expect(Rails.logger).to have_received(:error)
          .with("OpenWeather::Client: Something unexpected happened")
      end
    end
  end
end
