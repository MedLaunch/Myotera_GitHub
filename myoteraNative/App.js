import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import HomeScreen from './src/screens/HomeScreen';
import SettingsScreen from './src/screens/SettingsScreen';
import ConnectScreen from './src/screens/ConnectScreen';
import RecordingScreen from './src/screens/RecordingScreen';
import MovesenseProvider from './src/context/MovesenseProvider';

const Tab = createBottomTabNavigator();

export default function App() {
  return (
    <MovesenseProvider>
      <NavigationContainer>
        <Tab.Navigator>
          <Tab.Screen name="Home" component={HomeScreen} />
          <Tab.Screen name="Settings" component={SettingsScreen} />
          <Tab.Screen name="Connect" component={ConnectScreen} />
          <Tab.Screen name="Recording" component={RecordingScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </MovesenseProvider>
  );
}
