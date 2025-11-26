import { useEffect, useRef } from 'react'
import { SubmitButton } from './SubmitButton.tsx'
import { TextInput } from './TextInput.tsx'
import { useNavigate } from 'react-router'

export function Login() {
  const navigate = useNavigate();
  const preventAPIDoubleCall = useRef<boolean>(false)

  useEffect(() => {
    if (preventAPIDoubleCall.current) return;

    // Jwt token should be the first and only cookie this site uses.
    // if that changes... update accordingly.
    const jwtToken: String = document.cookie.split(';')[0].substring(4);

    if (!jwtToken) return;

    preventAPIDoubleCall.current = true;
    fetch('api/auth/sign_in', {
      method: "POST",
      headers: {
        Authorization: `Bearer ${jwtToken}`,
      },
    }).then(response => response.json())
      .then((res) => {
        //TODO: pop out alert when e happens.
        if (res.e) console.log(res.e);
        if (res.r) navigate('/home');
      })
  }, [])

  const loginAction = (formData: FormData) => {
    const formValues = {
      username: formData.get('username'),
      password: formData.get('password'),
    }

    fetch('api/auth/sign_in', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formValues),
    }).then(response => response.json())
      .then((data) => {
        if (data.e) {
          console.log(data.e);
          return;
        }

        if (data.auth_token) {
          document.cookie = `jwt=${data.auth_token}`;
          navigate('/home')
        }
        else
          console.error(`returned ${data.r}, but no auth_token`);

        return;
      });
  }

  return (
    <div className="flex-1 w-full h-full my-auto">
      <div className="w-128 h-fit mx-auto border border-1 rounded-xl">
        <h1 className="text-3xl text-center p-1">Login</h1>
        <div className="flex flex-col p-4">
          <form action={loginAction}>
            <TextInput type="text" id="username" name="username" />
            <TextInput type="password" id="password" name="password" />
            <SubmitButton type="submit" value="Login" />
          </form>
        </div>
      </div>
    </div >
  )
}
