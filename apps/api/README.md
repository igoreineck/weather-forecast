# API

## How to execute

### Install all dependencies

First run the bundler to install all dependencies:

```bash
bundle install
```

### Add credentials

Create a new `.env.development` file copying from `.env.development.example`:

```bash
cp .env.development.example .env.development
```

There is a credential called `OPEN_WEATHER_KEY`. You need to get a key from OpenWeather. For more information see:

- https://home.openweathermap.org/api_keys

After created, just update it normally

```txt
OPEN_WEATHER_KEY=key
```

### Executing

Make sure you're at the correct path within the API folder:

```bash
bin/dev
```

Otherwise, if you're at the root folder:

```bash
apps/api/bin/dev
```

## Endpoints

There are two main endpoints available. The 1st is:

```txt
GET http://localhost:3000/api/location/search
```

An `address` must be provided in order to retrieve any information:

```txt
For example

-> GET http://localhost:3000/api/location/search?address=Berlin
```

The output follows this structure as an example:

```json
{
  "locations": [
    {
      "display_name": "Berlin, Deutschland",
      "lat": "52.5173885",
      "lon": "13.3951309",
      "state": null,
      "country": "Deutschland",
      "postcode": null
    }
  ]
}
```

The 2nd endpoint is:

```txt
GET http://localhost:3000/api/weather
```

Here a few other more params are necessary to query the weather conditions:

```txt
For example

-> GET http://localhost:3000/api/weather?lat=52.5173885&lon=13.3951309
```

The `postcode` is optional but highly recommended because it is used for caching. The Open Street Map API does not return
postcode for all locations. Some of them cannot be cached anyway. If the postcode is present, it can be passed normally:

```txt
-> GET http://localhost:3000/api/weather?lat=52.5173885&lon=13.3951309&postcode=81200
```

Weather data is cached for 30 minutes based on a given postcode. The `refresh=true` param can be used to skip the cache entirely, and query the latest API data.

```txt
-> GET http://localhost:3000/api/weather?lat=52.5173885&lon=13.3951309&postcode=81200&refresh=true
```

The output follows this structure as an example:

```json
{
  "current": {
    "time": "2026-11-02T17:49:38.000Z",
    "temp": 7.88,
    "weather_condition": "Clouds",
    "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
  },
  "forecast": {
    "2026-11-02": {
      "temp_min": 7.49,
      "temp_max": 7.88,
      "time_series": [
        {
          "time": "2026-11-02T19:00:00.000Z",
          "temp": 7.88,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-02T22:00:00.000Z",
          "temp": 7.49,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        }
      ]
    },
    "2026-11-03": {
      "temp_min": 1.72,
      "temp_max": 9.8,
      "time_series": [
        {
          "time": "2026-11-03T01:00:00.000Z",
          "temp": 5.41,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
        },
        {
          "time": "2026-11-03T04:00:00.000Z",
          "temp": 3.65,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-03T07:00:00.000Z",
          "temp": 1.72,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-03T10:00:00.000Z",
          "temp": 6.3,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
        },
        {
          "time": "2026-11-03T13:00:00.000Z",
          "temp": 8.77,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
        },
        {
          "time": "2026-11-03T16:00:00.000Z",
          "temp": 9.8,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-03T19:00:00.000Z",
          "temp": 8.59,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-03T22:00:00.000Z",
          "temp": 8.21,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        }
      ]
    },
    "2026-11-04": {
      "temp_min": 3.41,
      "temp_max": 7.44,
      "time_series": [
        {
          "time": "2026-11-04T01:00:00.000Z",
          "temp": 5.69,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/02n@2x.png"
        },
        {
          "time": "2026-11-04T04:00:00.000Z",
          "temp": 5.3,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
        },
        {
          "time": "2026-11-04T07:00:00.000Z",
          "temp": 3.41,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-04T10:00:00.000Z",
          "temp": 6.17,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/03d@2x.png"
        },
        {
          "time": "2026-11-04T13:00:00.000Z",
          "temp": 7.44,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-04T16:00:00.000Z",
          "temp": 7.29,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-04T19:00:00.000Z",
          "temp": 5.28,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/03n@2x.png"
        },
        {
          "time": "2026-11-04T22:00:00.000Z",
          "temp": 4.39,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        }
      ]
    },
    "2026-11-05": {
      "temp_min": 1.42,
      "temp_max": 10.58,
      "time_series": [
        {
          "time": "2026-11-05T01:00:00.000Z",
          "temp": 2.98,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-05T04:00:00.000Z",
          "temp": 2.16,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-05T07:00:00.000Z",
          "temp": 1.42,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-05T10:00:00.000Z",
          "temp": 4.92,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
        },
        {
          "time": "2026-11-05T13:00:00.000Z",
          "temp": 10.42,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
        },
        {
          "time": "2026-11-05T16:00:00.000Z",
          "temp": 10.58,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01d@2x.png"
        },
        {
          "time": "2026-11-05T19:00:00.000Z",
          "temp": 6.03,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-05T22:00:00.000Z",
          "temp": 4.63,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        }
      ]
    },
    "2026-11-06": {
      "temp_min": 1.88,
      "temp_max": 9.58,
      "time_series": [
        {
          "time": "2026-11-06T01:00:00.000Z",
          "temp": 3.7,
          "weather_condition": "Clear",
          "weather_icon_url": "https://openweathermap.org/img/wn/01n@2x.png"
        },
        {
          "time": "2026-11-06T04:00:00.000Z",
          "temp": 2.92,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-06T07:00:00.000Z",
          "temp": 1.88,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-06T10:00:00.000Z",
          "temp": 4.88,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-06T13:00:00.000Z",
          "temp": 9.58,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-06T16:00:00.000Z",
          "temp": 8.46,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-06T19:00:00.000Z",
          "temp": 5.36,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04n@2x.png"
        },
        {
          "time": "2026-11-06T22:00:00.000Z",
          "temp": 5.39,
          "weather_condition": "Rain",
          "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
        }
      ]
    },
    "2026-11-07": {
      "temp_min": 5.2,
      "temp_max": 7.51,
      "time_series": [
        {
          "time": "2026-11-07T01:00:00.000Z",
          "temp": 5.7,
          "weather_condition": "Rain",
          "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
        },
        {
          "time": "2026-11-07T04:00:00.000Z",
          "temp": 5.2,
          "weather_condition": "Rain",
          "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
        },
        {
          "time": "2026-11-07T07:00:00.000Z",
          "temp": 5.81,
          "weather_condition": "Rain",
          "weather_icon_url": "https://openweathermap.org/img/wn/10n@2x.png"
        },
        {
          "time": "2026-11-07T10:00:00.000Z",
          "temp": 6.39,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-07T13:00:00.000Z",
          "temp": 7.51,
          "weather_condition": "Clouds",
          "weather_icon_url": "https://openweathermap.org/img/wn/04d@2x.png"
        },
        {
          "time": "2026-11-07T16:00:00.000Z",
          "temp": 7.37,
          "weather_condition": "Rain",
          "weather_icon_url": "https://openweathermap.org/img/wn/10d@2x.png"
        }
      ]
    }
  },
  "cached": true,
  "fetched_at": "2026-11-02T16:50:34Z"
}
```

It shows a forecast for 5 days and 3 hour step grouped by date. Including the high and low temperatures for each following day.
