import { Routes, Route, Navigate, Outlet } from "react-router";
import { Login } from './Login.tsx'
import { Home } from "./Home.tsx";
import { NotificationBar } from "./NotificationBar.tsx";
import { PageBar } from "./PageBar.tsx";
import { RequireAuth } from "./RequireAuth.tsx";
import { TicketDashboard } from "./TicketDashboard.tsx";

function Layout() {
  return (
    <div className="col-start-2 col-span-full">
      <div className="grid grid-rows-[4rem_auto_auto] grid-cols-7 gap-1 h-screen w-full">
        <PageBar />
        <Outlet />
        <NotificationBar />
      </div>
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
        <Route path="/tickets/:ticket_id?" element={<TicketDashboard />} />
      </Route>

      {/* Public Pages */}
      <Route path="/login" element={<Login />} />
      {/* Global all Fallback. */}
      <Route path="*" element={<Navigate to="/home" replace />} />
    </Routes>
  );
}
