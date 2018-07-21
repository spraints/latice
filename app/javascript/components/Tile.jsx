import React from 'react'


// bird gecko turtle feather flower dolphin
// yellow navy magenta red green teal

const SHAPES = {
  bird: '🦉',
  gecko: '🦎',
  turtle: '🐢',
  feather: '➳',
  flower: '🌸',
  dolphin: '🐬'
}

const COLORS = {
  yellow: '💛',
  navy: '💙',
  magenta: '💖',
  red: '❤️',
  green: '💚',
  teal: '🧡'
}

const WIND = '💨'

export default (props) => {
  const classes = `tile ${props.identifier} ${props.color} ${props.shape}`
  const content = props.is_wind ? WIND : `${SHAPES[props.shape]}${COLORS[props.color]}`
  return <div className={classes} data-id={props.id}>{content}</div>
}
