import type { User } from "../types/User.ts"

export interface Post {
  body: string,
  user: User
}
