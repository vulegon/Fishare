import Grid from '@mui/material/Grid';
import TextField from '@mui/material/TextField';
import { InputFieldLabel } from './InputFieldLabel';

interface InputFieldGroupProps {
  label: string;
  isRequired?: boolean;
  placeholder: string;
  multiline?: boolean;
  rows?: number;
}

export const InputFieldGroup: React.FC<InputFieldGroupProps> = ({
  label,
  isRequired = false,
  placeholder,
  multiline = false,
  rows = 1,
}) => {

  return (
    <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
      {/* 左側のラベル部分 */}
      <InputFieldLabel
        label={label}
        isRequired={isRequired}
      />

      {/* 右側の入力フィールド */}
      <Grid item xs={9}>
        <TextField
          fullWidth
          multiline={multiline}
          rows={rows}
          variant="outlined"
          placeholder={placeholder}
        />
      </Grid>
    </Grid>
  );
};
