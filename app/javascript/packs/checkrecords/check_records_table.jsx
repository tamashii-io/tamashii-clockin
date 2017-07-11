import React from 'react';
import {
  RECEIVE_CHECK_RECORDS,
  CHECK_RECORD_SET,
  NOTIFY_NEW_RECORD,
} from './constants';
import { fetchCheckRecords } from './actions';
import { CheckrecordsChannel } from '../channels';
import store from './store';

import CheckRecordsTableItem from './check_records_table_item';

class CheckRecordsTable extends React.Component {
  constructor() {
    super();
    this.state = {
      checkRecords: [],
      notifyNum: undefined,
    };
  }

  componentWillMount() {
    fetchCheckRecords(this.props.pageId);
    CheckrecordsChannel.follow();
  }

  componentDidMount() {
    store.on(RECEIVE_CHECK_RECORDS, checkRecords => this.setState({ checkRecords }));
    store.on(CHECK_RECORD_SET, checkRecords => this.setState({ checkRecords }));
    store.on(NOTIFY_NEW_RECORD, notifyNum => this.setState({ notifyNum }));
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

  checkRecordsNotify() {
    return (
      <span className="badge badge-pill badge-danger">{this.state.notifyNum}</span>
    );
  }

  render() {
    return (
      <div>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>員工{ this.checkRecordsNotify() }</th>
              <th>時間</th>
              <th>類型</th>
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
