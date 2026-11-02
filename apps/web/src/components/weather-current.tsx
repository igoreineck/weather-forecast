const options = {
  weekday: "long",
  day: "numeric",
  month: "short",
  hour: "numeric",
  minute: "numeric",
  hour12: false,
  timeZone: "UTC",
};

function formatDate(date: string, options: {}) {
  return new Date(date).toLocaleString("en-US", options);
}

export function Current({ current }) {
  return (
    <div className="rounded-2xl bg-linear-to-br from-sky-500 to-indigo-600 p-6 text-white shadow-md">
      <p className="text-sm opacity-80">
        {formatDate(current.time, options)} - Temperature (°C)
      </p>
      <div className="mt-2 flex items-center justify-between">
        <span className="text-6xl font-light">{Math.round(current.temp)}°</span>
        <img src={current.weather_icon_url} alt="" className="h-20 w-20" />
      </div>
      <p className="text-sm capitalize opacity-80">
        {current.weather_condition}
      </p>
    </div>
  );
}
