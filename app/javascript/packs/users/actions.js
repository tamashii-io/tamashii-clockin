/* global $:true */
import {
  RECEIVE_USERS,
  START_REGISTER,
} from './constants';

import store from './store';

const ENDPOINTS = {
  users: () => '/users_admin.json',
};

export const fetchUsers = () => {
  $.get(ENDPOINTS.users())
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_USERS, users: data }); });
};

export const startRegister = (userId) => {
  store.dispatch({ type: START_REGISTER, userId });
};

export default {
  fetchUsers,
  startRegister,
};
