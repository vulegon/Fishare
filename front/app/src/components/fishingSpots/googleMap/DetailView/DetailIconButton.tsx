import React from 'react';
import IconButton from '@mui/material/IconButton';
import { HEADER_HEIGHT } from 'constants/index';

interface DetailIconButtonProps {
  onClick: () => void;
  top?: number;
  right: number;
  backgroundColor?: string;
  hoverBackgroundColor?: string;
  children?: React.ReactNode;
}

export const DetailIconButton: React.FC<DetailIconButtonProps> = ({
  onClick,
  top = HEADER_HEIGHT + 5,
  right,
  backgroundColor = "rgba(255, 255, 255, 0.8)",
  hoverBackgroundColor = "rgba(255, 255, 255, 1)",
  children,
}) => {
  return (
    <>
      <IconButton
        onClick={onClick}
        sx={{
          position: "absolute",
          top: top,
          right: right,
          backgroundColor: backgroundColor,
          "&:hover": {
            backgroundColor: hoverBackgroundColor,
          },
        }}
      >
        {children}
      </IconButton>
    </>
  );
};
