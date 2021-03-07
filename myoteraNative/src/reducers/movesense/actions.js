import { ADD_BLE, CONNECTED_DEVICE, DISCONNECTED_DEVICE } from './constants';

export const addBLE = (name, address) => ({
  type: ADD_BLE,
  payload: {
    name,
    address
  }
});

export const connectedDevice = (serial) => ({
  type: CONNECTED_DEVICE,
  payload: {
    serial
  }
});

export const disconnectedDevice = (serial) => ({
  type: DISCONNECTED_DEVICE,
  payload: {
    serial
  }
});
