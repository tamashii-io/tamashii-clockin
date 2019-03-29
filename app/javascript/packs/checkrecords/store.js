import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_CHECK_RECORDS,
  CHECK_RECORD_SET,
  NOTIFY_NEW_RECORD,
} from './constants';
import { CheckrecordsChannel } from '../channels';

const CheckRecord = Record({
  id: 0,
  user_id: '',
  behavior: '',
  created_at: '',
  updated_at: '',
  user: '',
});

const checkRecordsToRecord = checkRecords => checkRecords.map(
  checkRecord => new CheckRecord(checkRecord),
);


class CheckRecordStore extends EventEmitter {
  constructor() {
    super();
    this.check_records = fromJS([]);
    this.notify_new_records = 0;
    CheckrecordsChannel.onReceived(action => this.dispatch(action));
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_CHECK_RECORDS: {
        this.check_records = fromJS(checkRecordsToRecord(action.check_records));
        this.notify_new_records = 0;
        this.emit(action.type, this.check_records);
        break;
      }
      case CHECK_RECORD_SET: {
        const checkRecord = new CheckRecord(action.check_record);
        if (this.check_records.size < 25) {
          this.check_records = this.check_records.unshift(checkRecord);
        } else {
          this.check_records = this.check_records.pop().unshift(checkRecord);
        }
        this.emit(action.type, this.check_records);
        break;
      }
      case NOTIFY_NEW_RECORD: {
        this.notify_new_records = this.notify_new_records + 1;
        this.emit(action.type, this.notify_new_records);
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_CHECK_RECORDS);
    this.removeAllListeners(CHECK_RECORD_SET);
    this.removeAllListeners(NOTIFY_NEW_RECORD);
  }
}

const checkRecords = new CheckRecordStore();

export default checkRecords;
