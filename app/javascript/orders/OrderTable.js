import React from 'react'
import moment from 'moment'

export default class OrderTable extends React.Component {
  constructor(props) {
    super(props)
    this.state = {}
  }

  orderStatus(fulfilled) {
    return fulfilled ? 'Fulfilled' : 'In progress'
  }

  formatDate(dateString) {
    return moment(dateString).format('MMM Do YYYY')
  }

  renderRow = (order) => {
    return (
      <tr>
        <td>{order.id}</td>
        <td>{this.formatDate(order.created_at)}</td>
        <td>{this.formatDate(order.pick_up_at)}</td>
        <td>{order.customer_name}</td>
        <td>{order.item}</td>
        <td>{order.quantity}</td>
        <td>{this.orderStatus(order.fulfilled)}</td>
        <td></td>
      </tr>
    )
  }

  render() {
    return (
      <table className="orders-table">
        <tbody>
          <tr>
            <th>Order #</th>
            <th>Ordered at</th>
            <th>Pick up at</th>
            <th>Customer Name</th>
            <th>Item</th>
            <th>Qty</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          {this.props.orders.map(o => this.renderRow(o))}
        </tbody>
      </table>
    )
  }
}
