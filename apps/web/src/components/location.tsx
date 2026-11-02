export function Location({ location, onClick }) {
  return (
    <li key={location.display_name} className="border border-b-0">
      <button
        onClick={() => onClick(location)}
        className="flex w-full items-start gap-3 border-b border-slate-100 px-4 py-3 text-left text-sm text-slate-600 hover:bg-slate-50 cursor-pointer"
      >
        {location.display_name}
      </button>
    </li>
  );
}
