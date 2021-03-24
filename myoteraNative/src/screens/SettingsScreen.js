import React from 'react';
import { StyleSheet, Text, Pressable, View } from 'react-native';
import MDS from 'react-native-mds';

function StyledPressable({ onPress, title }) {
  return (
    <Pressable
      onPress={onPress}
      style={({ pressed }) => [
        {
          backgroundColor: pressed
            ? 'rgb(210, 230, 255)'
            : 'white'
        },
        styles.wrapperCustom
      ]}>
      <Text>{title}</Text>
    </Pressable>
  )
}
export default function SettingsScreen() {
  const startScan = () => {
    MDS.scan((name, address) => {
      console.log(name, address)
    })
  }
  const stopScan = () => {
    MDS.stopScan();
  }
  return (
    <View style={styles.container}>
      <Text>Settings!</Text>
      <StyledPressable onPress={startScan} title={"Start Scan"}></StyledPressable>
      <StyledPressable onPress={stopScan} title={"Stop Scan"}></StyledPressable>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  wrapperCustom: {
    borderRadius: 8,
    padding: 6
  },
});
