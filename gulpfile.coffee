# Gulp
gulp = require('gulp')
watch = require('gulp-watch')
scss = require('gulp-ruby-sass')

# PostCSS
postcss = require('postcss')
syntax = require('postcss-scss')

# Gulp PostCSS
process = require('gulp-postcss')
prefixer = require('gulp-autoprefixer')

# External
presass_lifesaver = require('./presass_lifesaver')

# Directories
presass_dir = 'buckle/'
sass_dir = 'buckle-sass/'
css_dir = 'dist/css/'

# Plugins
plugins = [presass_lifesaver]

#
gulp.task 'presass', ->
  return gulp.src(presass_dir + '**/*.scss')
    .pipe process(plugins, { syntax: syntax })
    .pipe gulp.dest(sass_dir)

#
gulp.task 'sass', ->
  return scss(sass_dir)
    .on 'error', (error) ->
      console.error('Error!', error.message) # Notify Sass errors
    .pipe gulp.dest(css_dir)                 # Output CSS

#
gulp.task 'default', ['presass', 'sass']

#
gulp.task 'watch', ->
  # gulp.watch(presass_dir + '**/*.scss', ['presass', 'sass'])
  gulp.watch(presass_dir + '**/*.scss', ['presass'])
