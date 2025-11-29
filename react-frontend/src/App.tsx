import { Routes, Route, Navigate, useLocation, Outlet } from "react-router";
import { useState, useEffect } from "react";
import { Login } from './Login.tsx'
import { Home } from "./Home.tsx";

function RequireAuth({ children }: { children: React.ReactNode }) {
  let [loggedIn, isLoggedIn] = useState<boolean | null>(null);
  const location = useLocation();

  useEffect(() => {
    isLoggedIn(document.cookie.includes('jwt='))
  }, [])

  if (loggedIn === null) {
    return null;
  }

  // TODO: Cookie should ONLY have the jwt. Nothing else.
  // but figure out if theres anything that could be inserted by client or otherwise.
  if (!loggedIn) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  return <>{children}</>;
}

function Layout() {
  return (
    <div className="flex-1">
      <Outlet />
    </div>
  );
}
// TODO: Login component should also redirect to home if theres someone signed in -.-.
export function App() {
  return (
    <Routes>
      {/* Routes behind a Auth check. */}
      <Route element={<RequireAuth><Layout /></RequireAuth>}>
        <Route path="/home" element={<Home />} />
        <Route path="/dashboard" element={<>Dashboard</>} />

      </Route>

      {/* Public Pages */}
      <Route path="/login" element={<Login />} />
      {/* Global all Fallback. */}
      <Route path="*" element={<Navigate to="/home" replace />} />
    </Routes>
  );
}
