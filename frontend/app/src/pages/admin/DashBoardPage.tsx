import React from 'react';
import { MainLayout } from 'features/layouts';
import { Box, Grid } from '@mui/material';
import Stack from '@mui/material/Stack';
import { styled } from '@mui/material/styles';
import SupportAgentIcon from '@mui/icons-material/SupportAgent';
import { DashboardCard } from 'features/admin/dashBoards/components/DashBoardCard';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFish } from '@fortawesome/free-solid-svg-icons';

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

export const DashBoardPage: React.FC = () => {
  const dashBoardCards =[
    {
      label: '釣り場の作成・更新',
      backGroundColor: 'linear-gradient(135deg, #3dd5f3 0%, #28a4d9 100%)',
      icon: <FontAwesomeIcon icon={faFish} style={{ fontSize: '40px', opacity: '0.8' }}/>,
      path: '/admin/fishing_spots/map'
    },
    {
      label: 'お問い合わせの確認',
      backGroundColor: 'linear-gradient(135deg, #36d1dc 0%, #5b86e5 100%)',
      icon: <SupportAgentIcon sx={{ fontSize: 40, opacity: 0.8 }} />,
      path: '/admin/contacts'
    },
  ];
  return(
    <MainLayout>
      <SignInContainer direction="column" justifyContent="space-between">
      <Box sx={{ flexGrow: 1, padding: 10 }}>
        <Grid container spacing={4} justifyContent="center">
          {dashBoardCards.map((card, index) => (
            <DashboardCard
              key={index}
              label={card.label}
              backGroundColor={card.backGroundColor}
              icon={card.icon}
              path={card.path}
            />
          ))}
        </Grid>
      </Box>
      </SignInContainer>
    </MainLayout>
  )
};
