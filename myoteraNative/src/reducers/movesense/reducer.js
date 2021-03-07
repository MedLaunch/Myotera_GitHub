import { ADD_BLE, CONNECTED_DEVICE, DISCONNECTED_DEVICE, CHANGE_STATUS } from './constants';

export const INITIAL_MOVESENSE_STATE = {
  devices: [],
  connectedDevices: [],
  status: 'disconnected'
};

export default function movesenseReducer(state, action) {
  switch (action.type) {
    case ADD_BLE:
      console.log("ADD DEVICE!", state, action)
      if (state.devices.some(device => device.name === action.payload.name && device.address === action.payload.address)) {
        return state;
      }
      return {
        ...state,
        devices: [
          ...state.devices,
          {
            name: action.payload.name,
            address: action.payload.address,
          }
        ]
      }
    case CONNECTED_DEVICE:
      if (state.connectedDevices.includes(action.payload.serial)) {
        return state;
      }
      return {
        ...state,
        status: 'connected',
        connectedDevices: [...state.connectedDevices, action.payload.serial]
      }
    case DISCONNECTED_DEVICE:
      if (!state.connectedDevices.includes(action.payload.serial)) {
        return state;
      }
      return {
        ...state,
        status: 'disconnected',
        connectedDevices: state.connectedDevices.filter(device => device !== action.payload.serial)
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
