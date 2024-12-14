import { MainLayout } from 'features/layouts';
import React from 'react';
import { MainContainer, Latest } from 'features/supports/contact/reviewContact';
import { Container } from '@mui/material';

export const ContactReviewPage: React.FC = () => {
  return (
    <>
      <MainLayout>
      <Container
        maxWidth="lg"
        component="main"
        sx={{ display: 'flex', flexDirection: 'column',my: 1, gap: 4 }}
      >
        <MainContainer />
        <Latest />
        </Container>
      </MainLayout>
    </>
  );
};

