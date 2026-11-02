import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export function SearchForm({ register, errors, handleSubmit, onSubmit }) {
  return (
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
        className="rounded-xl bg-slate-900 px-5 font-medium text-white hover:bg-slate-800 cursor-pointer"
      >
        Search
      </Button>
    </form>
  );
}
