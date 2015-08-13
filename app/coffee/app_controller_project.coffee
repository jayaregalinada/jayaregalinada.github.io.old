_app.controller 'ProjectController', ($scope, $http, $window, $log, $state, $stateParams, $req, $helpers, localStorageService, $timeout, $rootScope, Project)->

  $scope.projects = []
  $scope.project = {}
  $scope.status = $helpers.getAllDefaultStatus()
  $scope.getAllTimeout = null
  $scope.getAllNextPageDelayTime = 2000
  $scope.masonryOpts =
    transitionDuration: '.4s'
    columnWidth: '.masonry-sizer'
    percentPosition: true
    itemSelector: '.masonry-brick'
    gutter: 10

  $scope.checking = ->
    $log.log 'Checking $state...', $state
    $log.log 'Checking location...', $window.location
    $scope.switches $state.current.name

    return

  $scope.mouseEnter = (evt)->
    $(evt.currentTarget).find('.description').slideDown 300, ->
      $(this).find('.description-text').animate
        opacity: 1
      , 300

      return

    return

  $scope.mouseLeave = (evt)->
    $(evt.currentTarget).find('.description').slideUp 180, ->
      $(this).find('.description-text').animate
        opacity: 0
      , 200

      return

    return

  $scope.switches = (currentState)->
    switch currentState
      when 'index'
        $scope.gettingAll()

        return
      else

        return

  $scope.pushToProjects = (data)->
    angular.forEach data, (val, key)->
      $scope.projects.push val

      return

    return

  $scope.gettingAll = ->
    $scope.projects = []
    $scope.status = $helpers.statusWhenGettingAll()
    prjct = [
      'project_page'
      'project_paginate_done'
      'project_paginate_interrupted'
    ]
    angular.forEach prjct, (v)->
      localStorageService.remove v

      return
    $timeout ->
      $scope.getAll 1
      return

    , 1500

    return

  $scope.getAll = (pageNumber)->
    url = Project.getAll()
    $rootScope.$broadcast 'projects:all',
      page: pageNumber
    $scope.status = $helpers.statusWhenGetAll()

    $req._paginate pageNumber, url
      .success (successData)->
        $log.log 'ProjectController@getAll', successData
        $rootScope.$broadcast 'projects:all:success'
        $scope.status.error = false
        localStorageService.set 'project_page', successData.success.data.current_page

        if Boolean successData.success.data.next_page_url
          if $state.is 'index'
            $scope.getAllTimeout = $timeout ->
              $scope.getAll successData.success.data.current_page + 1

              return
            , $scope.getAllNextPageDelayTime
          else
            localStorageService.set 'project_paginate_interrupted', true
        else
          $rootScope.$broadcast 'projects:all:complete'
          $scope.status.loading = false
          localStorageService.set 'project_paginate_done', true

        return
      .error (err)->
        $log.error 'ProjectController@getAll::error', err
        $rootScope.$broadcast 'projects:all:error'
        $rootScope.$broadcast 'errorOccured'
        $scope.status = $helpers.statusWhenError err.error.message

        return
      .then (thenData)->
        $scope.pushToProjects thenData.data.success.data.data
        $scope.status.loadingFirstTime = false

        return

    return


  $scope.checking()

  return
