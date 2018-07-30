import * as React from 'react'

import SetUpPlayers from './SetUpPlayers'

import Board from './Board'
import Opponents from './Opponents'
import MyArea from './MyArea'

type props = {
  url: string
}

type state = {
  loaded: boolean
  game: game
}

type game = {
  state: gameState
  current_user: string
  current_player: player
  players: Array<player>
  racked_tiles: Array<tile>
  board: board
  urls: gameUrls
}

type player = {
  id: number
  position: number
  user: string
  ready: boolean
  tile_counts: {
    in_rack: number
    total: number
  }
}

type tile = {
  id: number
  identifier: string
  is_wind: boolean
  shape: string // todo an enum tileShape?
  color: string // todo an enum tileColor?
}

type board = Array<boardRow>
type boardRow = {
  row: number
  cells: Array<boardCell>
}
type boardCell = {
  row: number
  col: number
  sun: boolean
  moon: boolean
}

type gameUrls = {
  join: string
  player: string
  ready: string
}

enum gameState {
  PREGAME = 'pregame',
  PLAYING = 'playing'
}

class Game extends React.Component<props, state> {
  constructor(props) {
    super(props)
    this.state = {
      loaded: false,
      game: null
    }
  }

  componentDidMount() {
    this.loadGame(true)
  }

  async loadGame(poll = false) {
    const response = await fetch(this.props.url, {
      credentials: 'same-origin'
    })
    const game = await response.json()
    window['LaticeGame'] = game
    this.setState({game, loaded: true})
    if (poll) {
      // todo - replace this with a websocket
      setTimeout(() => {
        this.loadGame(poll)
      }, 1000)
    }
  }

  get maybeOnJoin() {
    if (this.pregame && this.state.game.urls.join !== undefined) {
      return this.onJoin
    }
    return null
  }

  onJoin = async () => {
    this.setState({loaded: false})
    await this.post(this.state.game.urls.join)
    await this.loadGame()
  }

  get maybeOnLeave() {
    if (this.pregame && this.state.game.urls.player !== undefined) {
      return this.onLeave
    }
    return null
  }

  onLeave = async () => {
    this.setState({loaded: false})
    await this.delete(this.state.game.urls.player)
    await this.loadGame()
  }

  get maybeOnReady() {
    if (this.pregame && this.my_player && this.state.game.urls.ready && !this.my_player.ready) {
      return this.onReady
    }
    return null
  }

  onReady = async () => {
    this.setState({loaded: false})
    await this.put(this.state.game.urls.ready)
    await this.loadGame()
  }

  get maybeOnNotReady() {
    if (this.pregame && this.my_player && this.state.game.urls.ready && this.my_player.ready) {
      return this.onNotReady
    }
    return null
  }

  onNotReady = async () => {
    this.setState({loaded: false})
    await this.delete(this.state.game.urls.ready)
    await this.loadGame()
  }

  async post(url, data = {}) {
    await this.req('POST', url, data)
  }

  async put(url, data = {}) {
    await this.req('PUT', url, data)
  }

  async delete(url) {
    await this.req('DELETE', url, {})
  }

  async req(method, url, data) {
    if (url === undefined) return

    const csrfToken = document.getElementsByName('csrf-token')[0]['content']

    const response = await fetch(url, {
      method: method,
      headers: {
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(data),
      credentials: 'same-origin'
    })

    console.log(`${method} ${url} -> ${response.status}`)
  }

  get loading() {
    return !this.state.loaded
  }

  get loaded() {
    return this.state.loaded
  }

  get pregame() {
    return this.loaded && this.state.game.state === 'pregame'
  }

  get players() {
    return this.loaded && this.state.game.players
  }

  get me() {
    return this.loaded && this.state.game.current_user
  }

  get my_player() {
    return this.loaded && this.state.game.current_player
  }

  render() {
    if (this.loading) {
      return <div>Loading game state...</div>
    } else if (this.pregame) {
      return (
        <div>
          <h2>New Game</h2>
          <SetUpPlayers
            players={this.players}
            me={this.me}
            onJoin={this.maybeOnJoin}
            onLeave={this.maybeOnLeave}
            onReady={this.maybeOnReady}
            onNotReady={this.maybeOnNotReady}
          />
        </div>
      )
    } else {
      return (
        <div>
          <h2>Latice</h2>
          <Board game={this.state.game} />
          <Opponents game={this.state.game} />
          <MyArea game={this.state.game} />
        </div>
      )
    }
  }
}

export default Game
