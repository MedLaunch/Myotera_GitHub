import React, { createContext, useEffect, useReducer } from 'react';
import movesenseReducer, { INITIAL_MOVESENSE_STATE } from '../reducers/movesense/reducer';
import recordersReducer, { INITIAL_RECORDING_STATE } from '../reducers/recorders/reducer';
import { connectedDevice, disconnectedDevice } from '../reducers/movesense/actions';
import MDS from 'react-native-mds';

export const MovesenseContext = createContext();

const MovesenseProvider = ({ children }) => {
  const [movesense, movesenseDispatch] = useReducer(movesenseReducer, INITIAL_MOVESENSE_STATE);
  const [recorders, recordersDispatch] = useReducer(recordersReducer, INITIAL_RECORDING_STATE);
  useEffect(() => {
    try {
      MDS.setHandlers(
        (serial, name, address) => {
          // Dev Connected Handler
          movesenseDispatch(connectedDevice(serial, name, address));
        },
        (serial) => {
          // Dev Disconnected Handler
          movesenseDispatch(disconnectedDevice(serial));
        }
      );
    } catch (err) {
      if (err instanceof TypeError) {
        console.log("Can't scan on web!");
      } else {
        console.log(err);
      }
    }
  }, [])

  return (
    <MovesenseContext.Provider value={{
      movesense, movesenseDispatch,
      recorders, recordersDispatch
    }}>
      {children}
    </MovesenseContext.Provider>
  )
}

export default MovesenseProvider;
