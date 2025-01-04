import React from 'react'
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import { Button } from "@mui/material";

interface ConfirmDialogProps {
  open: boolean;
  onClose: () => void;
  handleExecute: () => void;
  content: string;
  executeButtonTitle: string;
}

export const ConfirmDialog:React.FC<ConfirmDialogProps> = ({
  open,
  onClose,
  handleExecute,
  content,
  executeButtonTitle
}) => {
  return (
    <Dialog
      open={open}
      onClose={onClose}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
    <DialogTitle>
      確認画面
    </DialogTitle>
    <DialogContent>
      <DialogContentText>
        {content}
      </DialogContentText>
    </DialogContent>
    <DialogActions>
      <Button onClick={onClose} autoFocus>キャンセル</Button>
      <Button onClick={handleExecute} color="error" variant="contained">{executeButtonTitle}</Button>
    </DialogActions>
  </Dialog>
  )
}

