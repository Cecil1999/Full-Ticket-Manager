interface PageBarProps {
  title?: string
}

export function PageBar({ title }: PageBarProps) {
  return <>
    <div className="col-span-6 pt-4 row-span-1 text-center h-8">
      <h1 className="text-3xl">{title ? title : 'Unknown Title'}</h1>
    </div>
  </>
}
