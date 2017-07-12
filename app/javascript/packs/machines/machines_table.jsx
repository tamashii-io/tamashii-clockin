import React from 'react';

import store from './store';
import {
  RECEIVE_MACHINES,
  LAST_ACTIVE_CHANGED,
} from './constants';
import { fetchMachines } from './action';
import MachinesTableItem from './machines_table_item';

class MachinesTable extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      machines: [],
    };
  }

  componentWillMount() {
    fetchMachines();
  }

  componentDidMount() {
    store.on(RECEIVE_MACHINES, () => this.setState({ machines: store.machines }));
    store.on(LAST_ACTIVE_CHANGED, () => this.setState({ machines: store.machines }));
  }

  componentWillUnmount() {
    store.removeAllListeners(RECEIVE_MACHINES);
    store.removeAllListeners(LAST_ACTIVE_CHANGED);
  }

  machines() {
    const machines = this.state.machines;
    return machines.map(machine => <MachinesTableItem key={machine.id} machine={machine} />);
  }

  render() {
    return (
      <table className="table table-bordered table-striped table-condensed">
        <thead>
          <tr>
            <th>裝置的機器序號</th>
            <th>裝置名稱</th>
            <th>類型</th>
            <th>指令</th>
            <th>最後連線時間</th>
            <th>對應工作人員</th>
            <th>處理</th>
          </tr>
        </thead>
        <tbody>
          { this.machines() }
        </tbody>
      </table>
    );
  }
}

export default MachinesTable;
