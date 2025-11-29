import { useEffect } from "react"

export function NotificationBar() {
  useEffect(() => {
    // TODO: API call for "Notifications".
  }, [])

  return <>
    <div className="col-span-1 col-start-7 row-span-full row-start-1 m-2 border border-1 rounded-xl hidden 2xl:block">
      <div className="p-4">
        <h2 className="text-3xl text-center">Notifications</h2>
        <div className="border-b-1"></div>
      </div>
    </div>
  </>
}
