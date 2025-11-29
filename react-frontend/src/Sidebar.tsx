import { NavItem } from './NavItem.tsx';

const desktopTicketNavs = [
  { path: "/user/", name: "Profile" },
  { path: "/tickets/", name: "Tickets" }
];

const mobileTicketNavs = [
  { path: "/tickets/", name: "Tickets" }
];

const smallMenuExpand: React.MouseEventHandler<HTMLButtonElement> = () => {
  const smallMenu: HTMLElement | null = document.getElementById('small_menu');
  if (!smallMenu) {
    //TODO: Have some sort of POST request in WEB API to log errors for back end.
    console.log("Cannot find small menu..?");
  }

  smallMenu.classList.toggle('hidden');
};

export function Sidebar() {
  return <>
    {/* Small Menu */}
    <div className="flex flex-col xl:hidden h-max">
      <div className="p-1 w-full h-max">
        <button onClick={smallMenuExpand} aria-label="Open Hamburger Navigation Menu">
          <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="32" height="32" viewBox="0 0 50 50">
            <path d="M 3 9 A 1.0001 1.0001 0 1 0 3 11 L 47 11 A 1.0001 1.0001 0 1 0 47 9 L 3 9 z M 3 24 A 1.0001 1.0001 0 1 0 3 26 L 47 26 A 1.0001 1.0001 0 1 0 47 24 L 3 24 z M 3 39 A 1.0001 1.0001 0 1 0 3 41 L 47 41 A 1.0001 1.0001 0 1 0 47 39 L 3 39 z"></path>
          </svg>
        </button>
      </div>
      <div className="flex flex-col hidden" id="small_menu">
        {mobileTicketNavs.map((o, i) => (<NavItem key={i} path={o.path} name={o.name} />))}
      </div>
    </div>
    {/* Big Menu */}
    <div className="flex flex-col border-r-2 p-4 hidden xl:block h-16 xl:h-full text-center row-span-full">
      <span className="p-2 mb-4 text-4xl font-bold">
        Logo
      </span>
      {desktopTicketNavs.map((o, i) => (<NavItem key={i} path={o.path} name={o.name} />))}
    </div>
  </>
}
