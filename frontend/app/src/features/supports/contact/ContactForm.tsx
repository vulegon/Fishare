import React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import Container from '@mui/material/Container';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import { SectionTitle, FileUploaderField, InputField } from './components/';
import { useForm } from 'react-hook-form';
import * as z from 'zod';
import { EmailSchema } from 'validators/email';
import { zodResolver } from "@hookform/resolvers/zod";

const schema = z.object({
  name: z.string().min(1).max(50),
  email: EmailSchema,
  contactContent: z.string().min(1).max(1000),
  images: z.array(z.instanceof(File)).max(9),
});

const STEP_LABELS = [
  '情報の入力',
  '入力内容の確認',
  '受付完了',
];

export const ContactForm: React.FC = () => {
  const {
    register,
    handleSubmit,
    formState: { errors }
  } = useForm({
    resolver: zodResolver(schema),
    defaultValues: {
      name: '',
      email: '',
      contactContent: '',
      images: [],
    }
  });

  const onSubmit = (data: any) => {

  };

  const [images, setImages] = React.useState<File[]>([]);

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
          <SectionTitle text="お問い合わせ内容を入力してください" />
          <form onSubmit={handleSubmit(onSubmit)}>
            <InputField
              label="お問い合わせ内容"
              isRequired
              placeholder="ご質問内容を入力してください"
              multiline
              rows={10}
            />
            <FileUploaderField images={images} setImages={setImages} />
            <SectionTitle text="お客様情報を入力してください" />
            <InputField
              label="お名前"
              isRequired
              placeholder="例）山田 太郎"
            />
            <InputField
              label="メールアドレス"
              isRequired
              placeholder="例）example@gmail.com"
            />
          </form>
        </Stack>
      </Container>
    </>
  );
};


