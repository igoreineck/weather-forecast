import { Location } from "./location";

export function LocationList({ locations, handleLocationClick, isLoading }) {
  if (isLoading) {
    return <div>Loading...</div>;
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
              <Location
                location={location}
                onClick={() =>
                  handleLocationClick({ location, refresh: false })
                }
              />
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}
