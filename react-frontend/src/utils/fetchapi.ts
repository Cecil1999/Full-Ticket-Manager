export async function fetchApi(path: string, method: string) {
  let jwtToken: string | unknown = document.cookie.split(';')[0].substring(4).trim();
  try {
    let authCheck = await fetch('/api/v1/auth/check', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    });

    authCheck = await authCheck.json();

    // Likely better way to do this, (interfaces and all). But for now this should be okay. I believe.
    if ("e" in authCheck) {
      jwtToken = '';
      document.cookie = "jwt=; expires=" + new Date(0).toUTCString();
      let fetchToken = await fetch('/api/v1/auth/refresh_token');
      fetchToken = await fetchToken.json();

      if ("e" in fetchToken) {
        console.log(fetchToken.e);
        return;
      }

      // Since we have a
      if ("auth_token" in fetchToken && "r" in fetchToken) {
        if (typeof fetchToken.auth_token === 'string' && fetchToken.r === 1) {
          jwtToken = fetchToken.auth_token;
          document.cookie = `jwt=${fetchToken.auth_token}`;
        }
      }
    }

    if (!jwtToken)
      throw new Error("Did not receive token");

    document.cookie = `jwt=${jwtToken}`;

  } catch (e) {
    console.error('Failed to verify user', e);
    return;
  }

  return fetch(`${path}`, {
    method: `${method}`,
    headers: {
      Authorization: `Bearer ${jwtToken}`,
    },
  }).then(Response => Response.json())
    .catch(e => console.error('Failed to make fetch request', e));
}

