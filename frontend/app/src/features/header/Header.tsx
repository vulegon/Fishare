import React, { useState } from 'react';
import { AppBar, Typography, IconButton, Menu, Divider } from '@mui/material';
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
import { Height } from '@mui/icons-material';

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
    if (!user) return;
    await adminApiClient.signOut(user);
    signOut();
    notifySuccess('管理者からログアウトしました');
    navigate('/admin/sign_in');
  }

  const handleDashboard = () => {
    navigate('/admin/dashboards');
  }

  const userMenuItems = [
    { label: 'ダッシュボード', onClick: handleDashboard, icon: <DashboardIcon sx={{marginRight: 2}}/> },
    { label: 'ログアウト', onClick: handleSignOut, icon: <LogoutIcon sx={{marginRight: 2}}/> }
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
              PaperProps={{
                sx: {
                  width: 250,  // メニューの幅を指定
                  padding: 2,  // 内側のパディングを指定
                }
              }}
            >
               <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: 1 }}>
                <Avatar sx={{ width: 56, height: 56 }} />
                <Typography variant="subtitle1" sx={{ marginTop: 1, fontWeight: 'bold' }}>
                  {user?.name}
                </Typography>
                <Typography variant="body2" color="textSecondary">
                  {user?.email}
                </Typography>
              </Box>
              <Box sx={{height: "5px"}}/>
              <Divider />
              <Box sx={{height: "5px"}}/>
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
