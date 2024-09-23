import Grid from '@mui/material/Grid';
import TextField from '@mui/material/TextField';
import { InputFieldLabel } from './InputFieldLabel';
import { useFormContext } from 'react-hook-form';
import { Controller } from 'react-hook-form';

interface InputFieldGroupProps {
  label: string;
  isRequired?: boolean;
  placeholder: string;
  multiline?: boolean;
  rows?: number;
  name: string; // このnameはreact-hook-formのname属性として使われる
}

export const InputFieldGroup: React.FC<InputFieldGroupProps> = ({
  label,
  isRequired = false,
  placeholder,
  multiline = false,
  rows = 1,
  name
}) => {
  const { control } = useFormContext();

  return (
    <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
      {/* 左側のラベル部分 */}
      <InputFieldLabel
        label={label}
        isRequired={isRequired}
      />

      {/* 右側の入力フィールド */}
      <Grid item xs={9}>
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
              {...field}
            />
          )}
        />
      </Grid>
    </Grid>
  );
};
