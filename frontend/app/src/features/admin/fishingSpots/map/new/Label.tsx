import { Typography, Box } from "@mui/material";

interface LabelProps {
  label: string;
  icon?: JSX.Element;
}

export const Label: React.FC<LabelProps> = ({
  label,
  icon
}) => {
  return (
    <Box
      sx={{
        display: 'flex',
        gap: 1
      }}
    >
      {icon}
      <Typography
        variant="body1"
        sx={{
          fontWeight: 'bold',
          mb: 1
        }}
      >
        {label}
      </Typography>
    </Box>
  )
};
