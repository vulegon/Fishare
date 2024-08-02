import React from "react";
import { AppBar, Typography } from '@mui/material';
import { SERVICE_NAME } from "constants/index";
import { CustomToolbar } from "components/common";

const Header: React.FC = () => {
  return (
    <>
      <AppBar position="fixed" sx={{zIndex: (theme) => theme.zIndex.drawer + 1}}>
        <CustomToolbar>
          <Typography variant="h6" noWrap component="div">
              { SERVICE_NAME }
          </Typography>
        </CustomToolbar>
      </AppBar>
    </>
  );
};

export default Header;
