type NotificationProps = {
  ticket_id: number,
  title: string,
  body: string,
};

export function Notification({ ticket_id, title, body }: NotificationProps) {
  return (
    <a href={`/tickets/${ticket_id}`}>
      <div className="p-4">
        <h4>{title}</h4>
        <p className="overflow-hidden text-ellipsis">
          ${body}
        </p>
      </div>
    </a >
  )
} 
