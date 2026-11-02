import { useState } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { searchLocation, type Location } from "@/api/search-location";
import { getWeather } from "@/api/get-weather";

const searchLocationForm = z.object({
  address: z.string(),
});

type SearchLocationForm = z.infer<typeof searchLocationForm>;

interface SearchFormProps {
  setWeather: () => {};
}

function Location({ location, onClick }) {
  return (
    <li key={location.display_name} className="border border-b-0">
      <button
        onClick={() => onClick(location)}
        className="flex w-full items-start gap-3 border-b border-slate-100 px-4 py-3 text-left text-sm text-slate-600 hover:bg-slate-50"
      >
        {location.display_name}
      </button>
    </li>
  );
}

function LocationsContainer({ locations, setWeather }) {
  async function handleClick({ lat, lon, postcode }: Location) {
    // @TODO: send postcode correctly
    const result = await getWeather({ lat, lon, postcode });

    if (result.status === 200) {
      setWeather(result.data);
    }
  }

  return (
    <div>
      {locations.length > 0 && (
        <div>
          <ul className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
            <p className="px-4 pt-3 pb-2 text-xs font-semibold uppercase tracking-wider text-slate-600 border-b-0">
              {locations.length}{" "}
              {locations.length === 1 ? "address" : "addresses"}
            </p>
            {locations.map((location) => (
              <Location location={location} onClick={handleClick} />
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

export function SearchForm({ setWeather, className }: SearchFormProps) {
  const [locations, setLocations] = useState<Location[] | []>([]);
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<SearchLocationForm>();
  async function onSubmit({ address }: SearchLocationForm) {
    const response = await searchLocation({ address: address.trim() });

    if (response.status === 200) {
      setLocations(response.data.locations);
    }
  }

  return (
    <div className={className}>
      <form onSubmit={handleSubmit(onSubmit)} className="flex gap-2 mb-4">
        <div className="relative flex-1">
          <Input
            id="address"
            placeholder="Address"
            className="w-full rounded-xl border border-slate-200 bg-white py-3 pl-10 pr-4 outline-none focus:ring-2 focus:ring-slate-900/10"
            {...register("address", { required: true })}
          />
          <span>{errors?.address?.message}</span>
        </div>
        <Button
          type="submit"
          className="rounded-xl bg-slate-900 px-5 font-medium text-white hover:bg-slate-800"
        >
          Search
        </Button>
      </form>
      <LocationsContainer locations={locations} setWeather={setWeather} />
    </div>
  );
}
