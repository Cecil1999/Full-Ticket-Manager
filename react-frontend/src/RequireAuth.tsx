import { useState, useEffect } from "react";
import { useLocation, Navigate } from "react-router";

export function RequireAuth({ children }: { children: React.ReactNode }) {
  let [loggedIn, isLoggedIn] = useState<boolean | null>(null);
  const location = useLocation();

  useEffect(() => {
    isLoggedIn(document.cookie.includes('jwt='))
  }, [])

  if (loggedIn === null) {
    return null;
  }

  // TODO: Cookie should ONLY have the jwt. Nothing else.
  // but figure out if theres anything that could be inserted by client or otherwise.
  if (!loggedIn) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  return <>{children}</>;
}
