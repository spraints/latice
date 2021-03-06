import React from 'react'

import Tile from './Tile'

export default class MyArea extends React.Component {
  onSelect = (tileId) => {
    this.setState({selectedTileId: tileId})
  }

  get selectedTileId() {
    if (!this.state) return null
    return this.state.selectedTileId
  }

  render() {
    const {selectedTileId} = this.state || {}
    return (
      <div>
        <div className="rack">
          <h4>My tiles</h4>
          {this.props.game.racked_tiles.map(tile =>
            <Tile
              key={tile.id}
              selected={this.selectedTileId === tile.id}
              onSelect={this.onSelect}
              {...tile}
              />)}
        </div>
        <div className="pool">
          {this.props.game.current_player.tile_counts.total - this.props.game.current_player.tile_counts.in_rack} more tiles
        </div>
      </div>
    )
  }
}
