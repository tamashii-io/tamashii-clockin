import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';

class UsersTableItem extends React.Component {
  registerUser() {
    const { user } = this.props;
    startRegister(user.id, true);
  }

  renderCardSerial(value) {
    const { user, isAdmin } = this.props;
    if (value.length > 0) {
      return value;
    }

    const onClick = (ev) => {
      ev.preventDefault();
      this.registerUser();
    };

    // TODO: Fix card register feature
    if (isAdmin === 'true' && !user.deleted) {
      return (
        <button type="button" onClick={onClick} className="btn btn-success" disabled>綁定</button>
      );
    }

    return undefined;
  }

  renderEditAndDeleteButton(links) {
    const view = [];
    const { user, isAdmin } = this.props;
    if (isAdmin === 'true') {
      view.push(<a key={view.length} href={links.edit} className="btn btn-primary">編輯</a>);
      if (user.deleted) {
        view.push(
          <a
            key={view.length}
            href={links.recover}
            className="btn btn-success ml-2"
            data-method="patch"
            data-confirm="Are you sure?"
          >
              復職
          </a>,
        );
      } else {
        view.push(
          <a
            key={view.length}
            href={links.self}
            className="btn btn-danger ml-2"
            data-method="delete"
            data-confirm="Are you sure?"
          >
              離職
          </a>,
        );
      }
      return view;
    }

    return undefined;
  }

  render() {
    const { user } = this.props;

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
