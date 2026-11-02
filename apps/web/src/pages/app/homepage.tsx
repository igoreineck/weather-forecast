import { useState } from "react";
import { useForm } from "react-hook-form";
import { SearchForm } from "@/components/search-form";
import { Weather } from "@/components/weather";
import { LocationList } from "@/components/location-list";
import { searchLocation, type Location } from "@/api/search-location";
import { getWeather } from "@/api/get-weather";
import { z } from "zod";

const searchLocationForm = z.object({
  address: z.string(),
});

type SearchLocationForm = z.infer<typeof searchLocationForm>;

export function Homepage() {
  const [locations, setLocations] = useState<Location[] | []>([]);
  const [loadingLocations, setLoadingLocations] = useState(false);
  const [weather, setWeather] = useState({});
  const [loadingWeather, setLoadingWeather] = useState(false);

  const {
    register,
    handleSubmit,
    setValue,
    formState: { errors },
  } = useForm<SearchLocationForm>();
  async function onSubmit({ address }: SearchLocationForm) {
    setLoadingLocations(true);

    try {
      const response = await searchLocation({ address: address.trim() });

      if (response.status === 200) {
        setLocations(response.data.locations);
      }
    } catch (err) {
      console.log(err);
    } finally {
      setLoadingLocations(false);
    }
  }

  async function handleLocationClick(location: Location) {
    setValue("address", location.display_name);
    setLoadingWeather(true);

    try {
      const result = await getWeather({
        lat: location.lat,
        lon: location.lon,
        postcode: location.postcode,
      });

      if (result.status === 200) {
        setWeather(result.data);
      }
    } catch (err) {
      console.log(err);
    } finally {
      setLoadingWeather(false);
    }
  }

  return (
    <div className="min-h-screen bg-slate-50 p-6">
      <div className="mx-auto grid max-w-5xl gap-6 md:grid-cols-2">
        <div>
          <SearchForm
            register={register}
            errors={errors}
            handleSubmit={handleSubmit}
            onSubmit={onSubmit}
          />
          <LocationList
            locations={locations}
            handleLocationClick={handleLocationClick}
            isLoading={loadingLocations}
          />
        </div>
        <Weather isLoading={loadingWeather} weather={weather} />
      </div>
    </div>
  );
}
