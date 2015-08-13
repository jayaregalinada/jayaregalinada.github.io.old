_app.factory '$helpers', ($rootScope)->

  _h = {}

  _h.getAllDefaultStatus = ->
    loading: false
    error: false
    errorMessage: null
    loadingFirstTime: false

  _h.getAllDefaultTimeout = ->
    gettingAll: null
    nextPage: 3000

  _h.statusWhenGettingAll = ->
    loadingFirstTime: true
    error: false

  _h.statusWhenGetAll = ->
    loading: true
    error: false

  _h.statusWhenSuccess = ->
    error: false

  _h.statusWhenNoMoreNextPage = ->
    loading: false

  _h.statusWhenError = (errorMessage)->
    error: true
    loading: false
    errorMessage: errorMessage

  _h.statusWhenComplete = ->
    loadingFirstTime: false

  _h
