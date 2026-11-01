import { api } from "@/lib/axios";

export interface SearchLocationBody {
  address: string;
}

export interface Location {
  display_name: string;
  lat: number;
  lon: number;
  cached: boolean | null;
  address: {
    state: string;
    country: string;
    country_code: string;
    postcode: string | null;
  };
}

export interface SearchLocationResponse {
  locations: Location[];
}

export async function searchLocation({ address }: SearchLocationBody) {
  const response = await api.get<SearchLocationResponse>(
    "/api/location/search",
    {
      params: { address },
    },
  );
  return response.data;
}
