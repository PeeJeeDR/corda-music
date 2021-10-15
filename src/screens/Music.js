import React, { useState } from 'react'
import { StyleSheet, Text, SafeAreaView } from 'react-native'
import RNFetchBlob from 'rn-fetch-blob'

export default () => {
  const [files, setFiles] = useState()

  RNFetchBlob.fs.ls(`${RNFetchBlob.fs.dirs.MusicDir}/CordaMusic/`).then(res => {
    console.log('files', res)
  })

  return (
    <SafeAreaView style={styles.container}>
      <Text>Music</Text>
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
})
