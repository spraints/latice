import React from 'react'

const Cell = (props) => (<span>({props.col},{props.row})</span>)
const Row = (props) => (<div>{props.cells.map(cell => <Cell key={cell.col} row={props.row} {...cell} />)}</div>)

export default (props) => {
  const board = props.game.board
  return (
    <div>
      {board.map(row => <Row key={row.row} {...row} />)}
    </div>
  )
}
