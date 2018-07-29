import React from 'react'

class Opponent extends React.Component {
  render() {
    return (
      <div className="opponent">
        <h4>{this.props.user}</h4>
        {this.props.tile_counts.in_rack} / {this.props.tile_counts.total}
      </div>
    )
  }
}

export default props => {
  const {players, current_player} = props.game
  return (
    <div className="opponents">
      <h3>Other Players</h3>
      {players.map(player => (player.id == current_player.id ? null : <Opponent key={player.id} {...player} />))}
    </div>
  )
}
