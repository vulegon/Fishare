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

const SideBar: React.FC = () => {
  return (
    <>
      <Drawer
        open={true}
        variant="persistent"
        sx={{
          width: DRAWER_WIDTH,
          flexShrink: 0,
          [`& .MuiDrawer-paper`]: { width: DRAWER_WIDTH, boxSizing: 'border-box' },
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
