import React from 'react'
import {StyleSheet, Text, View, Image} from 'react-native'
import BaseButton from './BaseButton'

export default ({source, downloadClick}) => {
  return (
    <View style={styles.container}>
      <Image style={styles.image} source={{uri: source.thumbnail.url}} />

      <View style={styles.contentContainer}>
        <View style={styles.textContainer}>
          <Text style={styles.title} ellipsizeMode="tail" numberOfLines={1}>
            {source.title}
          </Text>
          <Text style={styles.description}>{source.channel.name}</Text>
        </View>

        <BaseButton icon="download" click={() => downloadClick(source)} />
      </View>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#291C2D',
    padding: 13,
    borderRadius: 15,
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 15
  },

  image: {
    width: 50,
    height: 50,
    borderRadius: 13
  },

  contentContainer: {
    flexDirection: 'row',
    flex: 1
  },

  textContainer: {
    marginLeft: 10,
    marginRight: 50,
    flexDirection: 'column',
    flex: 1
  },

  title: {
    color: '#C8C8C8',
    fontWeight: 'bold'
  },

  description: {
    color: '#6D6D6D',
    fontSize: 12,
    fontWeight: 'bold',
    marginTop: 2
  }
})
