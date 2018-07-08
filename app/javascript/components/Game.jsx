import React from "react"
import PropTypes from "prop-types"

import SetUpPlayers from "./SetUpPlayers"

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
    const response = await fetch(this.props.gameDataURL, {credentials: "same-origin"})
    const game = await response.json()
    window.LaticeGame = game
    this.setState({game, loaded: true})
    // todo - replace this with a websocket
    setTimeout(() => { this.loadGame() }, 1000)
  }

  onJoin = async ({position}) => {
    const csrfParam = document.getElementsByName("csrf-param")[0].content
    const csrfToken = document.getElementsByName("csrf-token")[0].content

    const body = new FormData()
    body.append(csrfParam, csrfToken)
    body.append('position', position)

    const response = await fetch(this.props.joinGameURL, {
      method: "POST",
      // headers: {
      //   'X-CSRF-Token': csrfToken
      // },
      body: body,
      credentials: "same-origin"
    })
  }

  get loading() {
    return !this.state.loaded
  }

  get pregame() {
    return !this.loading && this.state.game.state == "pregame"
  }

  get players() {
    return this.state.game && this.state.game.players
  }

  get me() {
    return this.state.game && this.state.game.current_user
  }

  render() {
    if (this.loading) {
      return (
        <div>Loading game state...</div>
      )
    } else if (this.pregame) {
      return (
        <SetUpPlayers players={this.players} me={this.me} onJoin={this.onJoin} />
      )
    } else {
      return (
        <div>Let's go! {JSON.stringify(this.state)}</div>
      )
    }
  }
}

Game.propTypes = {
  gameDataURL: PropTypes.string,
  joinGameURL: PropTypes.string
}

export default Game
