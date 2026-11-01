import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";

import { useForm } from "react-hook-form";
import { z } from "zod";
import { useQuery } from "@tanstack/react-query";
import {
  searchLocation,
  type SearchLocationResponse,
} from "@/api/search-location";
import { useState } from "react";

const searchLocationForm = z.object({
  address: z.string(),
});

type SearchLocationForm = z.infer<typeof searchLocationForm>;

export function SearchForm({ setLocations }) {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<SearchLocationForm>();
  const [address, setAddress] = useState<string>("");
  const { data, isFetching, isSuccess } = useQuery<SearchLocationResponse>({
    queryKey: ["address", address],
    queryFn: ({ queryKey }) => {
      const [, address] = queryKey;

      return searchLocation({ address });
    },
    enabled: !!address,
  });

  async function onSubmit(formData: SearchLocationForm) {
    const address = formData.address.trim();
    setAddress(address);
  }

  if (isSuccess) {
    setLocations(data.locations);
  }

  return (
    <>
      <form onSubmit={handleSubmit(onSubmit)}>
        <div className="mb-4">
          <Label
            htmlFor="address"
            className="block text-gray-500 uppercase text-xs mb-2"
          >
            Address
          </Label>
          <Input
            id="address"
            className="block text-gray-600 p-4 h-12 w-full border-gray-300 focus:outline focus:border-primary"
            {...register("address", { required: true })}
          />
          <span>{errors?.address?.message}</span>
        </div>
        <Button
          type="submit"
          className="bg-primary text-md text-white p-4 h-12 w-full cursor-pointer"
          disabled={isFetching}
        >
          Search
        </Button>
      </form>
    </>
  );
}
