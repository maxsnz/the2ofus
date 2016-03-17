import React from 'react'
import { render } from 'react-dom'
import thunkMiddleware from 'redux-thunk';
import { createStore, applyMiddleware } from 'redux';
import { Provider } from 'react-redux'
import App from './containers/App'
import rootReducer from './reducers'
import { fetchAllItemsFromServer } from './actions'

// Store

const store = createStore(
  rootReducer,
  applyMiddleware(thunkMiddleware)
);

let rootElement = document.getElementById('root')


store.dispatch(fetchAllItemsFromServer())//.then(() =>
  // console.log(store.getState())
//);

render(
  <Provider store={store}>
    <App />
  </Provider>,
  rootElement
)