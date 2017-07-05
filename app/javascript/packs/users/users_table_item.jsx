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

    if (this.props.isAdmin === 'true') {
      return (
        <a href="" onClick={onClick} className="btn btn-success">綁定</a>
      );
    }

    return undefined;
  }

  renderEditAndDeleteButton(links) {
    if (this.props.isAdmin === 'true') {
      return ([
        <a href={links.edit} className="btn btn-primary">編輯</a>,
        <a
          href={links.self}
          className="btn btn-danger"
          data-method="delete"
          data-confirm="Are you sure?"
        >刪除</a>,
      ]);
    }

    return undefined;
  }

  render() {
    const user = this.props.user;

    return (
      <tr>
        <td>{user.name}</td>
        <td>{user.email}</td>
        <td>{user.job_type}</td>
        <td>{this.renderCardSerial(user.card_serial)}</td>
        <td>{this.renderEditAndDeleteButton(user.links)}</td>
      </tr>
    );
  }
}

UsersTableItem.propTypes = {
  user: PropTypes.shape({}).isRequired,
  isAdmin: PropTypes.string.isRequired,
};

export default UsersTableItem;
