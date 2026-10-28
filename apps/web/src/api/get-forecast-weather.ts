import { api } from "@/lib/axios";

export interface GetForecastWeatherBody {
  lat: number;
  lon: number;
}

export async function getForecastWeather({ lat, lon }: GetForecastWeatherBody) {
  await api.post("/api/forecast", {
    lat,
    lon,
  });
}
