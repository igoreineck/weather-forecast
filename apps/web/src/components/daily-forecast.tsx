const options = {
  weekday: "short",
  timeZone: "UTC",
};

function formatDate(date: string, options: {}) {
  return new Date(date).toLocaleString("en-US", options);
}

export function DailyForecast({ time, entry }) {
  const iconUrlFromFirstTimeSlot = entry.time_series[0].weather_icon_url;

  return (
    <div className="flex items-center gap-4 border-b border-slate-100 py-3 last:border-0">
      <span className="w-24 text-sm font-medium capitalize text-slate-700">
        {formatDate(time, options)}
      </span>
      <img src={iconUrlFromFirstTimeSlot} alt="" className="h-8 w-8" />
      <span className="w-8 text-right text-sm text-slate-700">
        {`L:${Math.round(entry.temp_min)}°`}
      </span>
      <div className="relative h-1.5 flex-1 rounded-full bg-slate-100" />
      <span className="w-8 text-sm font-medium text-slate-700">
        {`H:${Math.round(entry.temp_max)}°`}
      </span>
    </div>
  );
}
