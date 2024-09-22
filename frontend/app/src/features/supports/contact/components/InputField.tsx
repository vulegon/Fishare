import Grid from '@mui/material/Grid';
import TextField from '@mui/material/TextField';
import Chip from '@mui/material/Chip';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

interface InputFieldProps {
  label: string;
  isRequired?: boolean;
  placeholder: string;
  multiline?: boolean;
  rows?: number;
}

export const InputField: React.FC<InputFieldProps> = ({
  label,
  isRequired = false,
  placeholder,
  multiline = false,
  rows = 1,
}) => {

  return (
    <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
      {/* 左側のラベル部分 */}
      <Grid item xs={3} sx={{ backgroundColor: '#EBF5FF', padding: 2 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
            {label}
          </Typography>
          {isRequired && <Chip label="必須" color="warning" size="small" />}
        </Box>
      </Grid>

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
