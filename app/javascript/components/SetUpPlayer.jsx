import React from "react"

class SetUpPlayer extends React.Component {
  get canJoin() {
    return this.props.canJoin && !this.props.player
  }

  get isMe() {
    return this.props.player == this.props.me
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
      return (
        <div>
          (todo - a "join" button)
        </div>
      )
    }
    return ""
  }
}

export default SetUpPlayer
