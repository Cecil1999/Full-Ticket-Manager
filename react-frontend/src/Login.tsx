import { SubmitButton } from './SubmitButton.tsx'
import { TextInput } from './TextInput.tsx'

export function Login() {
  const loginAction = (formData: FormData) => {

    const formValues = {
      username: formData.get('username'),
      password: formData.get('password'),
    }

    fetch('web-api/auth/sign_in', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formValues),
    }).then(response => console.log(response.json));
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
