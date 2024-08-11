import React from 'react';
import { Toolbar as MuiToolbar, ToolbarProps } from '@mui/material';

const CustomToolbar: React.FC<ToolbarProps> = (props) => {
  return (
    // 画面サイズを変更してもツールバーの高さが変わらないように
    <MuiToolbar
      {...props}
      sx={{ minHeight: '64px', paddingLeft: '24px', ...props.sx }}
    >
      {props.children}
    </MuiToolbar>
  );
};

export default CustomToolbar;
