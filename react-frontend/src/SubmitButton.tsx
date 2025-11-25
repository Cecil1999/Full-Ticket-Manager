import { nameCase } from "@foundernest/namecase";

type expectedInputButton = "submit" | "button";

interface expectedInputProps {
  type: expectedInputButton,
  value: string,
  extraClasses?: string
};

export function SubmitButton({ type, value, extraClasses }: expectedInputProps) {
  return <>
    <input type={type} value={nameCase(value)} className={`p-4 border border-1 border-white rounded-xl bg-indigo-700 hover:bg-indigo-500 text-white ${extraClasses}`} />
  </>
}
