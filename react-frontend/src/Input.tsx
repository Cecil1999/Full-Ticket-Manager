interface expectedInputProps {
  type: string,
  id: string,
  name: string,
  extraClasses?: string,
};

export function textInput({ type, id, name, extraClasses }: expectedInputProps) {
  return (
    <input type={type} id={id} name={name} className={`p-4 border border-1 ${extraClasses}`} />
  );
}
