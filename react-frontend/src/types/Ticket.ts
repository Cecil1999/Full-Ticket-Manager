export interface TicketType {
  name: string
}

export interface Post {
  body: string,
  poster?: string,
}

export interface Ticket {
  id: number,
  title: string,
  body: string,
  created_at: string,
  ticket_type: TicketType,
  updated_at?: string,
  posts?: Array<Post>,
}
