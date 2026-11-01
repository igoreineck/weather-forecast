import type { Location } from "@/api/search-location";
import { Locations } from "@/components/locations";
import { SearchForm } from "@/components/search-form";
import { Weather } from "@/components/weather";
import { useState } from "react";

// Search bar
// Locations
// Current weather
// Forecast weather

// homepage
// component: form -> get location
// component: list locations. then pick a location
// component: retrieve weather
// component: weather
// component: list weathers
export function Homepage() {
  const [locations, setLocations] = useState<Location | []>([]);
  const [weather, setWeather] = useState({});

  return (
    <>
      <SearchForm setLocations={setLocations} />
      <Locations locations={locations} setWeather={setWeather} />
      <Weather weather={weather} />
    </>
  );
}
