/////////
// Less
/////////

var gulp      = require('gulp'),
    $         = require('gulp-load-plugins')(),
    gutil     = require('gulp-util'),
    concat    = require('gulp-concat'),
    rename    = require('gulp-rename'),
    less      = require('gulp-less'),
    minifycss = require('gulp-minify-css'),
    live      = require('gulp-livereload'),
    config    = require('../config');

var lessCompile = function()
{
  var src = config.src.less + 'app.less',
    outputName = config.dist.cssName;
  return gulp.src( src )
    .pipe( less().on( 'error', gutil.log ) )
    .pipe( concat( outputName ) )
    .pipe( gulp.dest( config.dist.css ) )
    .pipe( less({ compress: true }).on( 'error', gutil.log ) )
    .pipe( concat( outputName ) )
    .pipe( rename({ suffix: '.min'}) )
    .pipe( gulp.dest( config.dist.css ) );
};

module.exports = lessCompile;
