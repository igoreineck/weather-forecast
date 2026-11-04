require "rails_helper"

RSpec.describe WeatherController, type: :request do
  describe "GET /api/weather" do
    context "when both latitude and longitude are given correctly" do
      let(:payload) do
        { lat: "48.4433253", lon: "5.1377537" }
      end

      let(:expected_body) do
        default_success_example
      end

      let(:weather_service_instance) { instance_double("WeatherService") }

      before do
        allow(WeatherService)
          .to receive(:new)
          .with(lat: payload[:lat], lon: payload[:lon], postcode: nil)
          .and_return(weather_service_instance)

        allow(weather_service_instance)
          .to receive(:retrieve)
          .with(refresh: false)
          .and_return({
            status: :success,
            content: expected_body
          })

        get "/api/weather", params: payload
      end

      it "returns a status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns a list of locations for the given address" do
        expect(response.body).to eq(expected_body.to_json)
      end
    end

    context "when something unexpected happens" do
      let(:payload) do
        { lat: "48.4433253", lon: "5.1377537" }
      end

      let(:weather_service_instance) { instance_double("WeatherService") }

      before do
        allow(WeatherService)
          .to receive(:new)
          .with(lat: payload[:lat], lon: payload[:lon], postcode: nil)
          .and_return(weather_service_instance)

        allow(weather_service_instance)
          .to receive(:retrieve)
          .with(refresh: false)
          .and_return({
            status: :error,
            content: {},
            error_message: "Some unexpected error happened"
          })

        get "/api/weather", params: payload
      end

      it "returns a status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.body).to eq({ error: "Some unexpected error happened" }.to_json)
      end
    end
  end

  def default_success_example
    {
      "current": {
        "time": "2026-11-04T17:53:35.000Z",
        "temp": 7.62,
        "weather_condition": "Clear",
        "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
      },
      "forecast": {
        "2026-11-04": {
          "temp_min": 7.51,
          "temp_max": 7.62,
          "time_series": [
            {
              "time": "2026-11-04T19:00:00.000Z",
              "temp": 7.62,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            },
            {
              "time": "2026-11-04T22:00:00.000Z",
              "temp": 7.51,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            }
          ]
        },
        "2026-11-05": {
          "temp_min": 3.34,
          "temp_max": 12.51,
          "time_series": [
            {
              "time": "2026-11-05T01:00:00.000Z",
              "temp": 6.5,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            },
            {
              "time": "2026-11-05T04:00:00.000Z",
              "temp": 4.54,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            },
            {
              "time": "2026-11-05T07:00:00.000Z",
              "temp": 3.34,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            },
            {
              "time": "2026-11-05T10:00:00.000Z",
              "temp": 6.63,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-05T13:00:00.000Z",
              "temp": 11.11,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
            },
            {
              "time": "2026-11-05T16:00:00.000Z",
              "temp": 12.51,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
            },
            {
              "time": "2026-11-05T19:00:00.000Z",
              "temp": 8.65,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-05T22:00:00.000Z",
              "temp": 7.68,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/02n@2x.png"
            }
          ]
        },
        "2026-11-06": {
          "temp_min": 4.04,
          "temp_max": 9.08,
          "time_series": [
            {
              "time": "2026-11-06T01:00:00.000Z",
              "temp": 6.05,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
            },
            {
              "time": "2026-11-06T04:00:00.000Z",
              "temp": 4.04,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-06T07:00:00.000Z",
              "temp": 4.22,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-06T10:00:00.000Z",
              "temp": 5.68,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-06T13:00:00.000Z",
              "temp": 9.08,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-06T16:00:00.000Z",
              "temp": 7.54,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10d@2x.png"
            },
            {
              "time": "2026-11-06T19:00:00.000Z",
              "temp": 6.18,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
            },
            {
              "time": "2026-11-06T22:00:00.000Z",
              "temp": 5.88,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            }
          ]
        },
        "2026-11-07": {
          "temp_min": 5.07,
          "temp_max": 7.18,
          "time_series": [
            {
              "time": "2026-11-07T01:00:00.000Z",
              "temp": 5.81,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-07T04:00:00.000Z",
              "temp": 5.83,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-07T07:00:00.000Z",
              "temp": 6.01,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-07T10:00:00.000Z",
              "temp": 5.92,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-07T13:00:00.000Z",
              "temp": 6.68,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-07T16:00:00.000Z",
              "temp": 7.18,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-07T19:00:00.000Z",
              "temp": 6.14,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-07T22:00:00.000Z",
              "temp": 5.07,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            }
          ]
        },
        "2026-11-08": {
          "temp_min": 1.01,
          "temp_max": 9.53,
          "time_series": [
            {
              "time": "2026-11-08T01:00:00.000Z",
              "temp": 2.65,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
            },
            {
              "time": "2026-11-08T04:00:00.000Z",
              "temp": 1.44,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
            },
            {
              "time": "2026-11-08T07:00:00.000Z",
              "temp": 1.01,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
            },
            {
              "time": "2026-11-08T10:00:00.000Z",
              "temp": 3.93,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
            },
            {
              "time": "2026-11-08T13:00:00.000Z",
              "temp": 9.53,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/03d@2x.png"
            },
            {
              "time": "2026-11-08T16:00:00.000Z",
              "temp": 8.95,
              "weather_condition": "Clear",
              "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
            },
            {
              "time": "2026-11-08T19:00:00.000Z",
              "temp": 5.66,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-08T22:00:00.000Z",
              "temp": 4.82,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
            }
          ]
        },
        "2026-11-09": {
          "temp_min": 7,
          "temp_max": 11.14,
          "time_series": [
            {
              "time": "2026-11-09T01:00:00.000Z",
              "temp": 7,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-09T04:00:00.000Z",
              "temp": 7.55,
              "weather_condition": "Clouds",
              "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
            },
            {
              "time": "2026-11-09T07:00:00.000Z",
              "temp": 7.89,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
            },
            {
              "time": "2026-11-09T10:00:00.000Z",
              "temp": 9.13,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10d@2x.png"
            },
            {
              "time": "2026-11-09T13:00:00.000Z",
              "temp": 11.13,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10d@2x.png"
            },
            {
              "time": "2026-11-09T16:00:00.000Z",
              "temp": 11.14,
              "weather_condition": "Rain",
              "weather_icon_url": "https://openweathermap.org/img/wn/10d@2x.png"
            }
          ]
        }
      },
      "fetched_at": "2026-11-04T17:12:05Z",
      "cached": false
    }
  end
end
