import React, { ReactNode } from 'react';
import { Header } from 'features/header';
import { SideBar } from 'features/sideBar';
import { Box, CssBaseline } from '@mui/material';
import { DRAWER_WIDTH } from 'constants/index';
import { Toolbar } from '@mui/material';

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
        <Header handleDrawerOpen={handleDrawerOpen} />
        <SideBar open={isDrawerOpen} />
        <Box
          component="main"
          sx={{
            flexGrow: 1,
            p: 3,
            width: { sm: `calc(100% - ${DRAWER_WIDTH}px)` },
          }}
        >
          {/* 要素が埋もれないようにするために、ToolBarを挟む。Header分のスペースを確保する。 */}
          <Toolbar />
          {children}
        </Box>
      </Box>
    </>
  );
};
