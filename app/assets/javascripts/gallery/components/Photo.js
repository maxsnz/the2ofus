import React, { Component, PropTypes } from 'react'

var Photo = React.createClass({
  render: function() {
    if (!this.props.data) {
      return null;
    }
    return <div className="p-wrapper">
      <div className="p-blacker" onClick={() => {this.props.onCloseClick()}} />
      <div className="p">
        <div 
          className="p-image" 
          style={{backgroundImage: 'url('+this.props.data.src+')'}}
        />
        <div className="p-content">
          <div className="p-username">{this.props.data.username}</div>
          <div className="p-body">{this.props.data.body}</div>
          <div className="p-line"></div>
          <div className="p-rating">{this.props.data.rating}</div>
          <div className="p-share">
            Поделись фото
            <div className="p-shareitem p-fb" />
            <div className="p-shareitem p-tw" />
            <div className="p-shareitem p-vk" />
          </div>
        </div>
        <div className="p-cross" onClick={() => {this.props.onCloseClick()}} />
      </div>
    </div>
  }
});



module.exports = Photo;