import React from 'react';
import {
  List,
  Divider,
  Box
} from '@mui/material';
import MapIcon from '@mui/icons-material/Map';
import ListIcon from '@mui/icons-material/List';
import SupportAgentIcon from '@mui/icons-material/SupportAgent';
import { CustomToolbar } from 'components/common';
import { DRAWER_WIDTH } from 'constants/index';
import { styled, Theme, CSSObject } from '@mui/material/styles';
import MuiDrawer from '@mui/material/Drawer';
import { useUser } from 'contexts/UserContext';
import { SideBarListItem } from './components';
import DashboardIcon from '@mui/icons-material/Dashboard';

// MUIのDrawerコンポーネントをカスタマイズする
// 参考
// https://mui.com/material-ui/react-drawer/
const openedMixin = (theme: Theme): CSSObject => ({
  width: DRAWER_WIDTH,
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen
  }),
  overflowX: 'hidden'
});

const closedMixin = (theme: Theme): CSSObject => ({
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen
  }),
  overflowX: 'hidden',
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up('sm')]: {
    width: `calc(${theme.spacing(8)} + 1px)`
  }
});

const Drawer = styled(MuiDrawer, {
  shouldForwardProp: (prop) => prop !== 'open'
})(({ theme, open }) => ({
  width: DRAWER_WIDTH,
  flexShrink: 0,
  whiteSpace: 'nowrap',
  boxSizing: 'border-box',
  ...(open && {
    ...openedMixin(theme),
    '& .MuiDrawer-paper': openedMixin(theme)
  }),
  ...(!open && {
    ...closedMixin(theme),
    '& .MuiDrawer-paper': closedMixin(theme)
  })
}));

const sideBarItems = [
  { label: '一覧から探す', icon: <ListIcon />, path: '/' },
  { label: '地図から探す', icon: <MapIcon />, path: '/google_maps' },
  { label: 'お問い合わせ', icon: <SupportAgentIcon />, path: '/supports/contacts/new' }
];

const adminSideBarItems = [
  { label: 'ダッシュボード', icon: <DashboardIcon />, path: '/admin/dashboards' }
];

interface SideBarProps {
  open: boolean;
}

export const SideBar: React.FC<SideBarProps> = ({ open }) => {
  const { user } = useUser();

  return (
    <Drawer variant='permanent' open={ open }>
      <CustomToolbar />
      <List>
        { sideBarItems.map((item) => (
          <SideBarListItem
            key={ item.label }
            label={ item.label }
            path={ item.path }
            icon={ item.icon }
            open={ open }
          />
          ))
        }
        <Box sx={{height: '10px'}}/>
        { user && (
            <>
              <Divider />
              <Box sx={{height: '20px'}}/>
              {adminSideBarItems.map((item) => (
                <SideBarListItem
                  key={item.label}
                  label={item.label}
                  path={item.path}
                  icon={item.icon}
                  open={open}
                />
              ))}
            </>
        )}
      </List>
    </Drawer>
  );
};
