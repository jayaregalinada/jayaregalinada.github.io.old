###*
 * Routes
###

window._app.config ( $stateProvider, $urlRouterProvider )->
  $path = window.location.origin + window.location.pathname
  $urlRouterProvider.otherwise '/'

  $stateProvider
    .state 'index',
      url: '/'
      controller: 'IndexController'
      views:
        'projects':
          templateUrl: $path + 'views/index.html'
          controller: 'ProjectController'

  ## PROJECTS
    .state 'project',
      abstract: true
      url: '/project'
      controller: 'ProjectController'
      template: '<ui-view class="index-projects animate" />'

    .state 'project.view',
      parent: 'project'
      url: '/:productId'
      templateUrl: $path + 'views/view.html'
      controller: ($scope, $stateParams)->
        $scope.view $stateParams.productId

        return


  return
