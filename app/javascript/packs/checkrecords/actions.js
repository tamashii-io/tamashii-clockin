import {
  RECEIVE_CHECK_RECORDS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  check_records: () => `/check_records.json`,
};

export const fetchCheckRecords = () => {
  $.get(ENDPOINTS.check_records())
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_CHECK_RECORDS, check_records: data }); });
};

export default {
  fetchCheckRecords,
};
