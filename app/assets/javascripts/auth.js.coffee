class Auth
  @authorized = false
  onCallbackPopup = undefined
  auth_params = {}

  @callbackPopupAuth = (status, options) ->
    data = JSON.parse(options)
    # console.log 'callbackPopupAuth', status, data
    onCallbackPopup(status, data)

  @run = (index, provider) ->
    # console.log 'auth started!', provider
    href = '/auth/' + provider + ''
    popupWin = window.open(href, 'Authorization', 'location,width=500,height=500,top=0')
    popupWin.focus()
    return new Promise((resolve, reject) ->
      onCallbackPopup = (status, data) ->
        if (status)
          Auth.authorized = true
          auth_params.token = data.token
          auth_params.authenticity_token = $('meta[name="csrf-token"]').attr('content')
          # auth_params.access_token = data.account.authentications[0].access_token if data.account.authentications[0].access_token
          # auth_params.uid = data.account.authentications[0].uid if data.account.authentications[0].uid
          resolve(data)
        else
          reject(data)
      )

  @getParams = (key) ->
    return auth_params[key]

window.Auth = Auth


  # validateEmail = (email) ->
  #   re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  #   re.test email

  # setState = (state) ->
  #   $('.auth-state').hide()
  #   $('.auth-state-'+state).show()
  #   if state is 'finish'
  #     $('.auth-layer').remove()
  #     ee.emitEvent('auth_AuthorizedSuccess')

  # authEmailController = (action, email, $button) ->
  #   if validateEmail(email)
  #     $button.removeClass 'disabled'
  #   else
  #     $button.addClass 'disabled'
  #   if action is 'submit'
  #     setState('loading')
  #     # TODO вернуть перед деплоем
  #     $.post '/'+widget.prefix+'/api/user',
  #     # $.post '/theartistisyou/api/user',
  #       email: email
  #       token: auth_params.token
  #       authenticity_token: auth_params.authenticity_token
  #       _method: 'put'
  #     .done (data) ->
  #       auth_params.email = email
  #       setState('finish')
  #     .fail (data) ->
  #       setState 'email'
  #       data = JSON.parse(data.responseText)
  #       $('.auth-email-message').html data.errors.email[0]


  # authProviderController = (params, targetElement) ->
  #   ee.emitEvent('auth_AuthorizedPending')
  #   # TODO вернуть
  #   href = '/'+widget.prefix+'/auth/' + params.provider + ''
  #   # href = '/theartistisyou/auth/' + params.provider + ''
  #   if $('body').hasClass('mobile') || $('body').hasClass('tablet')
  #     if params.cloudimages
  #       href += '?instagram=true'
  #     window.location = href
  #   else
  #     popupWin = window.open(href, 'Authorization', 'location,width=500,height=500,top=0')
  #     popupWin.focus()
  #     if params.cloudimages
  #       ee.addListener 'auth_AuthorizedParamsSetted', ->
  #         InstagramUploader.init(auth_params)


  # authErrorController = (data) ->
  #   console.log 'auth error', data

  # authCheckingController = (data) ->
  #   auth_params.token = data.token
  #   auth_params.authenticity_token = $('meta[name="csrf-token"]').attr('content')
  #   auth_params.access_token = data.user.authentications[0].access_token if data.user.authentications[0].access_token
  #   auth_params.uid = data.user.authentications[0].uid if data.user.authentications[0].uid
  #   if data.instagram
  #     ee.addListener 'auth_AuthorizedParamsSetted', ->
  #       InstagramUploader.init(auth_params)
  #   ee.emitEvent('auth_AuthorizedParamsSetted')
  #   if data.user.email
  #     auth_params.email = data.user.email
  #     setState('finish')
  #   else
  #     setState('email')


  # init = () ->
  #   spin_opts = {lines: 12, length: 6, width: 3, radius: 8, corners: 0.9, rotate: 0, color: '#ffffff', speed: 1, trail: 49, shadow: false, hwaccel: false, className: 'spinner', zIndex: 2e9, top: '50%', left: '50%'}
  #   loader = new Spinner(spin_opts).spin $('.auth-loading')[0]
  #   ee.addListener('ui_AuthProviderCtrl', authProviderController)
  #   ee.addListener('auth_AuthorizedError', authErrorController)
  #   ee.addListener('auth_Authorized', authCheckingController)
  #   ee.addListener('auth_EmailCtrl', authEmailController)
  #   ee.addListener 'auth_AuthorizedPending', ->
  #     setState('loading')

  #   d = $.deparam(window.location.search.slice(1))

  #   if d.data
  #     widget.loaded.add ->
  #       widget.expand()
  #       authCheckingController(JSON.parse(d.data))
  #   else
  #     setState('start')



