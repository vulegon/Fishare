import React, { ReactNode } from 'react';
import Button from '@mui/material/Button';
import { darken } from '@mui/system';

interface FormButtonProps {
  label: string;
  backgroundColor?: string;
  isSubmit?: boolean;
  setIcon?: ReactNode;
  handleOnClick?: () => void;
  variant?: 'contained' | 'outlined' | 'text';
  disabled?: boolean;
}

export const FormButton: React.FC<FormButtonProps> = ({
  label,
  backgroundColor = '#1876d1',
  isSubmit = true,
  setIcon,
  handleOnClick,
  variant = 'contained',
  disabled = false
}) => {
  const isOutlined = variant === 'outlined';

  return (
    <Button
      variant={variant}
      color="primary"
      type={isSubmit ? 'submit' : 'button'}
      sx={{
        borderRadius: '50px', // 丸みを帯びたボタンにする
        padding: '10px 20px',
        fontSize: '1.2rem',
        width: '300px',
        backgroundColor:  isOutlined ? 'transparent' : backgroundColor,
        fontWeight: 'bold',
        "&:hover": {
          backgroundColor: isOutlined
            ? 'transparent'
            : darken(backgroundColor, 0.1), // ホバー時に少し色を濃くする
        },
      }}
      startIcon={setIcon}
      onClick={handleOnClick}
      disabled={disabled}
    >
      {label}
    </Button>
  );
};
