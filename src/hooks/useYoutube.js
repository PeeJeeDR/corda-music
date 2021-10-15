import { useState } from 'react'
import ytdl from 'react-native-ytdl'
import ytsr from 'youtube-sr'

const useYoutube = () => {
  const [results, setResults] = useState([])

  const searchOnYoutube = query => {
    ytsr.search(query).then(res => {
      setResults(res)
    })
  }

  const getDownloadURLById = async id => {
    const info = await ytdl.getInfo(id)
    const url = ytdl.chooseFormat(info.formats, { quality: 'lowestaudio' }).url
    return url
  }

  return {
    results,
    searchOnYoutube,
    getDownloadURLById
  }
}

export default useYoutube
