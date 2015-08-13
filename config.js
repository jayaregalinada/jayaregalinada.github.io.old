var util = require('gulp-util');

var config = {
  production: !! util.env.production,
  appDir: 'app/',
  dist: {
    js      : 'js/',
    css     : 'css/',
    cssName : 'styles.css',
    views   : 'views/',
    fonts   : 'fonts/',
    images  : 'images/',
    vendor  : 'vendor/',
    www     : ''
  },
  src: {
    coffee : 'app/coffee/',
    less   : 'app/less/',
    views  : 'app/views/',
    images : 'app/images/',
    yaml   : 'app/yaml/'
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
