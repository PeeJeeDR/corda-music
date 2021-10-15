import React, { useState } from 'react'
import { ScrollView, View } from 'react-native'
import BaseSearchInput from '../components/BaseSearchInput'
import SearchResultItem from '../components/SearchResultItem'
import useDownload from '../hooks/useDownload'
import useYoutube from '../hooks/useYoutube'
import globalStyles from '../styles'

export default () => {
  const [search, setSearch] = useState('wrecked')
  const { results, searchOnYoutube, getDownloadURLById } = useYoutube()
  const { downloadBasedOnURL } = useDownload()

  const submit = async () => {
    console.log('END', search)

    searchOnYoutube(search)
  }

  const onDownloadClick = async video => {
    console.log('download', video)
    const url = await getDownloadURLById(video.id)

    downloadBasedOnURL(url, video.title).then(res => {
      console.log('Downloaded', res)
    })

    console.log('url', url)
  }

  return (
    <View style={globalStyles.screen}>
      <BaseSearchInput
        value={search}
        onChangeText={value => setSearch(value)}
        onSubmitEditing={submit}
      />

      <ScrollView>
        {results.map(result => (
          <SearchResultItem
            key={result.id}
            source={result}
            downloadClick={onDownloadClick}
          />
        ))}
      </ScrollView>
    </View>
  )
}
