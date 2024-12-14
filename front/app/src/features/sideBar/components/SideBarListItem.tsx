import React from 'react';
import {
  ListItem,
  ListItemButton,
  ListItemText,
  ListItemIcon,
} from '@mui/material';
import { Link } from 'react-router-dom';

interface SideBarListItemProps {
  label: string;
  path: string;
  icon: React.ReactNode;
  open: boolean;
}

export const SideBarListItem: React.FC<SideBarListItemProps> = ({
  label,
  path,
  icon,
  open
}) => {
  return (
    <ListItem key={ label } disablePadding>
      <ListItemButton
        component={ Link }
        to={ path }
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
          { icon }
        </ListItemIcon>
        <ListItemText
          primary={ label }
          sx={{ opacity: open ? 1 : 0 }}
        />
      </ListItemButton>
    </ListItem>
  );
};
