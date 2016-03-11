import React, { Component, PropTypes } from 'react'

var AuthPanel = React.createClass({
  render: function() {
    return  <div className="g-item__auth-container">
              <div className="g-item__auth-title">авторизируйся через соцсеть</div>
              <div className="g-item__auth-item g-item__auth-item--fb" onClick={() => this.props.onAuthProviderClick('facebook')} >fb</div>
              <div className="g-item__auth-item g-item__auth-item--in" onClick={() => this.props.onAuthProviderClick('instagram')} >in</div>
              <div className="g-item__auth-item g-item__auth-item--vk" onClick={() => this.props.onAuthProviderClick('vkontakte')} >vk</div>
            </div>
  }
});

module.exports = AuthPanel;