import React from 'react'
import {StyleSheet, Text, View, TouchableNativeFeedback} from 'react-native'
import IconDownload from '../icons/IconDownload'

export default ({title, icon, click}) => {
  const IconToRender = () => {
    switch (icon) {
      case 'download':
        return <IconDownload />
    }
  }

  return (
    <TouchableNativeFeedback onPress={click}>
      <View style={icon ? styles.iconButton : styles.button}>
        {title && <Text>{title}</Text>}

        {icon && IconToRender()}
      </View>
    </TouchableNativeFeedback>
  )
}

const styles = StyleSheet.create({
  button: {
    width: 40,
    height: 30,
    padding: 20,
    overflow: 'hidden'
  },

  iconButton: {
    width: 40,
    height: 40,
    backgroundColor: '#70237C',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 15,
    overflow: 'hidden'
  }
})
