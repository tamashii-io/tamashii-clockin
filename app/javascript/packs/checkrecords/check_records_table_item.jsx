import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

const formatLastActive = date => (date ? moment(date).calendar() : '');

const CheckRecordsTableItem = ({ checkRecord }) => (
  <tr>
    <td>{checkRecord.user_id} </td>
    <td>{formatLastActive(checkRecord.created_at)}</td>
    <td>{checkRecord.behavior}</td>
  </tr>
);

CheckRecordsTableItem.propTypes = {
  checkRecord: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
