import type { DailyForecastType, WeatherType } from "@/api/get-weather";
import { Current } from "./weather-current";
import { DailyForecast } from "./daily-forecast";
import { CacheInfo } from "./cache-info";

interface WeatherProps {
  weather: {
    current: WeatherType;
    forecast: DailyForecastType;
    cached: boolean;
    fetched_at: string;
  };
  isLoading: boolean;
  refreshCallback: () => {};
}

export function Weather({
  weather: { current, forecast, cached, fetched_at: fetchedAt },
  isLoading,
  refreshCallback,
}: WeatherProps) {
  if (!current) return;
  if (!forecast) return;

  if (isLoading) {
    return <div className="space-y-4">Loading...</div>;
  }

  const fiveDayForecast = Object.keys(forecast).slice(1);

  return (
    <div className="space-y-4">
      <CacheInfo
        cached={cached}
        fetchedAt={fetchedAt}
        refreshCallback={refreshCallback}
      />
      <Current current={current} />
      <div className="rounded-2xl border border-slate-200 bg-white px-4 shadow-sm">
        <div className="pt-3 pb-2 text-xs font-semibold uppercase tracking-wider text-slate-600 border-b-0">
          Next days
        </div>
        {fiveDayForecast.map((key) => (
          <DailyForecast time={key} entry={forecast[key]} />
        ))}
      </div>
    </div>
  );
}
