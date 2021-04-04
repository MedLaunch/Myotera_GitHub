import { ADD_BLE, CONNECTED_DEVICE, DISCONNECTED_DEVICE, CHANGE_STATUS } from './constants';
import MDS from 'react-native-mds';

export const INITIAL_MOVESENSE_STATE = {
  devices: {},
  connectedDevices: [],
  status: 'disconnected'
};

export default function movesenseReducer(state, action) {
  switch (action.type) {
    case ADD_BLE:
      console.log("ADD DEVICE!", state, action)
      if (action.payload.address in state.devices) {
        return state;
      }
      console.log("STATE CHANGE", action)
      return {
        ...state,
        devices: {
          ...state.devices,
          [action.payload.address]: {
            name: action.payload.name,
            address: action.payload.address,
          }
        }
      }
    case CONNECTED_DEVICE:
      if (state.connectedDevices.includes(action.payload.address)) {
        return state;
      }
      return {
        ...state,
        status: 'connected',
        connectedDevices: [...state.connectedDevices, action.payload.address],
        devices: {
          ...state.devices,
          [action.payload.address]: {
            name: action.payload.name,
            address: action.payload.address,
            serial: action.payload.serial,
          }
        }
      }
    case DISCONNECTED_DEVICE: {
      const key = Object.keys(state.devices).find((key) => state.devices[key]?.serial === action.payload.serial)
      const address = state.devices[key].address
      if (!state.connectedDevices.includes(address)) {
        return state;
      }
      return {
        ...state,
        status: 'disconnected',
        connectedDevices: state.connectedDevices.filter(device => device !== address)
      }
    }
    case CHANGE_STATUS:
      return {
        ...state,
        status: action.payload.status
      }
    default:
      throw new Error();
  }
}
