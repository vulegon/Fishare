import Axios from 'axios';
import { Bounce, toast } from 'react-toastify';
import { isError } from '../typeGuard';

export function notifyError(error?: unknown, message?: string): void {
  let errorMessage = 'エラーが発生しました';

  if (Axios.isAxiosError(error)) {
    errorMessage = error.response?.data?.message || error.message;
  } else if (isError(error)) {
    errorMessage = error.message;
  }

  // エラーメッセージが指定されている場合はそれを表示
  if (message) {
    errorMessage = message;
  }

  // トースト通知でエラーメッセージを表示
  toast.error(errorMessage, {
    position: "top-right",
    autoClose: 10000,
    hideProgressBar: true,
    closeOnClick: true,
    pauseOnHover: true,
    draggable: true,
    progress: undefined,
    theme: "light",
    transition: Bounce,
  });
}
