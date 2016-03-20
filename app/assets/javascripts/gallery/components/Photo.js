import React, { Component, PropTypes } from 'react'
import { share } from '../helpers'
// https://github.com/dogfessional/react-swipeable

var Photo = React.createClass({

  render: function() {
    if (!this.props.data) {
      enableScroll();
      return null;
    }
    disableScroll();

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
          <div className="p-shareitems">
            <div className="p-shareitem p-fb" onClick={() => {share('fb')}} />
            <div className="p-shareitem p-tw" onClick={() => {share('tw')}} />
            <div className="p-shareitem p-vk" onClick={() => {share('vk')}} />
          </div>
        </div>
      </div>
      <div className="p-cross" onClick={() => {this.props.onCloseClick()}} />
      </div>
    </div>
  }
});

var keys = {37: 1, 38: 1, 39: 1, 40: 1};

function preventDefault(e) {
  e = e || window.event;
  if (e.preventDefault)
      e.preventDefault();
  e.returnValue = false;  
}

function preventDefaultForScrollKeys(e) {
    if (keys[e.keyCode]) {
        preventDefault(e);
        return false;
    }
}

function disableScroll() {
  if (window.addEventListener) // older FF
      window.addEventListener('DOMMouseScroll', preventDefault, false);
  window.onwheel = preventDefault; // modern standard
  window.onmousewheel = document.onmousewheel = preventDefault; // older browsers, IE
  window.ontouchmove  = preventDefault; // mobile
  document.onkeydown  = preventDefaultForScrollKeys;
}

function enableScroll() {
    if (window.removeEventListener)
        window.removeEventListener('DOMMouseScroll', preventDefault, false);
    window.onmousewheel = document.onmousewheel = null; 
    window.onwheel = null; 
    window.ontouchmove = null;  
    document.onkeydown = null;  
}



module.exports = Photo;