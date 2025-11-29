import { NavItem } from './NavItem.tsx'

const ticketNavs = [
  { path: "/user/", name: "Profile" },
  { path: "/tickets/", name: "Tickets" }
];

export function Sidebar() {
  return (
    <div className="flex-none h-screen md:w-64 sm:w-16 flex flex-col border-r-2 p-4">
      <span className="p-2 mb-4 text-4xl font-bold text-center">
        Logo
      </span>
      {ticketNavs.map((o, i) => (<NavItem key={i} path={o.path} name={o.name} />))}
    </div>
  )
}
