import { EventEmitter } from 'events';

const Cable = ActionCable.createConsumer();

export const EventTypes = {
  Connected: 'CONNECTED',
  Disconnected: 'DISCONNECTED',
  Received: 'RECEIVED',
};

class Channel extends EventEmitter {
  constructor(channel) {
    console.log("______constructor")
    super();
    this.channel = Cable.subscriptions.create(channel);
    this.channel.connected = () => this.emit(EventTypes.Connected);
    this.channel.disconnected = () => this.emit(EventTypes.Disconnected);
    this.channel.received = data => {
      console.log("this.channel.received!!!")
      console.log(data)
      this.emit(EventTypes.Received, data)};
  }

  onReceived(callback) {
    console.log("______onReceived")
    this.on(EventTypes.Received, callback);
  }

  off() {
    this.removeAllListener(EventEmitter.Received);
  }

  follow() {
    console.log("---follow")
    setTimeout(() => this.channel.perform('follow'), 1000);
  }

  unfollow() {
    setTimeout(() => this.channel.perform('unfollow'), 1000);
  }

  perform(...args) {
    console.log("perform")
    this.channel.perform(...args);
  }
}

export default Channel;

