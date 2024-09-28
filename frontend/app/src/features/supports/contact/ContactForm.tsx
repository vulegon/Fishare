import { zodResolver } from '@hookform/resolvers/zod';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import SendIcon from '@mui/icons-material/Send';
import { Alert } from '@mui/material';
import AlertTitle from '@mui/material/AlertTitle';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import CssBaseline from '@mui/material/CssBaseline';
import Stack from '@mui/material/Stack';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import Stepper from '@mui/material/Stepper';
import apiClient from 'api/v1/apiClient';
import React from 'react';
import { FormProvider, useForm } from 'react-hook-form';
import { EmailSchema } from 'validators/email';
import * as z from 'zod';
import { FileUploaderField, FormButton, InputFieldGroup, SectionTitle } from './components/';
import { ContactData } from './interfaces/ContactData';

const schema = z.object({
  name: z.string().min(2, '名前は2文字以上である必要があります').max(50, '名前は50文字以内で入力してください'),
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
  const [activeStep, setActiveStep] = React.useState(0);
  const useFormMethods = useForm({
    defaultValues: {
      name: '',
      email: '',
      contactContent: '',
      images: [] as File[],
    },
    resolver: zodResolver(schema),
    mode: 'onChange'
  });
  const {
    handleSubmit,
    setValue,
    watch,
    formState: {
      errors,
      isValid,
      isSubmitting,
    },
  } = useFormMethods;

  const images = watch('images');

  const onSubmit = async (data: ContactData) => {
    try {
      const res = await apiClient.createContact(
        {
          name: data.name,
          email: data.email,
          contactContent: data.contactContent,
          images: data.images,
        }
      );
      setActiveStep((prevActiveStep) => prevActiveStep + 1);
    } catch (err) {
      console.error(err);
    }
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

  // zodのバリデーションを効かせるためにhandleSubmitをラップ
  const handleNext = handleSubmit(() => {
    setActiveStep((prevActiveStep) => prevActiveStep + 1);
  });

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };

  return (
    <>
      <CssBaseline />
      <Container fixed>
        <Stack spacing={4}>
          <Box sx={{height: 30}}/>
          <Stepper activeStep={activeStep} >
            {STEP_LABELS.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>
          {activeStep !== 2 ? (
            <>
              <SectionTitle text={`お問い合わせ内容を${activeStep === 0 ? '入力' : '確認'}してください`} />
              <FormProvider {...useFormMethods}>
                <form onSubmit={handleSubmit(onSubmit)}>
                  <Stack spacing={4}>
                    <InputFieldGroup
                      label="お問い合わせ内容"
                      isRequired
                      placeholder="お問い合わせ内容を入力してください"
                      multiline
                      rows={10}
                      name="contactContent"
                      activeStep={activeStep}
                    />
                    <FileUploaderField
                      images={images}
                      handleOnAddFile={handleOnAddFile}
                      handleOnDeleteFile={handleOnDeleteFile}
                      activeStep={activeStep}
                    />
                    <SectionTitle text={`お客様情報を${activeStep === 0 ? '入力' : '確認'}してください`} />
                    <InputFieldGroup
                      label="お名前"
                      isRequired
                      placeholder="例）山田 太郎"
                      name="name"
                      activeStep={activeStep}
                    />
                    <InputFieldGroup
                      label="メールアドレス"
                      isRequired
                      placeholder="例）example@gmail.com"
                      name="email"
                      activeStep={activeStep}
                    />

                    <Stack direction="row" justifyContent="center">
                      {activeStep === 0 ? (
                        <FormButton
                          label="入力内容の確認"
                          backgroundColor="#ED6C03"
                          handleOnClick={handleNext}
                          setIcon={<ArrowForwardIosIcon />}
                          disabled={!isValid}
                        />
                        ) : (
                          <Stack direction="row" justifyContent="center" spacing={10}>
                            <FormButton
                              label="戻る"
                              variant="outlined"
                              isSubmit={false}
                              handleOnClick={handleBack}
                            />
                            <FormButton
                              label="送信"
                              handleOnClick={handleSubmit(onSubmit)}
                              setIcon={<SendIcon />}
                              disabled={!isValid || isSubmitting}
                            />
                          </Stack>
                        )}
                    </Stack>
                    <Box sx={{height: '5rem'}}/>
                  </Stack>
                </form>
              </FormProvider>
            </>
          ):(
            <Alert severity="success">
              <AlertTitle>お問い合わせ完了</AlertTitle>
              お問い合わせを受け付けました。ご入力いただいたメールアドレスに確認メールを送信しましたのでご確認ください。
            </Alert>
          )}
        </Stack>
      </Container>
    </>
  );
};
