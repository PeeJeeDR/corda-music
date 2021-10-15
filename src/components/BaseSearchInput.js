import React from 'react'
import {StyleSheet, SafeAreaView, TextInput} from 'react-native'

export default ({value, onChangeText, onSubmitEditing}) => {
  return (
    <SafeAreaView>
      <TextInput
        style={styles.input}
        value={value}
        placeholder="Zoek op Youtube"
        onChangeText={onChangeText}
        onSubmitEditing={onSubmitEditing}
      />
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  input: {
    backgroundColor: '#4F4F4F',
    paddingHorizontal: 20,
    paddingVertical: 12,
    borderRadius: 17,
    color: '#ffffff'
  }
})
