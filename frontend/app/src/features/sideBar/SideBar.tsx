import React from "react";
import {
  List,
  ListItem,
  ListItemButton,
  ListItemText,
  ListItemIcon,
  Box,
  Drawer
} from '@mui/material';
import MapIcon from '@mui/icons-material/Map';
import ListIcon from '@mui/icons-material/List';
import { CustomToolbar } from "components/common";
import { DRAWER_WIDTH } from "constants/index";

const sideBarItems = [
  { label: '一覧から探す', icon: <ListIcon /> },
  { label: '地図から探す', icon: <MapIcon /> },
];

interface SideBarProps {
  isDrawerOpen: boolean;
}

const SideBar: React.FC<SideBarProps> = (
  { isDrawerOpen }
) => {
  return (
    <>
      <Drawer
        open={isDrawerOpen}
        variant="persistent"
        sx={{
          width: DRAWER_WIDTH,
          flexShrink: 0,
          [`& .MuiDrawer-paper`]: {
            width:  isDrawerOpen ? DRAWER_WIDTH : 56,
            boxSizing: 'border-box',
          },
        }}
      >
        <CustomToolbar />
        <Box
          sx={{ width: '14rem', overflow: 'auto' }}
        >
          <List>
            {sideBarItems.map((item) => (
              <ListItem key={item.label} disablePadding>
                <ListItemButton>
                  <ListItemIcon>{item.icon}</ListItemIcon>
                  <ListItemText
                    primary={item.label}
                    sx={{ opacity: isDrawerOpen ? 1 : 0 }}
                  />
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
