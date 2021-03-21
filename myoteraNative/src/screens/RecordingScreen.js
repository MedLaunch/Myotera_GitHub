import React, {useContext, useEffect} from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { MovesenseContext } from '../context/MovesenseProvider';
import { newData } from '../reducers/recorders/actions';
import MDS from 'react-native-mds';

export default function RecordingScreen({navigation}) {
  const { movesense, recordersDispatch } = useContext(MovesenseContext);

  useEffect(() => {
    let subkey = null
    const navigated = navigation.addListener('focus', () => {
      console.log('Navigated to Recording Page!');
    
      try {
        const address = movesense.connectedDevices[0]
        const serial = movesense.devices[address].serial
        console.log(serial)
        subkey = MDS.subscribe(serial, "/Meas/IMU9/52", {}, (response) => {
                    responseDict = JSON.parse(response)
                    recordersDispatch(newData(address, responseDict.Body))
                }, (error) => {
                    console.log("Errors:")
                    console.log(error)
                })
      } catch (err) {
        if (err instanceof ReferenceError) {
          console.log("Can't scan on web!");
        } else {
          console.log(err);
        }
      }
    });
    const blurred = navigation.addListener('blur', () => {
      console.log('Left Recording Page!');
      try {
        console.log(subkey)
        MDS.unsubscribe(subkey);
      } catch (err) {
        if (err instanceof TypeError) {
          console.log("Can't scan on web!");
        } else {
          console.log(err);
        }
      }
    });
    // Clean up the event listeners on unmount
    return () => {
      navigated();
      blurred();
    };
  },[])

  return (
    <View style={styles.container}>
      <Text>Recording!</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  itemSeparator: {
    height: 2,
    backgroundColor: "rgba(0,0,0,0.5)",
    // marginLeft: 10,
    // marginRight: 10,
  }
});
