import RNFetchBlob from 'rn-fetch-blob'

const useDownload = () => {
  const downloadBasedOnURL = (url, title) => {
    console.log('url', url)

    return RNFetchBlob.config({
      fileCache: true,
      addAndroidDownloads: {
        useDownloadManager: true,
        notification: true,
        title: title,
        path: `${RNFetchBlob.fs.dirs.MusicDir}/CordaMusic/${title}.mp3`,
        mediaScannable: true
      }
    }).fetch('GET', url)
  }

  return {
    downloadBasedOnURL
  }
}

export default useDownload
