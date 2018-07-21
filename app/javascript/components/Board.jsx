import React from 'react'

const Cell = (props) => {
  if (props.sun) return <span className="cell sun">☀️</span>
  if (props.moon) return <span className="cell moon">🌙</span>
  return <span className="cell">⬜️</span>
}

const Row = (props) => (<div>{props.cells.map(cell => <Cell key={cell.col} {...cell} />)}</div>)

export default (props) => {
  const board = props.game.board
  return (
    <div>
      {board.map(row => <Row key={row.row} {...row} />)}
    </div>
  )
}
