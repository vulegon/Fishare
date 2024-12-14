import Grid from '@mui/material/Grid';
import { InputFieldLabel } from './InputFieldLabel';
import { useFormContext } from 'react-hook-form';
import { Controller } from 'react-hook-form';
import Typography from '@mui/material/Typography';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

interface SelectBoxGroupProps {
  label: string;
  isRequired?: boolean;
  rows?: number;
  name: string; // このnameはreact-hook-formのname属性として使われる
  activeStep: number;
  selectBoxItems: { value: string; label: string }[];
}

export const SelectBoxGroup: React.FC<SelectBoxGroupProps> = ({
  label,
  isRequired = false,
  name,
  activeStep,
  selectBoxItems,
}) => {
  const {
    control,
    formState: { errors },
  } = useFormContext();

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
          render={({ field }) => {
            const selectedLabel = selectBoxItems.find(item => item.value === field.value)?.label;

            return activeStep === 0 ? (
              <FormControl fullWidth>
                <InputLabel id="demo-simple-select-label">お問い合わせ項目</InputLabel>
                <Select
                  labelId="demo-simple-select-label"
                  id="demo-simple-select"
                  label={label}
                  {...field}
                >
                  {selectBoxItems.map((item) => (
                    <MenuItem key={item.value} value={item.value}>{item.label}</MenuItem>
                  ))}
                </Select>
              </FormControl>
            ) : (
              <Typography>
                {selectedLabel}
              </Typography>
            )
          }}
        />
      </Grid>
    </Grid>
  );
};
