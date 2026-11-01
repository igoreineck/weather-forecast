import { api } from "@/lib/axios";

export interface GetWeatherBody {
  lat: number;
  lon: number;
}

interface Weather {
  dt: number;
  dt_txt: string;
  main: {
    temp: number;
    feels_like: number;
    temp_min: number;
    temp_max: number;
  };
}

export interface GetWeatherResponse {
  current: Weather;
  forecast: Weather[];
}

export async function getWeather({ lat, lon }: GetWeatherBody) {
  const response = await api.get<GetWeatherResponse>("/api/weather", {
    params: { lat, lon },
  });
  console.log(response.data);
  return response.data;
}
