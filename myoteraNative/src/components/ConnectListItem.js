import React, { useContext } from 'react';
import { StyleSheet, Text, Pressable, View } from 'react-native';
import MDS from 'react-native-mds';
import { MovesenseContext } from '../context/MovesenseProvider';

export default function ConnectListItem({ item }) {
  const { movesense } = useContext(MovesenseContext);
  const isConnected = movesense.connectedDevices.includes(item?.address)
  const connect = () => {
    try {
      console.log("CONNECT", isConnected);
      if (isConnected) {
        MDS.disconnect(item.address)
      } else {
        console.log("MADE IT TO CONNECT")
        MDS.connect(item.address);
      }
    } catch (err) {
      if (err instanceof ReferenceError) {
        console.log("Can't connect on web!");
      } else {
        console.log(err);
      }
    }
  }
  return (
    <View style={styles.container}>
      { !item ?
        <Text style={styles.listItem}>No search results!</Text> :
        <Pressable
          onPress={connect}
          style={({ pressed }) => [
            styles.listItem,
            styles.pressableItem,
            { ...(isConnected ? { backgroundColor: 'rgb(210, 230, 255)' } : {}) },
            { ...(pressed ? { backgroundColor: 'rgb(210, 230, 255)' } : {}) },
          ]}>
          <Text style={styles.listItemText}>Device {item.name}, {item.address}</Text>
        </Pressable>
      }
    </View>
  );
}

const styles = StyleSheet.create({
  container: {

  },
  listItem: {
    // padding: '10pt',
    backgroundColor: 'white'
  },
  pressableItem: {
    // cursor: 'pointer'
  }
});
