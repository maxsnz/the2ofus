import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'
import { like, auth, photoClicked, closePhoto } from '../actions'
import Gallery from '../components/Gallery'
import Photo from '../components/Photo'
import PhotoLoader from '../components/PhotoLoader'


class App extends Component {
  render() {
    const { dispatch, data } = this.props
    return (
      <div>
        <Gallery 
          authOpened={data.authOpened}
          data={data.photos} 
          onLikeClick={ index => dispatch(like(index)) } 
          onPhotoClick={ index => dispatch(photoClicked(index)) }
          onAuthProviderClick={ (index, provider) => dispatch(auth(index, provider, dispatch)) } 
        />
        <PhotoLoader
          page={data.next_page}
          onClick={page => dispatch(nextPageClicked(page))}
        />
        <Photo 
          data={data.photos[data.openedPhoto]} 
          onCloseClick={() => dispatch(closePhoto())}
        />
      </div>
    )
  }
}

function select(state) {
  return {
    data:state.gallery
  }
}

export default connect(select)(App)