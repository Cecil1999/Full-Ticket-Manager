import type { Post } from "./types/Post";

export function TicketPost({ body, user }: Post) {
  return <>
    <div className="border border-1 rounded-xl p-4">
      {body} - {user.username}
    </div>
  </>
}
