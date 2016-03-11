#= require jquery2
#= require auth
#= jquery_ujs
#= jquery-ui
#= react_ujs
require('gallery/index')




#= EventEmitter.min
#= lodash.compat.min
#= velocity.min
#= spin.min

# preload = () ->
#   $('.preload').each ->
#     $(@).get(0).load()

# $ ->
#   preload()
#   window.ee = new EventEmitter()
#   Navigation.init({currentScreen:'finish'})
#   Player.init()
  

#   spin_opts = {lines: 12, length: 6, width: 3, radius: 8, corners: 0.9, rotate: 0, color: '#ffffff', speed: 1, trail: 49, shadow: false, hwaccel: false, className: 'spinner', zIndex: 2e9, top: '50%', left: '50%'}
#   $('.loader').each ->
#     loader = new Spinner(spin_opts).spin $(@)[0]


# class App
#   @authorized: false

#   $ ->
#     console.log 'App.authorized', App.authorized


# window.App = App