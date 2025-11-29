export function Home() {
  return <>
    <div className="flex flex-col text-center gap-y-4">
      <h1 className="text-4xl">Home</h1>
      <div className="grid grid-flow-row auto-rows-fr grid-cols-5 gap-x-4 h-screen">
        <div className="col-span-5 p-4 m-2 border border-1 rounded-xl xl:col-span-4">
          <h2 className="text-3xl text-start">Your recently made tickets</h2>
        </div>
        <div className="col-span-5 row-start-2 xl:col-span-4">
          <div className="flex-1 p-4 m-2 border border-1 rounded-xl">
            <h2 className="text-3xl text-start">All Tickets</h2>
          </div>
        </div>
        <div className="col-span-1 col-start-5 row-span-2 m-2 border border-1 rounded-t-xl hidden xl:block">
          <div className="p-4">
            <h2 className="text-3xl text-start">Notifications</h2>
          </div>
        </div>
      </div>
    </div>
  </>
}
