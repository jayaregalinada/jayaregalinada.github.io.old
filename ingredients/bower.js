///////////
// Bower
///////////

var gulp     = require('gulp'),
    config   = require('../config');

var bower = function( directory, newDirectoryName )
{
  newDirectory = ( newDirectoryName ) ? newDirectoryName : directory;

  return gulp.src( config.bowerDir + directory + '**/**', { base: config.bowerDir + directory } )
    .pipe( gulp.dest( config.dist.vendor + newDirectory ) );
};

module.exports = bower;
