import React from 'react'

const Cell = (props) => {
  if (props.sun) return <span className="board-square sun">☀️</span>
  if (props.moon) return <span className="board-square moon">🌙</span>
  return <span className="board-square">⬜️</span>
}

const Row = (props) => (<div className="board-row">{props.cells.map(cell => <Cell key={cell.col} {...cell} />)}</div>)

export default (props) => {
  const board = props.game.board
  return (
    <div className="board">
      {board.map(row => <Row key={row.row} {...row} />)}
    </div>
  )
}
