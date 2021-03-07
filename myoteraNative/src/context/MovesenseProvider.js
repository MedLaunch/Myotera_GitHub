import React, {createContext, useEffect, useReducer} from 'react';
import movesenseReducer, {INITIAL_MOVESENSE_STATE} from '../reducers/movesense/reducer';
import {connectedDevice} from '../reducers/movesense/actions';
import MDS from 'react-native-mds';

export const MovesenseContext = createContext();

const MovesenseProvider = ({children}) => {
  const [movesense, movesenseDispatch] = useReducer(movesenseReducer, INITIAL_MOVESENSE_STATE);
  useEffect(() => {
    try {
      MDS.setHandlers(
        (serial) => {
          // Dev Connected Handler
          movesenseDispatch(connectedDevice(serial));
          console.log(serial);
          MDS.get(serial, '/Info', {}, (response) => { console.log(response)}, (error) => { console.log('Error', error) })
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
      movesense, movesenseDispatch}}>
      {children}
    </MovesenseContext.Provider>
  )
}

export default MovesenseProvider;
