import React from "react"

import SetUpPlayer from "./SetUpPlayer"

class SetUpPlayers extends React.Component {
  getPlayer(position) {
    for (let player of this.props.players) {
      if (player.position == position) {
        return player.user
      }
    }
    return null
  }

  get canJoin() {
    for (let player of this.props.players) {
      if (player.user == this.props.me) {
        return false
      }
    }
    return true
  }

  get canStartGame() {
    return false
  }

  onStart = () => {
    this.props.onStart()
  }

  render() {
    return (
      <div>
        <SetUpPlayer position="1" player={this.getPlayer(1)} me={this.props.me} canJoin={this.canJoin} onJoin={this.props.onJoin} />
        <SetUpPlayer position="2" player={this.getPlayer(2)} me={this.props.me} canJoin={this.canJoin} onJoin={this.props.onJoin} />
        <SetUpPlayer position="3" player={this.getPlayer(3)} me={this.props.me} canJoin={this.canJoin} onJoin={this.props.onJoin} />
        <SetUpPlayer position="4" player={this.getPlayer(4)} me={this.props.me} canJoin={this.canJoin} onJoin={this.props.onJoin} />
        {this.canStartGame && <StartGameButton onStart={this.onStart} />}
      </div>
    )
  }
}

export default SetUpPlayers
