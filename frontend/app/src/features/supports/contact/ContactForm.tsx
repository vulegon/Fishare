import React from 'react';
import CssBaseline from '@mui/material/CssBaseline';
import Container from '@mui/material/Container';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import { SectionTitle, FileUploaderField, InputFieldGroup } from './components/';
import { FormProvider, useForm } from 'react-hook-form';
import * as z from 'zod';
import { EmailSchema } from 'validators/email';
import Button from '@mui/material/Button';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import { zodResolver } from '@hookform/resolvers/zod';

const schema = z.object({
  name: z.string().min(1, '名前は必須です').max(50, '名前は50文字以内で入力してください'),
  email: EmailSchema,
  contactContent: z.string().min(10, 'お問い合わせ内容は10文字以上である必要があります').max(1000, 'お問い合わせ内容は1000文字以内で入力してください'),
  images: z.array(z.instanceof(File)).max(9, '画像は最大9枚までです'),
});

const STEP_LABELS = [
  '情報の入力',
  '入力内容の確認',
  '受付完了',
];

export const ContactForm: React.FC = () => {
  const useFormMethods = useForm({
    defaultValues: {
      name: '',
      email: '',
      contactContent: '',
      images: [] as File[],
    },
    resolver: zodResolver(schema)
  });
  const {
    handleSubmit,
    setValue,
    watch,
    formState: { errors }
  } = useFormMethods;

  const images = watch('images');

  const onSubmit = (data: any) => {
    console.log(data);
  };

  // 画像の追加処理
  const handleOnAddFile = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) return;
    const files: File[] = [];
    const remainingSlots = 9 - images.length;

    for (let i = 0; i < Math.min(e.target.files.length, remainingSlots); i++) {
      files.push(e.target.files[i]);
    }

    // react-hook-formのsetValueでimagesを更新
    setValue('images', [...images, ...files]);
    e.target.value = '';
  };

  // 画像の削除処理
  const handleOnDeleteFile = (index: number) => {
    const updatedImages = [...images];
    updatedImages.splice(index, 1);
    setValue('images', updatedImages);
  };

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
          <FormProvider {...useFormMethods}>
            <form onSubmit={handleSubmit(onSubmit)}>
              <Stack spacing={4}>
                <InputFieldGroup
                  label="お問い合わせ内容"
                  isRequired
                  placeholder="ご質問内容を入力してください"
                  multiline
                  rows={10}
                  name="contactContent"
                />
                <FileUploaderField
                  images={images}
                  handleOnAddFile={handleOnAddFile}
                  handleOnDeleteFile={handleOnDeleteFile}
                />
                <SectionTitle text="お客様情報を入力してください" />
                <InputFieldGroup
                  label="お名前"
                  isRequired
                  placeholder="例）山田 太郎"
                  name="name"
                />
                <InputFieldGroup
                  label="メールアドレス"
                  isRequired
                  placeholder="例）example@gmail.com"
                  name="email"
                />

                <Stack direction="row" justifyContent="center">
                  <Button
                    variant="contained"
                    color="primary"
                    type="submit"
                    style={{
                      borderRadius: '50px', // 丸みを帯びたボタンにする
                      padding: '10px 20px',
                      fontSize: '1.2rem',
                      width: '300px',
                      backgroundColor: '#ED6C03',
                      fontWeight: 'bold'
                    }}
                    startIcon={<ArrowForwardIosIcon />}
                  >
                    入力内容の確認
                  </Button>
                </Stack>
                <Box sx={{height: '5rem'}}/>
              </Stack>
            </form>
          </FormProvider>
        </Stack>
      </Container>
    </>
  );
};


