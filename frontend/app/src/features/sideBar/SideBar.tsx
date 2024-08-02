import React from "react";
import {
  List,
  ListItem,
  ListItemButton,
  ListItemText,
  ListItemIcon,
  Box,
  Drawer,
  Toolbar
} from '@mui/material';
import MapIcon from '@mui/icons-material/Map';
import ListIcon from '@mui/icons-material/List';

const sideBarItems = [
  { label: '一覧から探す', icon: <ListIcon /> },
  { label: '地図から探す', icon: <MapIcon /> },
];

const drawerWidth = 240;

const SideBar: React.FC = () => {
  return (
    <>
      <Drawer
        open={true}
        variant="persistent"
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          [`& .MuiDrawer-paper`]: { width: drawerWidth, boxSizing: 'border-box' },
        }}
      >
        <Toolbar />
        <Box
          sx={{ width: '14rem', overflow: 'auto' }}
        >
          <List>
            {sideBarItems.map((item) => (
              <ListItem key={item.label} disablePadding>
                <ListItemButton>
                  <ListItemIcon>{item.icon}</ListItemIcon>
                  <ListItemText primary={item.label} />
                </ListItemButton>
              </ListItem>
            ))}
          </List>
        </Box>
      </Drawer>
    </>
  );
};

export default SideBar;
