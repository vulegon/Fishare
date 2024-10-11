import { zodResolver } from '@hookform/resolvers/zod';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import MuiCard from '@mui/material/Card';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';
import Stack from '@mui/material/Stack';
import { styled } from '@mui/material/styles';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import adminApiClient from 'api/v1/admin/adminApiClient';
import { useUser } from 'contexts/UserContext';
import { MainLayout } from 'features/layouts';
import React from 'react';
import { useForm } from 'react-hook-form';
import { useNavigate } from 'react-router-dom';
import { notifySuccess } from 'utils/toast/notifySuccess';
import { EmailSchema } from 'validators/email';
import * as z from 'zod';

const Card = styled(MuiCard)(({ theme }) => ({
  display: 'flex',
  flexDirection: 'column',
  alignSelf: 'center',
  width: '100%',
  padding: theme.spacing(4),
  gap: theme.spacing(2),
  margin: 'auto',
  [theme.breakpoints.up('sm')]: {
    maxWidth: '450px',
  },
  boxShadow:
    'hsla(220, 30%, 5%, 0.05) 0px 5px 15px 0px, hsla(220, 25%, 10%, 0.05) 0px 15px 35px -5px',
  ...theme.applyStyles('dark', {
    boxShadow:
      'hsla(220, 30%, 5%, 0.5) 0px 5px 15px 0px, hsla(220, 25%, 10%, 0.08) 0px 15px 35px -5px',
  }),
}));

const SignInContainer = styled(Stack)(({ theme }) => ({
  padding: 20,
  marginTop: '10vh',
  '&::before': {
    content: '""',
    display: 'block',
    position: 'absolute',
    zIndex: -1,
    inset: 0,
    backgroundImage:
      'radial-gradient(ellipse at 50% 50%, hsl(210, 100%, 97%), hsl(0, 0%, 100%))',
    backgroundRepeat: 'no-repeat',
    ...theme.applyStyles('dark', {
      backgroundImage:
        'radial-gradient(at 50% 50%, hsla(210, 100%, 16%, 0.5), hsl(220, 30%, 5%))',
    }),
  },
}));

const schema = z.object({
  email: EmailSchema,
  password: z.string().min(8, 'パスワードは8文字以上である必要があります'),
});

interface SignIn {
  email: string;
  password: string;
}

export const AdminLoginPage: React.FC = () => {
  const { signIn } = useUser();
  const navigate = useNavigate();
  const {
    handleSubmit,
    register,
    formState: {
      errors,
      isValid,
      isSubmitting
    },
  } = useForm({
    defaultValues: {
      email: '',
      password: '',
    },
    resolver: zodResolver(schema),
    mode: 'all',
  });

  const onSubmit = async (data: SignIn) => {
    try {
      const user = await adminApiClient.signIn(data.email, data.password);
      signIn(user);
      notifySuccess('管理者でログインしました');
      navigate('/admin/dashboards');
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <MainLayout>
      <SignInContainer direction="column" justifyContent="space-between">
        <Card variant="outlined">
          <Typography
            component="h1"
            variant="h4"
            sx={{ width: '100%', fontSize: 'clamp(2rem, 10vw, 2.15rem)' }}
          >
            管理者ログイン
          </Typography>
          <Typography
            component="p"
            variant="body1"
            sx={{ width: '100%', fontSize: 'clamp(1rem, 1vw, 1rem)', color: 'red' }}
          >
            ここは管理者ログインページです。<br/>一般の方はログインできません。
          </Typography>
          <form onSubmit={handleSubmit(onSubmit)}>
            <Box
              sx={{
                display: 'flex',
                flexDirection: 'column',
                width: '100%',
                gap: 2,
              }}
            >
              <FormControl>
                <FormLabel htmlFor="email">メールアドレス</FormLabel>
                <TextField
                  id="email"
                  type="email"
                  placeholder="your@email.com"
                  autoComplete="email"
                  autoFocus
                  required
                  fullWidth
                  variant="outlined"
                  sx={{ ariaLabel: 'email' }}
                  {...register('email')}
                  error={!!errors.email} // バリデーションエラーがあれば true
                  helperText={errors.email?.message} // エラーメッセージを表示
                />
              </FormControl>
              <FormControl>
                <Box sx={{ display: 'flex', justifyContent: 'space-between' }}>
                  <FormLabel htmlFor="password">パスワード</FormLabel>
                </Box>
                <TextField
                  id="password"
                  type="password"
                  placeholder="●●●●●●●●●●"
                  autoComplete="password"
                  autoFocus
                  required
                  fullWidth
                  variant="outlined"
                  sx={{ ariaLabel: 'password' }}
                  {...register('password')}
                  error={!!errors.password} // バリデーションエラーがあれば true
                  helperText={errors.password?.message} // エラーメッセージを表示
                />
              </FormControl>
              <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}/>
              <Button
                type="submit"
                fullWidth
                variant="contained"
                disabled={!isValid || isSubmitting}
              >
                ログイン
              </Button>
            </Box>
          </form>
          <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}/>
        </Card>
      </SignInContainer>
    </MainLayout>
  );
};
