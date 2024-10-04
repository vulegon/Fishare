import React, { useState } from 'react';
import { AppBar, Typography, IconButton, Menu } from '@mui/material';
import { SERVICE_NAME } from 'constants/index';
import { CustomToolbar } from 'components/common';
import { Link } from 'react-router-dom';
import MenuIcon from '@mui/icons-material/Menu';
import { HEADER_HEIGHT } from 'constants/index';
import Avatar from '@mui/material/Avatar';
import Box from '@mui/material/Box';
import LogoutIcon from '@mui/icons-material/Logout';
import adminApiClient from 'api/v1/admin/adminApiClient';
import { useUser } from 'contexts/UserContext';
import { useNavigate } from 'react-router-dom';
import { notifySuccess } from 'utils/notifySuccess';
import { UserMenuItem } from './components/UserMenuItem';
import DashboardIcon from '@mui/icons-material/Dashboard';

interface HeaderProps {
  handleDrawerOpen: () => void;
}

const Header: React.FC<HeaderProps> = ({ handleDrawerOpen }) => {
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const { user, signOut } = useUser();
  const navigate = useNavigate();

  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
  };

  const handleSignOut = async () => {
    await adminApiClient.signOut();
    signOut();
    notifySuccess('管理者からログアウトしました');
    navigate('/admin/sign_in');
  }

  const handleDashboard = () => {
    navigate('/admin/dashboards');
  }

  const userMenuItems = [
    { label: 'ダッシュボード', onClick: handleDashboard, icon: <DashboardIcon sx={{marginRight: 1}}/> },
    { label: 'ログアウト', onClick: handleSignOut, icon: <LogoutIcon sx={{marginRight: 1}}/> }
  ];

  return (
    <>
      <AppBar
        position='fixed'
        sx={{
          zIndex: (theme) => theme.zIndex.drawer + 1,
          height: `${HEADER_HEIGHT}px`
        }}
      >
        <CustomToolbar>
          <IconButton
            color='inherit'
            aria-label='open drawer'
            onClick={ handleDrawerOpen }
            edge='start'
            sx={{ marginRight: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Link to='/' style={{ textDecoration: 'none', color: 'white' }}>
            <Typography variant='h6' noWrap>
              { SERVICE_NAME }
            </Typography>
          </Link>
          { user && (
            <Box
              sx={{
                display: 'flex',
                alignItems: 'center',
                marginLeft: 'auto',
              }}
            >
            <IconButton
              color="inherit"
              onClick={handleMenuOpen}
            >
              <Avatar />
            </IconButton>
            <Menu
              anchorEl={anchorEl}
              open={Boolean(anchorEl)}
              onClose={handleMenuClose}
              anchorOrigin={{
                vertical: 'bottom',
                horizontal: 'right',
              }}
              transformOrigin={{
                vertical: 'top',
                horizontal: 'right',
              }}
            >
              {userMenuItems.map((item) => (
                <UserMenuItem
                  key={item.label}
                  label={item.label}
                  MenuIcon={item.icon}
                  onClick={item.onClick}
                />))
              }
            </Menu>
          </Box>
          )}
        </CustomToolbar>
      </AppBar>
    </>
  );
};

export default Header;
