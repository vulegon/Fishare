import { toast, Bounce } from 'react-toastify';
import { isError } from './typeGuard';
import Axios from 'axios';

export function notifyError(error: unknown): void {
  let errorMessage = 'エラーが発生しました';

  if (Axios.isAxiosError(error)) {
    errorMessage = error.response?.data?.message || error.message;
  } else if (isError(error)) {
    errorMessage = error.message;
  }

  // トースト通知でエラーメッセージを表示
  toast.error(errorMessage, {
    position: "top-right",
    autoClose: 7000,
    hideProgressBar: false,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    progress: undefined,
    theme: "light",
    transition: Bounce,
  });
}
