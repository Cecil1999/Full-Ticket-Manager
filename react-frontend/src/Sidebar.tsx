import { NavItem } from './NavItem.tsx'

const ticketNavs = [
  { path: "/user/:user_id", name: "Profile" },
  { path: "/tickets/", name: "Tickets" }
];

export function Sidebar() {
  return (
    <div className="h-screen md:w-64 sm:w-16 flex flex-col border-r-2 p-4">
      <span className="p-2 mb-4 text-4xl font-bold text-center">
        Logo
      </span>
      {ticketNavs.map((o) => (<NavItem path={o.path} name={o.name} />))}
    </div>
  )
}
