import { api } from "@/lib/axios";

export interface GetLocationBody {
  city: string;
  stateCode: string;
  countryCode: string;
}

export async function getLocation({
  city,
  stateCode,
  countryCode,
}: GetLocationBody) {
  const result = await api.post("/api/coordinates", {
    city,
    stateCode,
    countryCode,
  });

  return result.data;
}
