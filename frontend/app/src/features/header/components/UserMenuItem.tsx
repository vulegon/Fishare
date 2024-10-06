import React from 'react';
import { MenuItem } from '@mui/material';

interface MenuItemProps {
  label: string;
  MenuIcon?: React.ReactNode;
  onClick: () => void;
}

export const UserMenuItem: React.FC<MenuItemProps> = ({
  label,
  MenuIcon,
  onClick
}: MenuItemProps) => {
  return (
    <MenuItem onClick={onClick}>
      {MenuIcon && <>{MenuIcon}</>}
      {label}
    </MenuItem>
  );
};
