import { Routes, Route, Navigate, Outlet } from "react-router";
import { Login } from './Login.tsx'
import { Home } from "./Home.tsx";
import { NotificationBar } from "./NotificationBar.tsx";
import { PageBar } from "./PageBarProps.tsx";
import { RequireAuth } from "./RequireAuth.tsx";

function Layout() {
  return (
    <div className="grid grid-rows-[4rem_auto_auto] grid-cols-7 gap-1 h-screen w-full">
      <PageBar />
      <Outlet />
      <NotificationBar />
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
