/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
/* global document:true */

// NOTE: Add chart.js
import 'coreui-react';

import Mounter from './helpers/mounter';
import CheckrecordsTable from './checkrecords/check_records_table';
import UsersTable from './users/users_table';
import MachinesTable from './machines/machines_table';
import RegisterCardSerial from './users/register_card_serial';

const modules = [
  new Mounter('#checkrecords', CheckrecordsTable),
  new Mounter('#users', UsersTable),
  new Mounter('#machines', MachinesTable),
];

const registerCardSerial = new RegisterCardSerial('[data-card-serial="true"]');

document.addEventListener('turbolinks:before-cache', () => {
  modules.forEach(module => module.unmount());
  registerCardSerial.unmount();
});

document.addEventListener('turbolinks:load', () => {
  modules.forEach(module => module.mount());
  registerCardSerial.mount();
});
