import { z } from 'zod';

const EMAIL_REGEX = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i;
export const EmailSchema = z.string().regex(EMAIL_REGEX, { message: 'メールアドレスの形式が正しくありません' });
