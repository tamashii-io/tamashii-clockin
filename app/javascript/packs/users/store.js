import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_USERS,
  START_REGISTER,
  REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
  CANCEL_REGISTER,
} from './constants';
import { RegistrarChannel } from '../channels';

const User = Record({
  id: 0,
  code: '',
  serial: 0,
  card_serial: '',
  email: '',
  name: '',
  phone: '',
  links: {
    edit: '',
    self: '',
  },
});

const usersToRecord = users => users.map(user => new User(user));

class UserStore extends EventEmitter {
  constructor() {
    super();
    this.users = fromJS([]);
    this.nextRegisterUserId = 0;
    RegistrarChannel.onReceived(action => this.dispatch(action));
  }

  update(userId, newUser) {
    const index = this.index(userId);
    if (index >= 0) {
      this.users = this.users.set(index, newUser);
    }
  }

  index(userId) {
    return this.users.findIndex(user => user.id === userId);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_USERS: {
        this.users = fromJS(usersToRecord(action.users));
        this.emit(action.type, this.users);
        break;
      }
      case START_REGISTER: {
        this.nextRegisterUserId = action.userId;
        this.emit(action.type, this.nextRegisterUserId);
        break;
      }
      case REGISTER: {
        this.emit(action.type, action.serial);
        if (this.nextRegisterUserId > 0) {
          RegistrarChannel.perform(
            'register',
            {
              userId: this.nextRegisterUserId,
              machine_serial: action.machine_serial,
              card_serial: action.card_serial,
              packet_id: action.packet_id,
            },
          );
        }
        break;
      }
      case REGISTER_SUCCESS: {
        this.nextRegisterUserId = 0;
        this.update(action.user.id, new User(action.user));
        this.emit(action.type, this.users);
        break;
      }
      case REGISTER_UPDATE: {
        const user = new User(action.user);
        this.update(user.id, user);
        if (this.nextRegisterUserId === user.id) {
          this.nextRegisterUserId = 0;
        }
        this.emit(action.type, this.users, this.nextRegisterUserId);
        break;
      }
      case CANCEL_REGISTER: {
        this.nextRegisterUserId = 0;
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_USERS);
    this.removeAllListeners(START_REGISTER);
    this.removeAllListeners(REGISTER);
    this.removeAllListeners(REGISTER_SUCCESS);
    this.removeAllListeners(REGISTER_UPDATE);
    this.removeAllListeners(CANCEL_REGISTER);
  }
}

const users = new UserStore();

export default users;
