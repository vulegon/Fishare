import React from "react";
import { Header } from "features/header";
import { SideBar } from "features/sideBar";
import { Box, CssBaseline } from '@mui/material';

const Home: React.FC = () => {
  return (
    <>
      <CssBaseline />
      <Box>
        <Header/>
        <SideBar/>
      </Box>
    </>
  );
};

export default Home;
