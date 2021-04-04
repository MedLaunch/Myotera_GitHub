import { ADD_BLE, CONNECTED_DEVICE, DISCONNECTED_DEVICE, CHANGE_STATUS } from './constants';

export const addBLE = (name, address) => ({
  type: ADD_BLE,
  payload: {
    name,
    address
  }
});

export const connectedDevice = (serial, name, address) => ({
  type: CONNECTED_DEVICE,
  payload: {
    serial,
    name,
    address
  }
});

export const disconnectedDevice = (serial) => ({
  type: DISCONNECTED_DEVICE,
  payload: {
    serial
  }
});

export const changeStatus = (status) => ({
  type: CHANGE_STATUS,
  payload: {
    status
  }
});
