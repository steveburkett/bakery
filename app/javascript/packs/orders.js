import React from 'react'
import ReactDOM from 'react-dom'
import Orders from '../orders/Orders'
import 'whatwg-fetch'

document.addEventListener('turbolinks:load', () => {
  const element = document.querySelector('[data-order-table]')
  if (!element) return

  ReactDOM.render(
    <Orders />,
    element
  )
})

document.addEventListener('turbolinks:before-render', () => {
  const element = document.querySelector('[data-order-table]')
  if (element) ReactDOM.unmountComponentAtNode(element)
})
