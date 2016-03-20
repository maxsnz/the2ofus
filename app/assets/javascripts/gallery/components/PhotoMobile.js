import React, { Component, PropTypes } from 'react'
// https://github.com/dogfessional/react-swipeable
var Swipeable = require('react-swipeable')
import { share } from '../helpers'

var PhotoMobile = React.createClass({

  render: function() {
    if (!this.props.data) {
      return null;
    }
    var offset_top = document.body.scrollTop;
     
    return <div>
    <div className="p-blacker" onClick={() => {this.props.onCloseClick()}} />
    <Swipeable onSwipedLeft={() => {this.props.onCloseClick()}} onSwipedRight={() => {this.props.onCloseClick()}}>
      <div className="p swipe-container" style={{top: offset_top}}>
      <img className="p-image_mobile" src={this.props.data.src} />
      <div className="p-content">
        <div className="p-username">{this.props.data.username}</div>
        <div className="p-body">{this.props.data.body}</div>
        <div className="p-line"></div>
        <div className="p-rating">{this.props.data.rating}</div>
        <div className="p-share">
          Поделись фото
          <div className="p-shareitems">
            <div className="p-shareitem p-fb" onClick={() => {share('fb')}} />
            <div className="p-shareitem p-tw" onClick={() => {share('tw')}} />
            <div className="p-shareitem p-vk" onClick={() => {share('vk')}} />
          </div>
        </div>
      </div>
      <div className="p-cross" onClick={() => {this.props.onCloseClick()}} />
      </div>
    </Swipeable>
    </div>
    
  }
});




module.exports = PhotoMobile;