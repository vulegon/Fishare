import React, { ReactNode } from 'react';
import { Header } from 'features/header';
import { SideBar } from 'features/sideBar';
import { Box, CssBaseline } from '@mui/material';
import { HEADER_HEIGHT } from 'constants/index';

interface MainLayoutProps {
  children: ReactNode;
}

// ヘッダーとサイドバーを表示するレイアウト
export const MainLayout: React.FC<MainLayoutProps> = ({ children }) => {
  const [isDrawerOpen, setIsDrawerOpen] = React.useState<boolean>(true);

  const handleDrawerOpen = () => {
    setIsDrawerOpen(!isDrawerOpen);
  };

  return (
    <>
      <CssBaseline />
      <Box sx={{ display: 'flex' }}>
        <Header handleDrawerOpen={ handleDrawerOpen } />
        <SideBar open={ isDrawerOpen } />
        <Box
          component='main'
          sx={{
            flexGrow: 1,
            p: 3,
            width: { sm: '100%' },
            marginTop: `${HEADER_HEIGHT}px`
          }}
        >
          { children }
        </Box>
      </Box>
    </>
  );
};
