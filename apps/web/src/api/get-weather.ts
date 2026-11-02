import { api } from "@/lib/axios";

export interface GetWeatherBody {
  lat: number;
  lon: number;
  postcode: string | null;
  refresh: boolean;
}

export interface WeatherType {
  time: string;
  temp: number;
  weather_condition: string;
  weather_icon_url: string;
}

export interface DailyForecastType {
  [date: string]: {
    temp_min: number;
    temp_max: number;
    time_series: WeatherType[];
  };
}

export interface GetWeatherResponse {
  current: WeatherType;
  forecast: DailyForecastType;
  cached: boolean;
  fetched_at: string;
}

export async function getWeather({
  lat,
  lon,
  postcode,
  refresh,
}: GetWeatherBody) {
  const response = await api.get<GetWeatherResponse>("/api/weather", {
    params: { lat, lon, postcode, refresh },
  });

  return response;
}
