# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocationPresenter do
  let(:location) do
    {
      place_id: 145306205,
      licence: "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
      osm_type: "relation",
      osm_id: 62422,
      lat: "52.5173885",
      lon: "13.3951309",
      class: "boundary",
      type: "administrative",
      place_rank: 8,
      importance: 0.8522196536088086,
      addresstype: "city",
      name: "Berlin",
      display_name: "Berlin, Deutschland",
      address: {
        city: "Berlin", "ISO3166-2-lvl4": "DE-BE", country: "Deutschland", country_code: "de"
      },
      boundingbox: [ "52.3382448", "52.6755087", "13.0883450", "13.7611609" ]
    }
  end

  describe "instance" do
    context "when the params object is given correctly" do
      let(:object) { described_class.new(params: location) }

      it "returns the location as an object" do
        expect(object).to have_attributes(
          display_name: location[:display_name],
          lat: location[:lat],
          lon: location[:lon],
          state: location[:state],
          country: location[:address][:country],
          postcode: location[:postcode]
        )
      end
    end

    context "when the params object is empty" do
      let(:object) { described_class.new(params: {}) }

      # @TODO: add a specific error for this
      it "raises an error" do
        expect { object }.to raise_error(LocationPresenter::AttributesMissing)
      end
    end
  end

  describe "#to_h" do
    let(:object) { described_class.new(params: location).to_h }

    it "returns only the expected keys" do
      expect(object.keys).to match_array(
        [ :display_name, :lat, :lon, :state, :country, :postcode ]
      )
    end
  end
end
