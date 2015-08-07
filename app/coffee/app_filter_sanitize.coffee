###*
 * http://stackoverflow.com/questions/9381926/insert-html-into-view-using-angularjs
###
_app.filter 'sanitize', ( $sce )->
    return ( htmlCode )->
        $sce.trustAsHtml htmlCode


