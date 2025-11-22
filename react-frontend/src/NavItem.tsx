interface NavItemProps {
  path: string,
  name: string,
  disabled?: boolean,
}

export function NavItem({ path, name, disabled }: NavItemProps) {
  return (
    <div className="p-2 text-center text-2xl">
      <a href={`${path}`} className={disabled ? "pointer-events-none" : ""}>
        <button className="">
          {name}
        </button>
      </a>
    </div >
  )
}


