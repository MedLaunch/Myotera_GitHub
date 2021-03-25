import React, {useContext, useState, useEffect} from 'react';
import { StyleSheet, FlatList, Text, View, Pressable } from 'react-native';
import { MovesenseContext } from '../context/MovesenseProvider';
import ConnectListItem from '../components/ConnectListItem';
import { addBLE } from '../reducers/movesense/actions';
import MDS from 'react-native-mds';

export default function ConnectScreen({navigation}) {
  const { movesense, movesenseDispatch} = useContext(MovesenseContext);
  const [searchText, setSearchText] = useState('');
  const [filteredDevices, setFilteredDevices] = useState([]);

  useEffect(() => {
    const navigated = navigation.addListener('focus', () => {
      console.log('Navigated to Connect Page!');
      // movesenseDispatch(addBLE("Name", "Add"));
      try {
        MDS.scan((name, address) => {
          movesenseDispatch(addBLE(name, address));
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
      console.log('Left Connect Page!');
      try {
        MDS.stopScan();
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

  useEffect(() => {
    // Filter devices with search bar
    setFilteredDevices(movesense.devices.filter((item) => item.name.toLowerCase().includes(searchText.trim().toLowerCase())))
  }, [movesense, searchText])
  const updateSearch = (text) => {
    setSearchText(text);
  };
  const ItemSeparator = () => <View style={styles.itemSeparator} />
  const ListEmpty = () => <ConnectListItem />
  return (
    <View style={styles.container}>
      <Pressable
        onPress={()=>navigation.navigate("Home")}
        style={styles.backButton}>
        <Text style={styles.backButtonText}>Back</Text>
      </Pressable>
      <Text style={styles.backButtonText}>Connect!</Text>
      <FlatList
        data={filteredDevices}
        renderItem={({item}) => (
          <ConnectListItem item={item} />
        )}
        ListEmptyComponent={ListEmpty}
        keyExtractor={item => item.address}
        ItemSeparatorComponent={ItemSeparator}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    width: "100%",
    flex: 1,
    backgroundColor: '#1f1b27',
    alignItems: "center"
  },
  backButton: {
    width: "100%"
  },
  backButtonText: {
      color: "white"
  },
  itemSeparator: {
    height: 2,
    backgroundColor: "rgba(0,0,0,0.5)",
    // marginLeft: 10,
    // marginRight: 10,
  }
});
