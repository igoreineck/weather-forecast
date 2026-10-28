import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { useMutation } from "@tanstack/react-query";
import { getLocation } from "@/api/get-location";

const getLocationForm = z.object({
  address: z.string(),
});

type GetLocationForm = z.infer<typeof getLocationForm>;

export function Homepage() {
  const { handleSubmit } = useForm<GetLocationForm>();
  const { mutateAsync: getLocationFn } = useMutation({
    mutationFn: getLocation,
  });

  async function onSubmit(data: GetLocationForm) {
    try {
      const address = data.address.split(",");
      console.log(address);
      const result = await getLocationFn({
        city: address[0],
        stateCode: address[1],
        countryCode: address[2],
      });
      console.log(result);
    } catch {
      console.log("error...");
    }
  }

  return (
    <>
      <div className="flex flex-wrap items-center gap-2 md:flex-row">
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
              className="block rounded-xl text-gray-600 p-4 h-12 w-full border-gray-300 focus:outline focus:border-primary"
            />
          </div>
          <Button
            type="submit"
            className="bg-primary text-md text-white p-4 h-12 rounded-xl w-full cursor-pointer"
          >
            Search
          </Button>
        </form>
      </div>
    </>
  );
}
