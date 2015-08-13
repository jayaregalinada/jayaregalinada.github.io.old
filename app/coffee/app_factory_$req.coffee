_app.factory '$req', ( $http )->

  _r = {}

  _r._paginate = ( pageNumber, url, method )->
    if angular.isObject pageNumber
      url        = pageNumber.url
      pageNumber = pageNumber.page
      method     = pageNumber.method

    $http
      url: url
      method: if method then method else 'GET'
      params:
        page: pageNumber

  _r._post = ( url, data, params, method )->
    if angular.isObject url
      url    = url.url
      data   = url.data
      params = url.params
      method = url.method

    $http
      url: url
      data: data
      params: params
      method: if method then method else 'POST'

  _r._delete = ( url, data, params )->
    if angular.isObject url
      url    = url.url
      data   = url.data
      params = url.params

    _r._post url, data, params, 'DELETE'

  _r._patch = ( url, data, params )->
    if angular.isObject url
      url    = url.url
      data   = url.data
      params = url.params

    _r._post url, data, params, 'PATCH'

  _r._put = ( url, data, params )->
    if angular.isObject url
      url    = url.url
      data   = url.data
      params = url.params

    _r.post url, data, params, 'PUT'

  _r._get = ( url, params )->
    if angular.isObject url
      url    = url.url
      params = url.params

    $http
      url: url
      params: params
      method: 'GET'

  _r
