import { nameCase } from "@foundernest/namecase";

type TextType = "text" | "password" | "email";

interface expectedInputProps {
  type: TextType,
  id: string,
  name: string,
  extraClasses?: string,
};

export function TextInput({ type, id, name, extraClasses }: expectedInputProps) {
  return <>
    <div className="mb-4">
      <div className="">
        <label htmlFor={name}>{nameCase(name)}</label>
      </div>
      <div className="w-full">
        <input type={type} id={id} name={name} className={`w-full p-2 border border-1 rounded-md ${extraClasses}`} />
      </div>
    </div>
  </>;
}
