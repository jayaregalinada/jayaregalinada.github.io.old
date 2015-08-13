//
// Filename:    /gulpfile.js
// Version:     0.1
//

/////////////
// Modules
/////////////
var XKY3       = require('require-dir')('./ingredients'),
    gulp       = require('gulp'),
    gutil      = require('gulp-util'),
    concat     = require('gulp-concat'),
    coffee     = require('gulp-coffee'),
    minifycss  = require('gulp-minify-css'),
    less       = require('gulp-less'),
    rename     = require('gulp-rename'),
    banner     = require('gulp-header'),
    concat     = require('gulp-concat'),
    uglify     = require('gulp-uglify'),
    live       = require('gulp-livereload'),
    imagemin   = require('gulp-imagemin'),
    fs         = require('fs'),
    browser    = require('browser-sync'),
    tinyLr     = require('tiny-lr'),
    express    = require('express'),
    bodyParser = require('body-parser'),
    cache      = require('gulp-cache'),
    config     = require('./config'),
    yaml       = require('gulp-yaml'),
    pkg        = require('./package.json'),
    server     = tinyLr();

////////////
// Tasks
////////////
gulp.task('coffee', function()
{
  XKY3.coffee([
    config.src.coffee + 'preload.coffee',
    config.src.coffee + 'routes.coffee',
    config.src.coffee + 'app_*.coffee'
  ], 'scripts.js');
});

gulp.task('vendor', function()
{
  gutil.log('Running [vendor]...');
  XKY3.bower( 'bootstrap/dist/', 'bootstrap' );
  XKY3.bower( 'jquery/dist/', 'jquery' );
  XKY3.bower( 'angular/' );
  XKY3.bower( 'font-awesome/' );
  // XKY3.bower( 'animate.css/' );
  XKY3.scripts([
    config.bowerDir + 'lodash/dist/lodash.min.js',
    config.bowerDir + 'angular-animate/angular-animate.js',
    // config.bowerDir + 'nprogress/nprogress.js',
    config.bowerDir + 'angular-ui-router/release/angular-ui-router.js',
    config.bowerDir + 'angular-aria/angular-aria.js',
    // config.bowerDir + 'angular-bootstrap/ui-bootstrap.js',
    config.bowerDir + 'angular-bootstrap/ui-bootstrap-tpls.js',
    config.bowerDir + 'angular-touch/angular-touch.js',
    config.bowerDir + 'angular-loading-bar/build/loading-bar.js',
    // config.bowerDir + 'angular-bootstrap-lightbox/dist/angular-bootstrap-lightbox.js',
    config.bowerDir + 'angular-local-storage/dist/angular-local-storage.js',
    // config.bowerDir + 'skrollr/dist/skrollr.min.js',
    // config.bowerDir + 'angular-ui-notification/dist/angular-ui-notification.min.js',
    // config.bowerDir + 'textAngular/dist/textAngular-rangy.min.js',
    // config.bowerDir + 'textAngular/dist/textAngular-sanitize.min.js',
    // config.bowerDir + 'textAngular/dist/textAngular.min.js',
    config.bowerDir + 'angular-sanitize/angular-sanitize.js',
    // config.bowerDir + 'angular-google-maps/dist/angular-google-maps.min.js',
    // config.bowerDir + 'jquery.transit/jquery.transit.js',
    // config.bowerDir + 'parallax.js/parallax.js',
    config.bowerDir + 'imagesloaded/imagesloaded.pkgd.js',
    config.bowerDir + 'masonry/dist/masonry.pkgd.js',
    config.bowerDir + 'angular-masonry/angular-masonry.js',
    config.bowerDir + 'angular-messages/angular-messages.js'
  ], 'vendor.js');

  gutil.log('DONE [vendor]...');
});

gulp.task('less', function()
{
  XKY3.less();
});

gulp.task('jade', function()
{
  XKY3.jade();
});

gulp.task('html', function()
{
  XKY3.html();
});

gulp.task('watch', function()
{
  live.listen();
  gulp.watch( config.src.less + '**/*.less', [ 'less' ] ).on( 'change', live.changed );
  gulp.watch( config.src.coffee + '**/*.coffee', [ 'coffee' ] ).on( 'change', live.changed );
  gulp.watch( [ config.src.views + '**/*.jade', config.appDir + '*.jade', config.appDir + 'partials/*.jade' ], [ 'jade' ] ).on( 'change', live.changed );
  gulp.watch( config.appDir + '**/*.html', [ 'html' ] ).on( 'change', live.changed );
  gulp.watch( config.src.images + '**/*.(jpg|png|bmp|gif|jpeg)', [ 'images' ] ).on( 'change', live.changed );
  gulp.watch( config.src.yaml + '*.yml', [ 'yaml' ] ).on( 'change', live.changed );
  gulp.watch([
    config.src.less + '**/*.less',
    config.src.coffee + '**/*.coffee',
    config.src.views + '**/*.jade',
    config.src.yaml + '*.yml',
    config.appDir + '*.jade',
    config.appDir + '**/*.html',
    config.appDir + '**/**'
  ], function(e){
    live.changed( e.path );
  });
});

gulp.task('browser-sync', function()
{
  browser({
    server: {
      baseDir: "/"
    }
  });
});

gulp.task('serve', [ 'watch' ], function()
{
  app = express();
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use( bodyParser.json() );
  app.use( express.static( config.dist.www ) );
  app.listen( config.serverPort );
  gutil.log( 'Server is on port ' + gutil.colors.red( config.serverPort ) );
});

gulp.task('images', function()
{
  return gulp.src( config.src.images + '**/*.+(jpg|png|bmp|gif|jpeg)' )
  .pipe( cache( imagemin( config.imageminOptions ).on( 'end', function(){
    gutil.log( 'Images compressed!' )
  })))
  .pipe( gulp.dest( config.dist.images ) )
  .on( 'end', function(){
    gutil.log( 'Images are in dist! Congrats!' )
  });
});

gulp.task('clear:cache', function( done )
{
  return cache.clearAll( done );
});

gulp.task('yaml', function()
{
  return gulp.src(config.src.yaml + '*.yml')
  .pipe(yaml({
    space: 2,
    safe: true
  }))
  .pipe( gulp.dest( config.dist.www ) )
  .on('end', function(){
    gutil.log('Yaml Data in dist!')
  });
});

gulp.task('build', [ 'images', 'coffee', 'less', 'jade', 'vendor', 'yaml' ] );
gulp.task('dev', [ 'build', 'watch' ]);
gulp.task('default', [ 'build', 'serve' ]);
