import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import HomeScreen from './src/screens/HomeScreen';
import ConnectScreen from './src/screens/ConnectScreen';
import RecordingScreen from './src/screens/RecordingScreen';
import ErrorScreen from './src/screens/SensorErrorScreen';
import MovesenseProvider from './src/context/MovesenseProvider';

const Stack = createStackNavigator();

export default function App() {
  return (
    <MovesenseProvider>
      <NavigationContainer>
        <Stack.Navigator
          screenOptions={{headerShown:false}}>
          <Stack.Screen name="Home" component={HomeScreen} />
          <Stack.Screen name="Connect" component={ConnectScreen} />
          {/* <Stack.Screen name="Recording" component={RecordingScreen} />
          <Stack.Screen name="Error" component={ErrorScreen} /> */}
        </Stack.Navigator>
      </NavigationContainer>
    </MovesenseProvider>
  );
}
