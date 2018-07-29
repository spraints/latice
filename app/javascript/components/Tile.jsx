import React from 'react'
import classNames from 'classnames'

// bird gecko turtle feather flower dolphin
// yellow navy magenta red green teal

const SHAPES = {
  bird: 'A',
  gecko: 'B',
  turtle: 'C',
  feather: 'D',
  flower: 'E',
  dolphin: 'F',
}

const WIND = '💨'

export default class Tile extends React.Component {
  render() {
    const classes = classNames('tile', this.props.identifier, this.props.color, this.props.shape)
    const content = this.props.is_wind ? WIND : `${SHAPES[this.props.shape]}`
    return <div className={classes} data-id={this.props.id}>{content}</div>
  }
}
