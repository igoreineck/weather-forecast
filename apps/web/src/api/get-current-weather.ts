import { api } from "@/lib/axios";

export interface GetCurrentWeatherBody {
  lat: number;
  lon: number;
}

export async function getCurrentWeather({ lat, lon }: GetCurrentWeatherBody) {
  await api.post("/api/current", {
    lat,
    lon,
  });
}
