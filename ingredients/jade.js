//////////
// Jade
//////////


var gulp     = require('gulp'),
    $        = require('gulp-load-plugins')(),
    gutil    = require('gulp-util'),
    jade     = require('gulp-jade'),
    config   = require('../config');

var jadeCompile = function( options )
{
  options = ( options ) ? options : { pretty: true };
  gulp.src( config.src.views + '**/*.jade' )
    .pipe( jade( options ).on( 'error', gutil.log ) )
    .pipe( gulp.dest( config.dist.views ) );
  gulp.src( config.appDir + '*.jade' )
    .pipe( jade( options ).on( 'error', gutil.log ) )
    .pipe( gulp.dest( config.dist.www ) );
};

module.exports = jadeCompile;
