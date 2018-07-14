import React from "react"

import SetUpPlayer from "./SetUpPlayer"

class SetUpPlayers extends React.Component {
  render() {
    return (
      <div>
        <h3>Players</h3>
        {this.props.players.map(player => <SetUpPlayer key={player.id} me={this.props.me} {...player} />)}
        {this.props.onJoin && (<div><button onClick={this.props.onJoin}>Join</button></div>)}
        {this.props.onLeave && (<div><button onClick={this.props.onLeave}>Leave</button></div>)}
        {this.props.onReady && (<div><button onClick={this.props.onReady}>Ready</button></div>)}
        {this.props.onNotReady && (<div><button onClick={this.props.onNotReady}>Not Ready</button></div>)}
        <pre>{JSON.stringify(this.props, null, 1)}</pre>
      </div>
    )
  }
}

export default SetUpPlayers
