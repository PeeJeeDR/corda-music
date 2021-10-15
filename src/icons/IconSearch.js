import React from 'react'
import Svg, {Path} from 'react-native-svg'

export default () => {
  return (
    <Svg width="35" height="35" viewBox="0 0 24 24">
      <Path
        strokeLinecap="round"
        strokeLinejoin="round"
        strokeWidth="2"
        stroke="#B2B2B2"
        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
      />
    </Svg>
  )
}
