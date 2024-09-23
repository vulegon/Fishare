import React, { ReactNode } from 'react';
import Button from '@mui/material/Button';

interface FormButtonProps {
  label: string;
  backgroundColor?: string;
  isSubmit?: boolean;
  setIcon?: ReactNode;
  handleOnClick?: () => void;
  variant?: 'contained' | 'outlined' | 'text';
}

export const FormButton: React.FC<FormButtonProps> = ({
  label,
  backgroundColor = '#1876d1',
  isSubmit = true,
  setIcon,
  handleOnClick,
  variant = 'contained'
}) => {
  const isOutlined = variant === 'outlined';

  return (
    <Button
      variant={variant}
      color="primary"
      type={isSubmit ? 'submit' : 'button'}
      style={{
        borderRadius: '50px', // 丸みを帯びたボタンにする
        padding: '10px 20px',
        fontSize: '1.2rem',
        width: '300px',
        backgroundColor:  isOutlined ? 'transparent' : backgroundColor,
        fontWeight: 'bold'
      }}
      startIcon={setIcon}
      onClick={handleOnClick}
    >
      {label}
    </Button>
  );
};
