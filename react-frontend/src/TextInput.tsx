import { nameCase } from "@foundernest/namecase";
import type { InputHTMLAttributes } from "react";

interface expectedInputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string,
  extraClasses?: string,
};

export function TextInput(passedProps: expectedInputProps) {
  const classNames = passedProps.type?.match(/submit|button/i)
    ? "p-4 border border-1 border-white rounded-xl bg-indigo-700 hover:bg-indigo-500 text-white"
    : "w-full p-2 border border-1 rounded-md";

  return <>
    <div className="mb-4">
      {passedProps.label
        ? <div><label htmlFor={passedProps.id}>{nameCase(passedProps.label)}</label></div>
        : <></>
      }
      <div className="w-full">
        <input type={passedProps.type} className={`${classNames} ${passedProps.extraClasses || ''}`} {...passedProps} />
      </div>
    </div>
  </>;
}
