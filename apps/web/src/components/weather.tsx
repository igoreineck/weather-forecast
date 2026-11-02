import type { DailyForecastType, WeatherType } from "@/api/get-weather";

interface WeatherProps {
  current: WeatherType;
  forecast: DailyForecastType;
}

// @TODO: fix this issue. The date is not formatting anymore.
function formatDate(dateTime) {
  const date = new Date(dateTime);
  return date.toLocaleString("en-US", { timeZone: "UTC" });
}

function Current({ current }) {
  return (
    <div className="rounded-2xl bg-linear-to-br from-sky-500 to-indigo-600 p-6 text-white shadow-md">
      <p className="text-sm opacity-80">{formatDate(current.time)}</p>
      <div className="mt-2 flex items-center justify-between">
        <span className="text-6xl font-light">{Math.round(current.temp)}°</span>
      </div>
      <p className="text-sm capitalize opacity-80">
        {current.weather_condition}
      </p>
    </div>
  );
}

function DailyForecast({ key, entry }) {
  return (
    <div className="flex items-center gap-4 border-b border-slate-100 py-3 last:border-0">
      <span className="w-24 text-sm font-medium capitalize text-slate-700">
        {key}
      </span>
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

export function Weather({ current, forecast }: WeatherProps) {
  if (!current) return;
  if (!forecast) return;

  return (
    <div className="space-y-4">
      <Current current={current} />
      <div className="rounded-2xl border border-slate-200 bg-white px-4 shadow-sm">
        <p className="px-4 pt-3 pb-2 text-xs font-semibold uppercase tracking-wider text-slate-600 border-b-0">
          Next days
        </p>
        {Object.keys(forecast).map((key) => (
          <DailyForecast key={key} entry={forecast[key]} />
        ))}
      </div>
    </div>
  );
}
