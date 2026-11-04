# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocationPresenter do
  let(:fixture) { file_fixture("presenters/location.json").read }
  let(:location) { JSON.parse(fixture, symbolize_names: true) }

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
