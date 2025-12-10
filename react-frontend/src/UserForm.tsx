import { useRef } from 'react';
import { TextInput } from "./TextInput"
import type { User } from "./types/User.ts";

interface userFormProps {
  user: User
}

export default function UserForm({ user }: userFormProps) {
  const changingPassword = useRef<boolean>(false);

  const handleFormSubmit: React.FormEventHandler<HTMLFormElement> = (ev) => {
    ev.preventDefault();

    const form = ev.currentTarget;
    const formData = new FormData(form);

    const values: { [key: string]: any } = {
      username: formData.get('username'),
      email: formData.get('email'),
    };

    if (changingPassword.current) {
      values.password = formData.get('password');
      values.password_confirmation = formData.get('password_confirmation');
    }

    //TODO: Need to use update, with current user. I don't want the profile management having access to userid, as FE doesn't have that yet.
    //This means going into the back end and figuring it out.
    //When submitting I need to keep the value of the shit that was changed. Rather not useState X times that's dumb.
    const jwtToken: String = document.cookie.split(';')[0].substring(4);
    fetch('/api/v1/users/update', {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${jwtToken}`,
      },
      body: JSON.stringify(values),
    }).then(Response => Response.json())
      .then((data) => {
        if (data.e) {
          console.log(data.e);
          return;
        }

        // TODO: "Alert", add alert.
      })
  }

  const showPasswordDiv = (ev: React.ChangeEvent<HTMLInputElement>) => {
    const change_password_div = document.getElementById('change_password_div');
    const password_input: HTMLInputElement | null = document.getElementById('password') as HTMLInputElement;
    const password_conf_input: HTMLInputElement | null = document.getElementById('password_confirmation') as HTMLInputElement;

    const isChecked = ev.currentTarget.checked;
    changingPassword.current = isChecked;
    change_password_div?.classList.toggle('hidden', !isChecked);
    password_input.disabled = !isChecked;
    password_conf_input.disabled = !isChecked;
  }

  return <>
    <form onSubmit={handleFormSubmit} className="p-2" method="POST">
      <div className="flex flex-col gap-4">
        <div className="flex-grow">
          <TextInput type="text" id="username" name="username" label="Username" value={user.username} readOnly />
          <TextInput type="text" id="email" name="email" label="Email" defaultValue={user.email} />
          <label>
            Change Password?
            <input type="checkbox" id="change_password_cb" className="ml-2" onChange={showPasswordDiv} />
          </label>
          <div className="mb-2 p-2 border border-1 hidden" id="change_password_div">
            <TextInput type="password" id="password" name="password" label="Password" disabled />
            <TextInput type="password" id="password_confirmation" name="password_confirmation" label="Password Confirmation" disabled />
          </div>
        </div>
        <div className="flex-1 flex">
          <div className="flex-1">
            <h3 className="text-xl text-center w-full">Roles</h3>
            <ul className="list-none px-4">
              {/* TODO: Style: Pill these. */}
              {user.roles ? user.roles.map((o) => (<li>{o.name}</li>)) : (<li>None</li>)}
            </ul>
          </div>
          <div className="flex-1">
            <h3 className="text-xl text-center w-full">Teams</h3>
            <ul className="list-none px-4">
              {/* TODO: Pill these. */}
              {user.teams ? user.teams.map((o) => (<li>{o.name}</li>)) : (<li>None</li>)}
            </ul>
          </div>
        </div>
        <div className="flex-none">
          <TextInput type="submit" value="Submit Changes" />
        </div>
      </div>
    </form >
  </>
}
