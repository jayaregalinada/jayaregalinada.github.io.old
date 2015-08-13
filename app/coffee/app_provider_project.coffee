_app.provider 'Project', ->
  host = undefined
  path = undefined
  category = undefined

  setUrl: (obj)->
    host = obj.host
    path = obj.path
    category = obj.category

    return

  setCategoryPath: (pathName)->
    category = pathName

    return

  $get: ->
    host: host
    path: path
    getCategoryUrl: ->
      host + category
    getUrl: ->
      host + path
    getHost: ->
      host
    getPath: ->
      path
    getAll: ->
      host + path
    view: (id)->
      host + path + id

