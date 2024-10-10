import React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

interface SectionTitleProps {
  text: string;
}

export const SectionTitle: React.FC<SectionTitleProps> = ({ text }) => {
  return (
    <Box
      sx={{
        display: 'flex',
        alignItems: 'center',
        background: 'linear-gradient(to right, #1976D2 1%, transparent 1%)', // 左側1%のみ青色
        padding: '8px', // 内側の余白
      }}
    >
      <Typography variant="h6" sx={{ fontWeight: 'bold', marginLeft: '10px' }}>
        {text}
      </Typography>
    </Box>
  );
};
