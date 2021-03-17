import React from 'react';
import { StyleSheet, Text, View, Image, Button, TouchableOpacity } from 'react-native';

export default function HomeScreen() {
  return (
      <View style={styles.container}>
          <Text style={styles.greetText}>
              Hi Patrick!
          </Text>

          <View style={styles.myoteraLogoContainer}>
              <Image source={require("../../myotera_logo.png")}
                  style={styles.logoSize}>
              </Image>
          </View>

          <Text style={styles.grayText}>
              Looks like you're making great progress!
          </Text>

          <Text style={styles.smallWhiteWalk}>
              Recent Walk
          </Text>

          <Text style={styles.smallWhiteMovement}>
              Recent Movement
          </Text>

          <TouchableOpacity style={styles.lavenderButton}>

          </TouchableOpacity>

    </View>

  );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#1f1b27',
        justifyContent: 'center',
        alignItems: 'center'
    },
    greetText: {
        color: '#ffffff',
        fontWeight: 'bold',
        fontSize: 25,
        position: 'absolute',
        top: 150,
        left: 27
    },
    smallWhiteWalk: {
        color: '#ffffff',
        fontSize: 20,
        position: 'absolute',
        top: 250,
        left: 27
    },
    smallWhiteMovement: {
        color: '#ffffff',
        fontSize: 20,
        position: 'absolute',
        top: 500,
        left: 27
    },
    lavenderButton: {
        position: 'absolute',
        bottom: 100
    },
    grayText: {
        color: '#a3a1a5',
        fontSize: 15,
        position: 'absolute',
        top: 200,
        left: 27
    },
    recordButton: {
        position: 'absolute',
        bottom: 100
    },
    myoteraLogoContainer: {
        position: 'absolute',
        top: 20,
        left: 20
    },
    logoSize: {
              width: 130,
        height: 130
    }   
});
