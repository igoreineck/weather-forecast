import { getWeather, type GetWeatherResponse } from "@/api/get-weather";
import type { Location } from "@/api/search-location";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";

type LocationsProps = {
  locations: Location[] | [];
  setWeather: ({}) => {};
};

export function Locations({ locations, setWeather }: LocationsProps) {
  const [lat, setLat] = useState<number>();
  const [lon, setLon] = useState<number>();

  // @TODO: review this. I think it is not necessary. Too much complexity for a simple request.
  const { data, isSuccess } = useQuery<GetWeatherResponse>({
    queryKey: ["weather", { lat, lon }], //coordenates
    queryFn: () => getWeather({ lat, lon }),
    enabled: !!lat || !!lon,
  });

  function handleClick(location: Location) {
    console.log("clicked: " + location.display_name);
    setLat(location.lat);
    setLon(location.lon);
  }

  if (isSuccess) {
    console.log(data);
    setWeather(data);
  }

  return (
    <div>
      {locations.map((location) => (
        <div onClick={() => handleClick(location)} className="cursor-pointer">
          <div>Display name: {location.display_name}</div>
          <div>Lat: {location.lat}</div>
          <div>Lon: {location.lon}</div>
        </div>
      ))}
    </div>
  );
}
