import React, { ReactNode } from "react";
import { Header } from "features/header";
import { SideBar } from "features/sideBar";
import { Box, CssBaseline } from '@mui/material';
import { DRAWER_WIDTH } from "constants/index";

interface MainLayoutProps {
  children: ReactNode;
}

const MainLayout: React.FC<MainLayoutProps> = ({ children }) => {
  return (
    <>
      <CssBaseline />
      <Box sx={{ display: 'flex' }}>
        <Header/>
        <SideBar/>
        <Box
          component="main"
          sx={{ flexGrow: 1, p: 3, width: { sm: `calc(100% - ${DRAWER_WIDTH}px)` } }}
        >
          {children}
        </Box>
      </Box>
    </>
  );
};

export default MainLayout;
