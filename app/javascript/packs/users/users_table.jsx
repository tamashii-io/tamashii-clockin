import React from 'react';
import PropTypes from 'prop-types';

import { Modal, ModalBody } from 'reactstrap';

import {
  RECEIVE_USERS,
  START_REGISTER,
  CANCEL_REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
} from './constants';
import { fetchUsers } from './actions';
import { RegistrarChannel } from '../channels';
import store from './store';

import UsersTableItem from './users_table_item';

class UsersTable extends React.Component {
  constructor() {
    super();
    this.state = {
      users: [],
      nextRegisterUserId: 0,
    };

    this.closeModal = this.closeModal.bind(this);
  }

  componentWillMount() {
    fetchUsers();
    RegistrarChannel.follow();
  }

  componentDidMount() {
    store.on(RECEIVE_USERS, users => this.setState({ users }));
    store.on(START_REGISTER, userId => this.setState({ nextRegisterUserId: userId }));
    store.on(
      REGISTER_UPDATE,
      (users, nextId) => this.setState({ users, nextRegisterUserId: nextId }),
    );
    store.on(
      REGISTER_SUCCESS,
      users => this.setState({ users, nextRegisterUserId: 0 }),
    );
  }

  componentWillUnmount() {
    RegistrarChannel.unfollow();
    store.off();
  }

  users() {
    const users = this.state.users;
    const isAdmin = this.props.isAdmin;
    return users.map(user => <UsersTableItem key={user.id} user={user} isAdmin={isAdmin} />);
  }

  hasNextUser() {
    return this.state.nextRegisterUserId > 0;
  }

  closeModal() {
    this.setState({ nextRegisterUserId: 0 });
    store.dispatch({ type: CANCEL_REGISTER, broadcast: true });
  }

  render() {
    return (
      <div>
        <Modal isOpen={this.hasNextUser()} toggle={this.closeModal}>
          <ModalBody>Please scan your RFID card to check-in</ModalBody>
        </Modal>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>姓名</th>
              <th>信箱</th>
              <th>卡片序號</th>
              <th>處理</th>
            </tr>
          </thead>
          <tbody>
            { this.users() }
          </tbody>
        </table>
      </div>
    );
  }
}

UsersTable.propTypes = {
  isAdmin: PropTypes.string.isRequired,
};

export default UsersTable;
