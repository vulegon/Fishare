// 一般的な Error かどうかをチェックする型ガード関数
export function isError(error: unknown): error is Error {
  return error === Error;
}

// Null かどうかをチェックする型ガード関数
export function isNull(value: unknown): value is null {
  return value === null;
}

// Undefined かどうかをチェックする型ガード関数
export function isUndefined(value: unknown): value is undefined {
  return value === undefined;
}

// Null または Undefined かどうかをチェックする型ガード関数
export function isNullOrUndefined(value: unknown): value is null | undefined {
  return value === null || value === undefined;
}
