import React from 'react'


// bird gecko turtle feather flower dolphin
// yellow navy magenta red green teal

const SHAPES = {
  bird: 'A',
  gecko: 'B',
  turtle: 'C',
  feather: 'D',
  flower: 'E',
  dolphin: 'F',
}

const WIND = '💨'

export default (props) => {
  const classes = `tile ${props.identifier} ${props.color} ${props.shape}`
  const content = props.is_wind ? WIND : `${SHAPES[props.shape]}`
  return <div className={classes} data-id={props.id}>{content}</div>
}
