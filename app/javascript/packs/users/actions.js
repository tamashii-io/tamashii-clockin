/* global $:true */
import {
  RECEIVE_USERS,
  START_REGISTER,
} from './constants';

import store from './store';

const ENDPOINTS = {
  // TODO: User controller will conflict default devise User, change routes to deal with it
  users: () => '/users_admin.json',
};

export const fetchUsers = () => {
  $.get(ENDPOINTS.users())
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_USERS, users: data }); });
};

export const startRegister = (userId, broadcast) => {
  store.dispatch({ type: START_REGISTER, userId, broadcast });
};

export default {
  fetchUsers,
  startRegister,
};
