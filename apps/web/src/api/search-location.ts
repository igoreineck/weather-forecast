import { api } from "@/lib/axios";

export interface SearchLocationBody {
  address: string;
}

export interface Location {
  display_name: string;
  lat: number;
  lon: number;
  state: string;
  country: string;
  postcode: string | null;
}

export type SearchLocationResponse = Location[];

export async function searchLocation({ address }: SearchLocationBody) {
  const response = await api.get<SearchLocationResponse>("/api/location", {
    params: { address },
  });

  return response;
}
