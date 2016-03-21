import React, { Component, PropTypes } from 'react'

var PhotoLoader = React.createClass({

  render: function() {
    if (!this.props.page) {
      return null;
    }
    return <div className="loader-container">
      <div 
        className={"loader "+(this.props.isLoading? ' loader-active' : '')} 
        onClick={() => {this.props.onClick(this.props.page)}}
        >
        <div className="loader-arrows " />
      </div>
    </div>
  }
});


module.exports = PhotoLoader;