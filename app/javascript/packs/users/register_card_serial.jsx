import { RegistrarChannel } from '../channels';


class RegisterCardSerial {
  constructor(selector) {
    this.$el = null;
    this.selector = selector;
    RegistrarChannel.onReceived(data => this.registerCardSerial(data));
  }

  mount() {
    this.$el = document.querySelector(this.selector);
    if (this.$el) {
      RegistrarChannel.follow();
    }
  }

  unmount() {
    this.$el = null;
    RegistrarChannel.unfollow();
  }

  registerCardSerial(data) {
    this.$el.value = data.card_serial;
    RegistrarChannel.perform(
      'register',
      {
        new_user: true,
        machine_serial: data.machine_serial,
        card_serial: data.card_serial,
        packet_id: data.packet_id,
      },
    );
  }
}


export default RegisterCardSerial;
