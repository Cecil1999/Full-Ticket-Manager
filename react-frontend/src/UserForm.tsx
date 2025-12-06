import { TextInput } from "./TextInput"

export default function UserForm() {
  const handleFormSubmit = (formData: FormData) => {
    //TODO: Need to use update, with current user. I don't want the profile management having access to userid, as FE doesn't have that yet.
    //This means going into the back end and figuring it out.
    //When submitting I need to keep the value of the shit that was changed. Rather not useState X times that's dumb.
  }

  const showPasswordDiv = (ev: React.ChangeEvent<HTMLInputElement>) => {
    const change_password_div = document.getElementById('change_password_div');
    const password_input: HTMLInputElement | null = document.getElementById('password') as HTMLInputElement;
    const password_conf_input: HTMLInputElement | null = document.getElementById('password_confirmation') as HTMLInputElement;

    const isChecked = ev.currentTarget.checked;
    change_password_div?.classList.toggle('hidden', !isChecked);
    password_input.disabled = !isChecked;
    password_conf_input.disabled = !isChecked;
  }

  return <>
    <form action={handleFormSubmit} className="p-2">
      <div className="flex flex-col gap-4">
        <div className="flex-grow">
          <TextInput type="text" id="username" name="username" label="Username" readOnly />
          <label>
            Change Password?
            <input type="checkbox" id="change_password_cb" className="ml-2" onChange={showPasswordDiv} />
          </label>
          <div className="mb-2 p-2 border border-1 hidden" id="change_password_div">
            <TextInput type="password" id="password" name="password" label="Password" disabled />
            <TextInput type="password" id="password_confirmation" name="password_confirmation" label="Password Confirmation" disabled />
          </div>
        </div>
        <div className="flex-none">
          <TextInput type="submit" value="Submit Changes" />
        </div >
      </div>
    </form >
  </>
}
