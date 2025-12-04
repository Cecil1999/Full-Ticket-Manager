import { Routes, Route, Navigate, Outlet } from "react-router";
import { Login } from './Login.tsx'
import { Home } from "./Home.tsx";
import { NotificationBar } from "./NotificationBar.tsx";
import { PageBar } from "./PageBar.tsx";
import { RequireAuth } from "./RequireAuth.tsx";
import { TicketDashboard } from "./TicketDashboard.tsx";
import { Sidebar } from './Sidebar.tsx'

function Layout() {
  return (
    <div className="grid grid-cols-[auto] xl:grid-cols-[16rem_auto] grid-rows-[auto] h-screen" id="parent_grid">
      <div className="col-start-1 xl:col-start-1">
        <Sidebar />
      </div>
      <div className="col-start-1 xl:col-start-2">
        <div className="grid grid-rows-[4rem_auto_auto] grid-cols-7 gap-y-2 gap-x-1 h-screen w-full">
          <PageBar />
          <Outlet />
          <NotificationBar />
        </div>
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
