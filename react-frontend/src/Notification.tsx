import type { Notification } from "./types/Notification.ts";

export function NotificationCard({ ticket_id, title, body }: Notification) {
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
