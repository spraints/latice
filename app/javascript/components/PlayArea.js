import React from "react"
import PropTypes from "prop-types"
class PlayArea extends React.Component {
  constructor(props) {
    super(props)
    const {name} = props
    this.state = {name}
  }

  updateName = (e) => {
    this.setState({name: e.target.value})
  }

  get name() {
    console.log(this.state.name || "")
    this.state.name || ""
  }

  render () {
    return (
      <div>
        Hello, {this.state.name}!
        <br />
        <input type="text" value={this.name} onChange={this.updateName} />
      </div>
    );
  }
}

PlayArea.propTypes = {
  name: PropTypes.string
};

export default PlayArea
