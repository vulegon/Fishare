import React from "react";
import { List, ListItem, ListItemButton, ListItemText, ListItemIcon, Box } from '@mui/material';
import MapIcon from '@mui/icons-material/Map';
import ListIcon from '@mui/icons-material/List';

const sideBarItems = [
  { text: '一覧から探す', icon: <ListIcon /> },
  { text: '地図から探す', icon: <MapIcon /> },
];

const SideBar: React.FC = () => {
  return (
    <>
      <Box sx={{ display: 'flex', height: '100%' }}>
        <Box sx={{
          width: '14rem',
          bgcolor: 'background.paper',
          display: 'flex',
          flexDirection: 'column',
          borderRight: '1px solid rgba(0, 0, 0, 0.1)'
        }}>
          <List sx={{ flexGrow: 1 }}>
            {sideBarItems.map((item) => (
              <ListItem key={item.text} disablePadding>
                <ListItemButton>
                  <ListItemIcon>{item.icon}</ListItemIcon>
                  <ListItemText primary={item.text} />
                </ListItemButton>
              </ListItem>
            ))}
          </List>
        </Box>
      </Box>
    </>
  );
};

export default SideBar;
