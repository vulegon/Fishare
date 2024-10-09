import React from 'react';
import { MenuItem } from '@mui/material';

interface MenuItemProps {
  label: string;
  MenuIcon?: React.ReactNode;
  onClick: () => void;
  isHidden?: boolean;
}

export const UserMenuItem: React.FC<MenuItemProps> = ({
  label,
  MenuIcon,
  onClick,
  isHidden = false,
}: MenuItemProps) => {
  return (
    <>
      { !isHidden  && (
        <MenuItem onClick={onClick}>
          {MenuIcon && <>{MenuIcon}</>}
          {label}
        </MenuItem>
      )}
    </>

  );
};
