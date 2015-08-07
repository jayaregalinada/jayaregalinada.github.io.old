///////////
// Coffee
///////////

var gulp     = require('gulp'),
    $        = require('gulp-load-plugins')(),
    coffee   = require('gulp-coffee'),
    gutil    = require('gulp-util'),
    concat   = require('gulp-concat'),
    rename   = require('gulp-rename'),
    uglify   = require('gulp-uglify')
    config   = require('../config');

var _coffee = function( scripts, outputName )
{
  return gulp.src( scripts )
    .pipe( coffee({ bare: true }).on( 'error', gutil.log ) )
    .on( 'end', function(){
      gutil.log( 'Compiled coffeescripts' )
    })
    .pipe( concat( outputName ) )
    .pipe( gulp.dest( config.dist.js ) )
    .on( 'end', function(){
      gutil.log( 'All ' + gutil.colors.yellow( 'unminified scripts' ) + ' at dist and compiled' )
    })
    .pipe( uglify({ compress: true }) )
    .pipe( rename({ suffix: '.min'}) )
    .pipe( gulp.dest( config.dist.js ) )
    .on( 'end', function(){
      gutil.log( 'All ' + gutil.colors.green( 'minified scripts' ) + ' at dist and compiled' )
    });
};

module.exports = _coffee;
