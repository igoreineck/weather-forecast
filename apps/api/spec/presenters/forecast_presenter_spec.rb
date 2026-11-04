# frozen_string_literal: true

require "rails_helper"

RSpec.describe ForecastPresenter do
  let(:fixture) { file_fixture("presenters/forecast.json").read }
  let(:forecast) { JSON.parse(fixture, symbolize_names: true) }

  describe "instance" do
    context "when the params object is given correctly" do
      let(:object) { described_class.new(params: forecast) }

      it "returns the forecast as an object" do
        expect(object).to have_attributes(list: forecast[:list])
        expect(object.grouped_by_date).to be_present
      end
    end

    context "when the params object is empty" do
      let(:object) { described_class.new(params: {}) }

      # @TODO: add a specific error for this
      it "raises an error" do
        expect { object }.to raise_error(ForecastPresenter::AttributesMissing)
      end
    end
  end

  describe "#to_h" do
    let(:object) { described_class.new(params: forecast).to_h }

    it "returns only the expected keys" do
      expect(object.keys).to match_array(
        [ "2026-10-31", "2026-11-01", "2026-11-02", "2026-11-03", "2026-11-04" ]
      )
    end
  end
end
