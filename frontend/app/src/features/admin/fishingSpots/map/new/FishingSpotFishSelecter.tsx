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
          options={fish.map((f) => ({ id: f.id, name: f.name }))}
          getOptionLabel={(option) => option.name}
          isOptionEqualToValue={(option, value) => option.id === value.id}
          value={field.value ?? []}
          onChange={(event, newValue) => field.onChange(newValue)}
          renderTags={(value, getTagProps) =>
            value.map((option, index) => (
              <Chip
                {...getTagProps({ index })}
                key={option.id}
                color="primary"
                variant="outlined"
                label={option.name}
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
