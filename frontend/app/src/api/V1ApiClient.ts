import axios from 'axios';

const V1_API_VERSION_PATH = 'api/v1/';
const v1BaseUrl = `${process.env.REACT_APP_API_BASE_URL}/${V1_API_VERSION_PATH}`;

const V1ApiClient = axios.create({
  baseURL: v1BaseUrl,
  headers: {
    'Content-Type': 'application/json',
  },
});
