import React from 'react';
import PropTypes from 'prop-types';
import {
  RECEIVE_CHECK_RECORDS,
  CHECK_RECORD_SET,
} from './constants';
import { fetchCheckRecords } from './actions';
import { CheckrecordsChannel } from '../channels';
import store from './store';

import CheckRecordsTableItem from './check_records_table_item.jsx';

class CheckRecordsTable extends React.Component {
  constructor() {
    super();
    this.state = {
      checkRecords: [],
    };
  }

  componentWillMount() {
    fetchCheckRecords();
    CheckrecordsChannel.follow();
  }

  componentDidMount() {
    store.on(RECEIVE_CHECK_RECORDS, checkRecords => this.setState({ checkRecords }));
    store.on(CHECK_RECORD_SET, checkRecords => this.setState({ checkRecords }));
  }

  componentWillUnmount() {
    CheckrecordsChannel.unfollow();
    store.off();
  }

  checkRecords() {
    const checkRecords = this.state.checkRecords;
    return checkRecords.map(
      checkRecord => <CheckRecordsTableItem key={checkRecord.id} checkRecord={checkRecord} />,
    );
  }

  render() {
    return (
      <div>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾</th>
              <th>時間</th>
              <th>狀態</th>
            </tr>
          </thead>
          <tbody>
            { this.checkRecords() }
          </tbody>
        </table>
      </div>
    );
  }
}

export default CheckRecordsTable;
