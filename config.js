var util = require('gulp-util');

var config = {
    production: !! util.env.production,
    appDir: 'app/',
    dist: {
        js      : 'public/js/',
        css     : 'public/css/',
        cssName : 'styles.css',
        views   : 'public/views/',
        fonts   : 'public/fonts/',
        images  : 'public/images/',
        vendor  : 'public/vendor/',
        www     : 'public/'
    },
    src: {
        coffee : 'app/coffee/',
        less   : 'app/less/',
        views  : 'app/views/',
        images : 'app/images/'
    },
    temp: '.tmp/',
    bowerDir: 'vendor/bower_components/',
    serverPort: 8080,
    liveReloadPort: 35729,
    imageminOptions: {
        progressive: true,
        optimizationLevel: 5,
        interlaced: true
    }
};

module.exports = config;
