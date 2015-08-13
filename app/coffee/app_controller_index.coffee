_app.controller 'IndexController', ($scope, $state, $stateParams, $window, $log)->

  $scope.init = ->
    $log.debug 'Checking $state...', $state
    $log.debug 'Checking location...', $window.location

    return

  $scope.init()

  return
