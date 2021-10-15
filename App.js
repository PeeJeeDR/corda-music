import React from 'react'
import { View, TouchableNativeFeedback } from 'react-native'
import { NavigationContainer } from '@react-navigation/native'
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs'

import SearchScreen from './src/screens/Search'
import MusicScreen from './src/screens/Music'
import SettingsScreen from './src/screens/Settings'

import IconSearch from './src/icons/IconSearch'
import IconMusic from './src/icons/IconMusic'
import IconSettings from './src/icons/IconSettings'
import globalStyles from './src/styles'

const Tab = createBottomTabNavigator()

export default () => {
  return (
    <NavigationContainer>
      <Tab.Navigator
        initialRouteName="Music"
        screenOptions={{
          tabBarShowLabel: false,
          tabBarStyle: {
            height: 70,
            alignItems: 'center',
            flexDirection: 'row',
            backgroundColor: globalStyles.colors.background,
            borderTopWidth: 0
          },
          headerStyle: {
            backgroundColor: globalStyles.colors.background,
            elevation: 0
          },
          headerTitleStyle: {
            color: 'white'
          }
        }}>
        <Tab.Screen
          name="Search"
          component={SearchScreen}
          options={{
            title: 'Zoeken',
            tabBarButton: ({ children, style, ...props }) => (
              <TouchableNativeFeedback
                {...props}
                background={TouchableNativeFeedback.Ripple('#2962ff1f', true)}>
                <View style={style}>
                  <IconSearch />
                </View>
              </TouchableNativeFeedback>
            )
          }}
        />

        <Tab.Screen
          name="Music"
          component={MusicScreen}
          options={{
            title: 'Muziek',
            tabBarButton: ({ children, style, ...props }) => (
              <TouchableNativeFeedback
                {...props}
                background={TouchableNativeFeedback.Ripple('#2962ff1f', true)}>
                <View style={style}>
                  <IconMusic />
                </View>
              </TouchableNativeFeedback>
            )
          }}
        />

        <Tab.Screen
          name="Settings"
          component={SettingsScreen}
          options={{
            title: 'Instellingen',
            tabBarButton: ({ children, style, ...props }) => (
              <TouchableNativeFeedback
                {...props}
                background={TouchableNativeFeedback.Ripple('#2962ff1f', true)}>
                <View style={style}>
                  <IconSettings />
                </View>
              </TouchableNativeFeedback>
            )
          }}
        />
      </Tab.Navigator>
    </NavigationContainer>
  )
}
