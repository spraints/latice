import React from "react"
import PropTypes from "prop-types"

import PlayerSetup from "./PlayerSetup"

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      loaded: false,
      game: null
    }
  }
  componentDidMount() {
    this.loadGame()
  }

  async loadGame() {
    console.log("loading " + this.props.url + " ...")
    const response = await fetch(this.props.url, {credentials: "same-origin"})
    const game = await response.json()
    console.log(game)
    this.setState({game, loaded: true})
  }

  get loading() {
    return !this.state.loaded
  }

  get pregame() {
    return !this.loading && this.state.game.state == "pregame"
  }

  render() {
    if (this.loading) {
      return (
        <div>Loading game state...</div>
      )
    } else if (this.pregame) {
      return (
        <PlayerSetup players={this.state.game.players} me={this.state.current_user}/>
      )
    } else {
      return (
        <div>Let's go! {JSON.stringify(this.state)}</div>
      )
    }
  }
}

Game.propTypes = {
  url: PropTypes.string
}

export default Game
