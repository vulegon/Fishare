import React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import { FormSectionTitle } from './components/FormSectionTitle';
import Grid from '@mui/material/Grid';
import TextField from '@mui/material/TextField';
import Chip from '@mui/material/Chip';

const STEP_LABELS = [
  '情報の入力',
  '入力内容の確認',
  '受付完了',
];

export const ContactForm: React.FC = () => {
  return (
    <>
      <CssBaseline />
      <Container fixed>
        <Stack spacing={4}>
          <Box sx={{height: 10}}/>
          <Stepper activeStep={1} >
            {STEP_LABELS.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>

          <FormSectionTitle text="お問い合わせ内容を入力してください" />
          <Grid container spacing={2} sx={{ border: '1px solid #ddd', padding: 2 }}>
            {/* 左側のラベル部分 */}
            <Grid item xs={3} sx={{ backgroundColor: '#EBF5FF', padding: 2 }}>
              <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <Typography variant="body1" sx={{ fontWeight: 'bold' }}>
                  お問い合わせ内容
                </Typography>
                <Chip label="必須" color="warning" size="small" />
              </Box>
            </Grid>

            {/* 右側の入力フィールド */}
            <Grid item xs={9}>
              <TextField
                fullWidth
                multiline
                rows={4}
                variant="outlined"
                placeholder="お問い合わせ内容を入力してください"
              />
            </Grid>
          </Grid>
          <FormSectionTitle text="お客様情報を入力してください" />
        </Stack>
      </Container>
    </>
  );
};


