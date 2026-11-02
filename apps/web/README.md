# Web

## How to execute

First run the package manager to install all dependencies. Use any of your preference like yarn, npm or:

```bash
pnpm install
```

Set the API url in the `.env` file. The backend by default uses the port `3000`:

```ts
VITE_API_URL=http://localhost:3000
```

The backend accepts only requests from `http://localhost:5173` which is the default port used by the app. If you plan to use another port,
make sure to change the backend to support it, otherwise all requests will be blocked.

### Executing

Make sure you're at the correct path within the web folder then:

```bash
pnpm run dev
```
