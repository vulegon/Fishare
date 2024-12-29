import axios, { AxiosInstance } from 'axios';

const API_VERSION_PATH = 'api/v1/';

export const apiClient: AxiosInstance = axios.create({
  baseURL: `${process.env.REACT_APP_API_BASE_URL || ''}/${API_VERSION_PATH}`,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
});
