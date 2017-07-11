/* global $:true */

import {
  RECEIVE_CHECK_RECORDS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  check_records: pageId => `/check_records.json?page=${pageId}`,
};

export const fetchCheckRecords = (pageId) => {
  $.get(ENDPOINTS.check_records(pageId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_CHECK_RECORDS, check_records: data }); });
};

export default {
  fetchCheckRecords,
};
