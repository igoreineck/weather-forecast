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
        }
        // ...
      ]
    }
    // ...
  },
  "cached": true,
  "fetched_at": "2026-11-02T16:50:34Z"
}
```

It shows a forecast for 5 days and 3 hour step grouped by date. Including the high and low temperatures for each following day.
