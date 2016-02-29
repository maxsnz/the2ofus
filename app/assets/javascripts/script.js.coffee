#=  react
#=  react_ujs
#=  components

#= require jquery2
#= require jquery_ujs
#= require jquery-ui
#= require EventEmitter.min
#= require lodash.compat.min
#= require velocity.min
#= require spin.min
#= require authorize
#= require userinterface

preload = () ->
  $('.preload').each ->
    $(@).get(0).load()

$ ->
  preload()
  window.ee = new EventEmitter()
  Navigation.init({currentScreen:'finish'})
  # Navigation.openPopup('result')
  Player.init()
  Testing.init()
  Rating.init()
  # $('.fullscreen-bg video').bind 'ended', ->
  #   $(@).play()
  #   console.log 'ended'
  

  spin_opts = {lines: 12, length: 6, width: 3, radius: 8, corners: 0.9, rotate: 0, color: '#ffffff', speed: 1, trail: 49, shadow: false, hwaccel: false, className: 'spinner', zIndex: 2e9, top: '50%', left: '50%'}
  $('body>.loader, .result-player-loader, .auth-player-loader, .popup_test>.loader').each ->
    loader = new Spinner(spin_opts).spin $(@)[0]
  $('body>.loader').hide() # TODO
  return


