import type { Team } from "./Team.ts"
import type { Role } from "./Role.ts"

// TODO: Might be better as a class?
export type User = {
  id?: number,
  username: string,
  email: string,
  teams?: Array<Team>,
  roles?: Array<Role>,
}

