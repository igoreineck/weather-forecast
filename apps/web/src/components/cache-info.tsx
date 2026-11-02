import { Button } from "@/components/ui/button";

const rtf = new Intl.RelativeTimeFormat("en-US", { numeric: "auto" });

function timeAgo(iso: string) {
  const minutes = Math.round((new Date(iso).getTime() - Date.now()) / 60000);
  return rtf.format(minutes, "minute");
}

export function CacheInfo({ cached, fetchedAt, refreshCallback }) {
  function CacheLabel() {
    if (cached) {
      return (
        <span className="inline-flex h-7 items-center gap-1.5 rounded-full bg-amber-100 px-3 text-sm font-medium text-amber-800">
          From cache
        </span>
      );
    }

    return (
      <span className="inline-flex h-7 items-center gap-1.5 rounded-full bg-green-100 px-3 text-sm font-medium text-green-800">
        Updated now
      </span>
    );
  }

  const time = new Date(fetchedAt).toLocaleTimeString("en-US", {
    hour: "2-digit",
    minute: "2-digit",
  });

  return (
    <div className="flex flex-wrap justify-between items-center gap-2.5">
      <div>
        <CacheLabel />{" "}
        <span className="text-sm text-slate-600">
          Fetched at {time}
          {cached && ` · ${timeAgo(fetchedAt)}`}
        </span>
      </div>
      <Button
        onClick={refreshCallback}
        className="rounded-xl bg-slate-900 px-5 font-medium text-white hover:bg-slate-800 cursor-pointer"
      >
        Refresh
      </Button>
    </div>
  );
}
