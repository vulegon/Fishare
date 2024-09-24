import Grid from '@mui/material/Grid';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

interface InputFieldLabelProps {
  label: string;
  isRequired: boolean;
}

export const InputFieldLabel: React.FC<InputFieldLabelProps> = ({
  label,
  isRequired
}) => {
  return (
    <Grid item xs={3} sx={{ backgroundColor: '#EBF5FF', padding: 2 }}>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
          {label}
        </Typography>
        {isRequired && <Chip label="必須" color="error" size="small" />}
      </Box>
    </Grid>
  );
};
