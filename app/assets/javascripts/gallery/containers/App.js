import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'
import { like, auth, photoClicked, closePhoto, nextPageClicked } from '../actions'
import Gallery from '../components/Gallery'
import Photo from '../components/Photo'
import PhotoMobile from '../components/PhotoMobile'
import PhotoLoader from '../components/PhotoLoader'
import { hasClass } from '../helpers'

var mobile = hasClass(document.body, 'mobile');


class App extends Component {
  render() {
    const { dispatch, data } = this.props
    var photo;
    if (mobile) {
      photo = <PhotoMobile data={data.photos[data.openedPhoto]} onCloseClick={() => dispatch(closePhoto())} />;
    } else {
      photo = <Photo data={data.photos[data.openedPhoto]} onCloseClick={() => dispatch(closePhoto())} />;
    }
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
          loading={data.isLoading}
          page={data.next_page}
          onClick={page => dispatch(nextPageClicked(page))}
        />
        {photo}
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