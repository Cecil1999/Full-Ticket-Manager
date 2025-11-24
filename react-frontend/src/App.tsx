import { Routes, Route, Navigate, Outlet } from "react-router";
import { useState } from "react";

function RequireAuth({ children }: { children: React.ReactNode }) {
  let [logged_in, is_logged_in] = useState(true)

  // TODO: Cookie should ONLY have the jwt. Nothing else.
  // but figure out if theres anything that could be inserted by client or otherwise.
  if (document.cookie.includes("jwt=")) {


  }

  if (!logged_in) {
    return <Navigate to="/login" replace />
  }

  return children;
}

function Layout() {
  return (
    <div className="main">
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
        <Route path="/home" element={<>Hello World</>} />
        <Route path="/dashboard" element={<>Dashboard</>} />

      </Route>

      {/* Public Pages */}
      <Route path="/login" element={<>Login Page</>} />
      {/* Global all Fallback. */}
      <Route path="*" element={<Navigate to="/home" replace />} />
    </Routes>
  );
}
