import React from 'react';
import { AppBar, Typography, IconButton } from '@mui/material';
import { SERVICE_NAME } from 'constants/index';
import { CustomToolbar } from 'components/common';
import { Link } from 'react-router-dom';
import MenuIcon from '@mui/icons-material/Menu';

interface HeaderProps {
  handleDrawerOpen: () => void;
}

const Header: React.FC<HeaderProps> = ({ handleDrawerOpen }) => {
  return (
    <>
      <AppBar
        position="fixed"
        sx={{ zIndex: (theme) => theme.zIndex.drawer + 1 }}
      >
        <CustomToolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            edge="start"
            sx={{ marginRight: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Link to="/" style={{ textDecoration: 'none', color: 'white' }}>
            <Typography variant="h6" noWrap>
              {SERVICE_NAME}
            </Typography>
          </Link>
        </CustomToolbar>
      </AppBar>
    </>
  );
};

export default Header;
