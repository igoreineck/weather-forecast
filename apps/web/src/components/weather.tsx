import {
  Item,
  ItemContent,
  ItemDescription,
  ItemTitle,
} from "@/components/ui/item";

function formatDateTime(dt) {
  const data = new Date(dt * 1000);
  return data.toLocaleString("en-US", { timeZone: "UTC" });
}

function Current({ current }) {
  if (!current) {
    return;
  }
  return (
    <Item variant="outline" className="mb-4">
      <ItemContent>
        <ItemTitle>{`${Math.round(current?.main.temp)}°C`}</ItemTitle>
        <ItemDescription>{formatDateTime(current.dt)}</ItemDescription>
      </ItemContent>
    </Item>
  );
}

function Forecast({ forecast }) {
  if (!forecast) {
    return;
  }

  return (
    <div>
      {forecast.map((timeSlice) => (
        <Item variant="outline" className="mb-4">
          <ItemContent>
            <ItemTitle>{`${Math.round(timeSlice?.main.temp)}°C`}</ItemTitle>
            <ItemDescription>{formatDateTime(timeSlice.dt)}</ItemDescription>
          </ItemContent>
        </Item>
      ))}
    </div>
  );
}

export function Weather({ weather }) {
  return (
    <div>
      <Current current={weather.current} />
      <Forecast forecast={weather.forecast} />
    </div>
  );
}
