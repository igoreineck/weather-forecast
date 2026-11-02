import { api } from "@/lib/axios";

export interface GetWeatherBody {
  lat: number;
  lon: number;
  postcode: string | null;
}

export interface WeatherType {
  time: string;
  temp: number;
  weather_condition: string;
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
}

export async function getWeather({ lat, lon, postcode }: GetWeatherBody) {
  const response = await api.get<GetWeatherResponse>("/api/weather", {
    params: { lat, lon, postcode },
  });

  return response;
}
