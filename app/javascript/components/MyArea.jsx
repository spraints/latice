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

const Tile = (props) => {
  const classes = `tile ${props.identifier} ${props.color} ${props.shape}`
  const content = props.is_wind ? WIND : `${SHAPES[props.shape]}${COLORS[props.color]}`
  return <div className={classes} data-id={props.id}>{content}</div>
}

export default (props) => {
  return (
    <div>
      <div className="rack">
        <h4>My tiles</h4>
        {props.game.racked_tiles.map(tile => <Tile key={tile.id} {...tile} />)}
      </div>
      <div className="pool">
        {props.game.current_player.tile_counts.total - props.game.current_player.tile_counts.in_rack} more tiles
      </div>
    </div>
  )
}
