import axios from 'axios';

const client = axios.create({
  transformRequest: [
    (data, headers) => {
      const token = localStorage.getItem("jwt");
      if(token){
        headers['Authorization'] = "Bearer " + token;
      }
      return JSON.stringify(data);
    },
  ],
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  },
});

client.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response.status === 401) {
      window.location = '/login';
      return null;
    }
    return Promise.reject(error);
  }
);

export default client;