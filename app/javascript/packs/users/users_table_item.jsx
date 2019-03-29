import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';

class UsersTableItem extends React.Component {
  registerUser() {
    const user = this.props.user;
    startRegister(user.id, true);
  }

  renderCardSerial(value) {
    const user = this.props.user;
    if (value.length > 0) {
      return value;
    }

    const onClick = (ev) => {
      ev.preventDefault();
      this.registerUser();
    };

    if (this.props.isAdmin === 'true' && !user.deleted) {
      return (
        <a href="" onClick={onClick} className="btn btn-success">綁定</a>
      );
    }

    return undefined;
  }

  renderEditAndDeleteButton(links) {
    const view = [];
    const user = this.props.user;
    if (this.props.isAdmin === 'true') {
      view.push(<a key={view.length} href={links.edit} className="btn btn-primary">編輯</a>);
      if (user.deleted) {
        view.push(<a
          key={view.length}
          href={links.recover}
          className="btn btn-success ml-2"
          data-method="patch"
          data-confirm="Are you sure?"
        >復職</a>);
      } else {
        view.push(<a
          key={view.length}
          href={links.self}
          className="btn btn-danger ml-2"
          data-method="delete"
          data-confirm="Are you sure?"
        >離職</a>);
      }
      return view;
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
