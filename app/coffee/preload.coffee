###*
 * Application module
###
window._app = angular.module 'App', [
  'ui.bootstrap'
  'ngAnimate'
  'ui.router'
  'angular-loading-bar'
  'wu.masonry'
  'LocalStorageModule'
  'ngSanitize'
  ]

###*
 * Application Configuration
###
window._app.config ($interpolateProvider, $httpProvider, $animateProvider, cfpLoadingBarProvider, ProjectProvider)->
  'use strict'

  $interpolateProvider.startSymbol '{#'
  $interpolateProvider.endSymbol '#}'

  $httpProvider.defaults.headers.common[ "X-Requested-With" ] = "XMLHttpRequest"
  $httpProvider.defaults.useXDomain = true

  # $animateProvider.classNameFilter /carousel|animate/

  cfpLoadingBarProvider.includeSpinner = false

  ProjectProvider.setUrl
    host: 'http://xky3.ml/'
    path: 'project'
    category: 'category'

  return

window._app.run ($rootScope, $state, $stateParams, $window, $log, $http, Project)->
  'use strict'

  $rootScope.$state = $state
  $rootScope.$stateParams = $stateParams

  $http.get Project.getCategoryUrl()
  .success (s)->
    $rootScope.$categories = s.success.data
    return
  .error (e)->
    $rootScope.$categoriesError = true
    return

  $rootScope.$on 'errorOccured', ->
    $('body').addClass 'error-occured'

    return

  $rootScope.$on 'cfpLoadingBar:loading', ( loading )->
    $log.debug 'cfpLoadingBar:loading', loading
    $('body').removeClass 'error-occured'

    return

  $rootScope.$on 'cfpLoadingBar:started', ( started )->
    $log.debug 'cfpLoadingBar:started', started
    $('body').removeClass 'error-occured'

    return

  $rootScope.$on 'cfpLoadingBar:completed', ( completed )->
    $log.debug 'cfpLoadingBar:completed', completed

    $window._glitch.glitching()

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
angular.element(document).ready ->

  angular.bootstrap(document, ['App'])

  window._glitch = new GlitchFX 'glitch_canvas', '/images/logo.png'

  return
