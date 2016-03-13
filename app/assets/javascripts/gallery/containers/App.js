import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'
import { like, auth } from '../actions'
import Gallery from '../components/Gallery'


class App extends Component {
  render() {
    const { dispatch, data } = this.props
    return (
      <div>
        <Gallery 
          data={data} 
          onLikeClick={ index => dispatch(like(index)) } 
          onAuthProviderClick={ (index, provider) => dispatch(auth(index, provider, dispatch)) } 
        />
      </div>
    )
  }
}

function select(state) {
  return {
    data:state.photos.items
  }
}

export default connect(select)(App)