import React from 'react'

import Tile from './Tile'

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
