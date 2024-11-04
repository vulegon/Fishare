import TextField from '@mui/material/TextField';
import { useFormContext } from 'react-hook-form';
import { Controller } from 'react-hook-form';

interface InputFieldGroupProps {
  name: string; // このnameはreact-hook-formのname属性として使われる
  placeholder?: string;
  multiline?: boolean;
  rows?: number;
}

// react-hook-formのControllerを使ってTextFieldをラップ
export const InputTextField: React.FC<InputFieldGroupProps> = ({
  name,
  placeholder = '',
  multiline = false,
  rows = 1,
}) => {
  const {
    control,
    formState: { errors },
  } = useFormContext();

  return (
    <Controller
      name={name}
      control={control}
      render={({ field }) => (
        <TextField
          id={name}
          fullWidth
          multiline={multiline}
          rows={rows}
          variant="outlined"
          placeholder={placeholder}
          error={!!errors[name]}
          helperText={errors[name]?.message?.toString()}
          {...field}
        />
      )}
    />
  );
};
