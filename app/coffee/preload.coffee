###*
 * Application module
###
window._app = angular.module 'App', [
  'ui.bootstrap'
  'ngAnimate'
  'ui.router'
  'textAngular'
  'chieffancypants.loadingBar'
  'ui-notification'
  'uiGmapgoogle-maps'
]

###*
 * Application Configuration
###
window._app.config ( $interpolateProvider, $httpProvider, $animateProvider, uiGmapGoogleMapApiProvider )->
  'use strict'

  $interpolateProvider.startSymbol '{#'
  $interpolateProvider.endSymbol '#}'

  $httpProvider.defaults.headers.common[ "X-Requested-With" ] = "XMLHttpRequest"

  $animateProvider.classNameFilter /carousel|animate/

  uiGmapGoogleMapApiProvider.configure
      v: '3.17'

  return

window._app.run ( $rootScope, $state, $stateParams, $window, $templateCache, $http, $interval, $log )->
  'use strict'

  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams
  $rootScope.appData = {}

  $rootScope.getTheData = ->
    $http.get '/data.json'
    .success ( successData )->
        $rootScope.appData = successData

        return
    .error ( errorData )->
        Notification.error
            message: 'Something went wrong on getting the data'
            title: 'Oops!'
        $log.error errorData

        return

    return


  $rootScope.$on 'cfpLoadingBar:loading', ( loading )->

    return

  $rootScope.$on 'cfpLoadingBar:started', ( started )->

    return

  $rootScope.$on 'cfpLoadingBar:completed', ( completed )->

    return

  return


backToTop = ->
  config =
    offset: ( $(window).height() / 2 )
    element: $('#backToTop')
    duration: 700

  $(window).scroll ->
    if $(this).scrollTop() > config.offset
      config.element.fadeIn()
    else
      config.element.fadeOut()

  config.element.on 'click', (event)->
    event.preventDefault()
    $('body, html').animate
      scrollTop: 0
    , config.duration

    return

  return


###*
 * Initialize angular application when document is ready
 *
 * @return {void}
###
angular.element( document ).ready ->

  angular.bootstrap( document, [ 'App' ] )

  return
