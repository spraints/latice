import React from "react"

class SetUpPlayer extends React.Component {
  render() {
    return (
      <div>
        {this.props.user}
        {this.props.me === this.props.user && <span>(you)</span>}
        {this.props.ready && <span>(ready)</span>}
      </div>
    )
  }
}

export default SetUpPlayer
