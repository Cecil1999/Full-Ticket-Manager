import type { User } from "./User";

export interface Post {
  body: string,
  user?: User,
}
