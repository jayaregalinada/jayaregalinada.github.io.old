//////////
// HTML
//////////

var gulp     = require('gulp'),
    config   = require('../config');

var html = function()
{
  return gulp.src( config.appDir + '**/**.html', { base: config.appDir } )
    .pipe( gulp.dest( config.dist.www ) );
};

module.exports = html;
