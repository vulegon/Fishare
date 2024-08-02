import React from "react";
import { AppBar, Toolbar, Typography } from '@mui/material';
import { SERVICE_NAME } from "constants/index";

const Header: React.FC = () => {
  return (
    <>
      <AppBar position="static" sx={{zIndex: (theme) => theme.zIndex.drawer + 1}}>
        <Toolbar>
          <Typography variant="h6">
            { SERVICE_NAME }
          </Typography>
        </Toolbar>
      </AppBar>
    </>
  );
};

export default Header;
