import React from 'react'
import Svg, {Path} from 'react-native-svg'

export default () => {
  return (
    <Svg
      width="35"
      height="35"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor">
      <Path
        strokeLinecap="round"
        strokeLinejoin="round"
        strokeWidth="2"
        stroke="#B2B2B2"
        d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"
      />
    </Svg>
  )
}
