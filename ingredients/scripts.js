/////////////
// Scripts
/////////////

var gulp     = require('gulp'),
    $        = require('gulp-load-plugins')(),
    gutil    = require('gulp-util'),
    concat   = require('gulp-concat'),
    rename   = require('gulp-rename'),
    uglify   = require('gulp-uglify')
    config   = require('../config');

var scriptsCompile = function( scripts, outputName )
{
  return gulp.src( scripts )
    .pipe( concat( outputName ) )
    .pipe( gulp.dest( config.dist.js ) )
    .on( 'end', function(){
      gutil.log( 'All unminified scripts at dist' )
    })
    .pipe( uglify({ compress: true }) )
    .on( 'end', function(){
      gutil.log( gutil.colors.bgGreen( 'Scripts uglified' ) )
    })
    .pipe( rename({ suffix: '.min'}) )
    .pipe( gulp.dest( config.dist.js ) )
    .on( 'end', function(){
      gutil.log( 'All minified scripts at dist' )
    });
};

module.exports = scriptsCompile;
