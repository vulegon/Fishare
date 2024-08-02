import React from "react";
import { Header } from "features/header";
import { SideBar } from "features/sideBar";
import { Box, CssBaseline, Toolbar } from '@mui/material';

const Home: React.FC = () => {
  return (
    <>
      <Box sx={{ display: 'flex' }}>
        <CssBaseline />
        <Header/>
        <SideBar/>
        <Toolbar />
      </Box>
    </>
  );
};

export default Home;
