import React, { ReactNode } from 'react';
import { Header } from 'features/header';
import { SideBar } from 'features/sideBar';
import { Box, CssBaseline } from '@mui/material';
import { HEADER_HEIGHT } from 'constants/index';

interface MainLayoutProps {
  children?: ReactNode;
  mainContainerPadding?: number;
}

// ヘッダーとサイドバーを表示するレイアウト
export const MainLayout: React.FC<MainLayoutProps> = ({
  children,
  mainContainerPadding = 3,
}) => {
  const [isDrawerOpen, setIsDrawerOpen] = React.useState<boolean>(()=>{
    const storedDrawerState = localStorage.getItem('drawerState');
    if (storedDrawerState) {
      return storedDrawerState === 'true';
    } else {
      return true;
    }
  })

  const handleDrawerOpen = () => {
    const openState = !isDrawerOpen;
    setIsDrawerOpen(openState);
    localStorage.setItem('drawerState', String(openState));
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
            p: mainContainerPadding,
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
