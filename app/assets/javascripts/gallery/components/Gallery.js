import React, { Component, PropTypes } from 'react'
import AuthPanel from '../components/AuthPanel'

var Gallery = React.createClass({
  render: function() {
    if (!this.props.data) {
      return null;
    }
    return <div className="g">
      {this.props.data.map((item, index) =>
        <GalleryItem 
          key={index} 
          data={item} 
          onLikeClick={() => this.props.onLikeClick(item.id)} 
          onAuthProviderClick={(provider) => this.props.onAuthProviderClick(item.id, provider)} 
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
      <div className="g-item__image">
        <img width="274" src={this.props.data.src} />
      </div>
      <div className="g-item__auth-position">
        <div className={'g-item__auth ' + (this.props.data.authOpened ? 'g-item__auth--opened' : '')}>
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