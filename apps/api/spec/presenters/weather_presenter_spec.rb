# frozen_string_literal: true

require "rails_helper"

RSpec.describe WeatherPresenter do
  let(:fixture) { file_fixture("presenters/weather.json").read }
  let(:weather) { JSON.parse(fixture, symbolize_names: true) }

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
