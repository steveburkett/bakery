import React from 'react'
import OrderTable from './OrderTable'

export default class Orders extends React.Component {
  constructor(props) {
    super(props)
    this.state = {loading: true, orders: []}
  }

  componentDidMount() {
    fetch('/api/orders.json')
      .then((response) => response.json())
      .then((json) => this.setState({orders: json, loading: false}))
      .catch((e) => console.log(e))
  }

  render() {
    const { loading } = this.state;
    if(loading) { return <div className='loading'></div>; }

    return (
      <OrderTable orders={this.state.orders} />
    )
  }
}
