import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

const formatLastActive = date => (date ? moment(date).calendar() : '');
const formatBehavior = behavior => (behavior ? '下班' : '上班');


const CheckRecordsTableItem = ({ checkRecord }) => (
  <tr>
    <td>{checkRecord.user.name} </td>
    <td>{formatLastActive(checkRecord.created_at)}</td>
    <td>{formatBehavior(checkRecord.behavior)}</td>
  </tr>
);

CheckRecordsTableItem.propTypes = {
  checkRecord: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
