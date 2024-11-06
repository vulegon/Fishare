import { Controller, useFormContext } from 'react-hook-form';
import Autocomplete from '@mui/material/Autocomplete';
import Chip from '@mui/material/Chip';
import TextField from '@mui/material/TextField';
import { Fish } from 'interfaces/api';

interface FishingSpotFishSelecterProps {
  name: string;
  fish: Fish[];
}

export const FishingSpotFishSelecter: React.FC<FishingSpotFishSelecterProps> = ({
  name,
  fish,
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
        <Autocomplete
          {...field}
          multiple
          id='fihsing-spot-tags'
          options={fish.map((f) => f.name)}
          freeSolo
          value={field.value || []}
          onChange={(event, newValue) => field.onChange(newValue)}
          renderTags={(value: readonly string[], getTagProps) =>
            value.map((option: string, index: number) => (
              <Chip
                {...getTagProps({ index })}
                key={option}
                color='primary'
                variant='outlined'
                label={option}
              />
            ))
          }
          renderInput={(params) => (
            <TextField
              {...params}
              label='釣れる魚'
              error={!!errors[name]}
              helperText={errors[name]?.message?.toString()}
            />
          )}
        />
      )}
    />
  );
};
