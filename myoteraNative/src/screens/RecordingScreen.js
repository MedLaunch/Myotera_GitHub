import React from 'react';
import React, {useContext, useEffect} from 'react';
import { MovesenseContext } from '../context/MovesenseProvider';
import { newData } from '../reducers/recorders/actions';
import MDS from 'react-native-mds';
import { StyleSheet, Text, SafeAreaView, View, Pressable } from 'react-native';

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
        <SafeAreaView style={styles.container}>
            <Pressable
                onPress={()=>navigation.navigate("Home")}
                style={styles.backButton}>
                <Text style={styles.backButtonText}>Back</Text>
            </Pressable>

            <Text style={styles.recordingText}>
                Recording...
            </Text>

            <View style={styles.ellipse7}></View>
            <View style={styles.ellipse8}></View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27'
    },
    recordingText: {
        position: "absolute",
        width: 320,
        height: 41,
        left: 27,
        top: 118,
        fontFamily: "Helvetica",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 28,
        lineHeight: 32,
        textAlign: "center",
        color: "#FFFFFF"
    },
    backButton: {
        left: 20,
        top: 10,
    },
    backButtonText: {
        color: "#FFFFFF",
        fontWeight: "bold",
    },
    ellipse7: {
        position: "absolute",
        width: 56,
        height: 56,
        left: 158.5,
        top: 700,
        backgroundColor: "#9394FC",
        shadowOffset: {
            width: 0,
            height: 4
        },
        shadowRadius: 10,
        shadowColor: "rgb(147, 148, 252)",
        shadowOpacity: 0.4,
        borderRadius: 28
    },
    ellipse8: {
        position: "absolute",
        width: 46,
        height: 46,
        left: 164,
        top: 705,
        backgroundColor: "#8A1B1B",
        borderRadius: 23
    }
      
});
