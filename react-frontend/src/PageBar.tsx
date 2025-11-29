interface PageBarProps {
  title?: string
}

export function PageBar({ title }: PageBarProps) {
  return <>
    <div className="col-span-7 xl:col-span-6 gap-y-2 xl:gap-y-0 pt-4 row-span-1 text-center h-full w-full">
      <h1 className="text-3xl">{title ? title : 'Unknown Title'}</h1>
    </div>
  </>
}
