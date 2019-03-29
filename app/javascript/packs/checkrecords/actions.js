/* global $:true */

import {
  RECEIVE_CHECK_RECORDS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  check_records: page => `/check_records.json?page=${page}`,
};

export const fetchCheckRecords = (page) => {
  $.get(ENDPOINTS.check_records(page))
    .promise()
    .done((data) => { store.dispatch({ type: RECEIVE_CHECK_RECORDS, check_records: data }); });
};

export default {
  fetchCheckRecords,
};
