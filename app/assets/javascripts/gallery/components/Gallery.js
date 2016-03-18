import React, { Component, PropTypes } from 'react'
import AuthPanel from '../components/AuthPanel'

var Gallery = React.createClass({
  render: function() {
    if (!this.props.data) {
      return null;
    }
    return <div className="g">
      {Object.keys(this.props.data).map(id => 
      // {this.props.data.map((item, id) =>
        <GalleryItem 
          key={id} 
          data={this.props.data[id]} 
          authOpened={(parseInt(this.props.authOpened)==id)}
          onLikeClick={() => this.props.onLikeClick(id)} 
          onPhotoClick={() => this.props.onPhotoClick(id)} 
          onAuthProviderClick={(provider) => this.props.onAuthProviderClick(id, provider)} 
        />
      )}
    </div>
  }
});

var GalleryItem = React.createClass({
  render: function() {
    return <div className="g-item">
      <div className="g-item__top">
        <div 
          className={'g-item__like ' + (this.props.data.liked ? 'g-item__like--liked' : '')} 
          onClick={() => this.props.onLikeClick()} 
        />
        <div className="g-item__username">{this.props.data.username}</div>
      </div> 
      <div className="g-item__image" onClick={() => this.props.onPhotoClick()}>
        <img  src={this.props.data.src} />
      </div>
      <div className="g-item__auth-position">
        <div className={'g-item__auth ' + (this.props.authOpened ? 'g-item__auth--opened' : '')}>
          <AuthPanel 
            index={this.props.key} 
            onAuthProviderClick={(provider) => this.props.onAuthProviderClick(provider)}  
          />
        </div>
      </div>
    </div>
  }
});

module.exports = Gallery;