import { Chip } from '@mui/material';

interface CategoryItemProps {
  label: string;
}

export const CategoryItem: React.FC<CategoryItemProps> = ({
  label
}) => {
  return (
    <Chip
      size="medium"
      label={ label }
      sx={{
        backgroundColor: 'transparent',
        border: 'none',
      }}
    />
  )
};
