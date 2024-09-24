import React from 'react';
import {
  List,
  ListItem,
  ListItemButton,
  ListItemText,
  ListItemIcon
} from '@mui/material';
import MapIcon from '@mui/icons-material/Map';
import ListIcon from '@mui/icons-material/List';
import SupportAgentIcon from '@mui/icons-material/SupportAgent';
import { CustomToolbar } from 'components/common';
import { DRAWER_WIDTH } from 'constants/index';
import { styled, Theme, CSSObject } from '@mui/material/styles';
import MuiDrawer from '@mui/material/Drawer';
import { Link } from 'react-router-dom';

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
  { label: 'お問い合わせ', icon: <SupportAgentIcon />, path: '/supports/contact' }
];

interface SideBarProps {
  open: boolean;
}

export const SideBar: React.FC<SideBarProps> = ({ open }) => {
  return (
    <Drawer variant='permanent' open={ open }>
      <CustomToolbar />
      <List>
        { sideBarItems.map((item) => (
          <ListItem key={ item.label } disablePadding>
            <ListItemButton
              component={ Link }
              to={ item.path }
              sx={{
                minHeight: 48,
                justifyContent: open ? 'initial' : 'center',
                px: 2.5
              }}
            >
              <ListItemIcon
                sx={{
                  minWidth: 0,
                  mr: open ? 3 : 'auto',
                  justifyContent: 'center'
                }}
              >
                { item.icon }
              </ListItemIcon>
              <ListItemText
                primary={ item.label }
                sx={{ opacity: open ? 1 : 0 }}
              />
            </ListItemButton>
          </ListItem>
        )) }
      </List>
    </Drawer>
  );
};
