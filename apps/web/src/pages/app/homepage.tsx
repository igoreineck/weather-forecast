import { useState } from "react";
import { SearchForm } from "@/components/search-form";
import { Weather } from "@/components/weather";

export function Homepage() {
  const [weather, setWeather] = useState({});

  return (
    <div className="min-h-screen bg-slate-50 p-6">
      <div className="mx-auto grid max-w-5xl gap-6 md:grid-cols-2">
        <SearchForm setWeather={setWeather} />
        <Weather {...weather} />
      </div>
    </div>
  );
}
