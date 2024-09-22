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
import { FormRow } from './components/FormRow';

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
          <FormRow label="お問い合わせ内容" isRequired placeholder="ご質問内容を入力してください" multiline rows={10} />
          <FormSectionTitle text="お客様情報を入力してください" />

          <FormRow label="お名前" isRequired placeholder="例）山田 太郎" />
          <FormRow label="メールアドレス" isRequired placeholder="例）example@gmail.com" />
        </Stack>
      </Container>
    </>
  );
};


