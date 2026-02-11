import type { Post } from "./types/Post";

export function TicketPost({ body, user }: Post) {
  return <>
    <div className="flex-1 min-h-0 border border-1 rounded-xl p-4 mr-2 mt-4">
      {body} - {user?.username}
    </div>
  </>
}
