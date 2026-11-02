import type { DailyForecastType, WeatherType } from "@/api/get-weather";
import { Current } from "./weather-current";
import { DailyForecast } from "./daily-forecast";

interface WeatherProps {
  weather: {
    current: WeatherType;
    forecast: DailyForecastType;
  };
  isLoading: boolean;
}

export function Weather({
  weather: { current, forecast },
  isLoading,
}: WeatherProps) {
  if (!current) return;
  if (!forecast) return;

  if (isLoading) {
    return <div className="space-y-4">Loading...</div>;
  }

  const fiveDayForecast = Object.keys(forecast).slice(1);

  return (
    <div className="space-y-4">
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
