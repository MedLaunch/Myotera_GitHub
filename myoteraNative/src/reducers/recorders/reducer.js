import { START_RECORDING, STOP_RECORDING, NEW_DATA } from './constants';
import MDS from 'react-native-mds';

export const INITIAL_RECORDING_STATE = {
  recording: false,
  data: {}
};

export default function recordersReducer(state, action) {
  switch (action.type) {
    case START_RECORDING:
      return state;

    case STOP_RECORDING:
      return state
    
    case NEW_DATA: {
      console.log(action.payload.data)
      if (action.payload.address in state.data) {
        return {
          ...state,
          data: {
            ...state.data,
            [action.payload.address]:[...state.data[action.payload.address], action.payload.data]
          }
        }
      }
      return {
        ...state,
        data: {
          ...state.data,
          [action.payload.address]:[action.payload.data]
        }
      }
    }
    
    default:
      throw new Error();
  }
}
