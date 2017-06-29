import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';

class UsersTableItem extends React.Component {
  registerUser() {
    const user = this.props.user;
    startRegister(user.id, true);
  }

  renderCardSerial(value) {
    if (value.length > 0) {
      return value;
    }

    const onClick = (ev) => {
      ev.preventDefault();
      this.registerUser();
    };

    return (
      <a href="" onClick={onClick} className="btn btn-success">報到</a>
    );
  }

  render() {
    const user = this.props.user;

    return (
      <tr>
        <td>{user.name}</td>
        <td>{user.email}</td>
        <td>{this.renderCardSerial(user.card_serial)}</td>
        <td>
          <a href={user.links.edit} className="btn btn-primary">編輯</a>
          <a
            href={user.links.self}
            className="btn btn-danger"
            data-method="delete"
            data-confirm="Are you sure?"
          >刪除</a>
        </td>
      </tr>
    );
  }
}

UsersTableItem.propTypes = {
  user: PropTypes.shape({}).isRequired,
};

export default UsersTableItem;
