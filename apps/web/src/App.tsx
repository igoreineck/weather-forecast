import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Homepage } from "./pages/app/homepage";

const queryClient = new QueryClient();

export default function App() {
  return (
    <div className="min-h-screen w-screen p-8">
      <div className="container mx-auto">
        <QueryClientProvider client={queryClient}>
          <Homepage />
        </QueryClientProvider>
      </div>
    </div>
  );
}
