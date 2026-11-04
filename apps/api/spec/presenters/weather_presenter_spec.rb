# frozen_string_literal: true

require "rails_helper"

RSpec.describe WeatherPresenter do
  let(:weather) do
    {
      coord: { lon: 10.99, lat: 44.34 },
      weather: [
       { id: 501, main: "Rain", description: "moderate rain", icon: "10d" }
      ],
      base: "stations",
      main: {
        temp: 298.48,
        feels_like: 298.74,
        temp_min: 297.56,
        temp_max: 300.05,
        pressure: 1015,
        humidity: 64,
        sea_level: 1015,
        grnd_level: 933
      },
      visibility: 10000,
      wind: { speed: 0.62, deg: 349, gust: 1.18 },
      rain: { "1h": 3.16 },
      clouds: { all: 100 },
      dt: 1661870592,
      sys: {
        type: 2, id: 2075663, country: "IT", sunrise: 1661834187, sunset: 1661882248
      },
      timezone: 7200,
      id: 3163858,
      name: "Zocca",
      cod: 200
    }
  end

  describe "instance" do
    context "when the params object is given correctly" do
      let(:object) { described_class.new(params: weather) }

      it "returns the weather as an object" do
        expect(object).to have_attributes(
          time: Time.at(weather[:dt] + weather[:timezone]).utc,
          temp: weather[:main][:temp],
          weather_condition: weather[:weather][0][:main],
          weather_icon_url: "https://openweathermap.org/img/wn/#{weather[:weather][0][:icon]}@2x.png"
        )
      end
    end

    context "when the params object is empty" do
      let(:object) { described_class.new(params: {}) }

      # @TODO: add a specific error for this
      it "raises an error" do
        expect { object }.to raise_error(WeatherPresenter::AttributesMissing)
      end
    end
  end

  describe "#to_h" do
    let(:object) { described_class.new(params: weather).to_h }

    it "returns only the expected keys" do
      expect(object.keys).to match_array(
        [ :time, :temp, :weather_condition, :weather_icon_url ]
      )
    end
  end
end
