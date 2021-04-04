import { START_RECORDING, STOP_RECORDING, NEW_DATA } from './constants';

export const startRecording = (address) => ({
  type: START_RECORDING,
  payload: {
    address
  }
});

export const stopRecording = (address) => ({
  type: STOP_RECORDING,
  payload: {
    address
  }
});

export const newData = (address, data) => ({
  type: NEW_DATA,
  payload: {
    address,
    data
  }
});
