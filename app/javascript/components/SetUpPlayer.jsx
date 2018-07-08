import React from "react"

class SetUpPlayer extends React.Component {
  get canJoin() {
    return this.props.canJoin && !this.props.player
  }

  get isMe() {
    return this.props.player == this.props.me
  }

  onJoin = () => {
    this.props.onJoin({position: this.props.position})
  }

  render() {
    return (
      <div>
        <b>Player {this.props.position}</b><br/>
        {this.renderIdentity()}
      </div>
    )
  }

  renderIdentity() {
    if (this.isMe) {
      return (<div>(you)</div>) // todo - a leave button?
    }
    if (this.canJoin) {
      return (<div onClick={this.onJoin}>JOIN!!</div>)
    }
    return (<div>{this.props.player || "(empty)"}</div>)
  }
}

export default SetUpPlayer
