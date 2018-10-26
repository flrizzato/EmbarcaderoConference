// grab our gulp packages
var gulp  = require('gulp'),
    gutil = require('gulp-util'),
    zip = require('gulp-zip'),
    runSequence = require('run-sequence'),
    path = require('path'),
    fs = require('fs'),
    cp = require('child_process'),
    pp = require('process');

var dcc = require('./gulp-delphi-utils/dcc');
var codeCoverage = require('./gulp-delphi-utils/codeCoverage');


// This will run in this order: 
// * create-folders
// * compile the main project
// * compile the tests
// * run the tests
// * coverage
// * zip 
// * Finally call the callback function 
gulp.task('build', function(callback) {
  runSequence('create-folders',
              'compile',
              'compile-tests',
              'unit-test',
              'code-coverage',
              'zip',
              callback);
});

// the default task is.....
gulp.task('default', ["create-folders"]);

// create additional folders, used by the building process
gulp.task("create-folders", function() {
  gutil.log('create-folders:started');
  if (!fs.existsSync(path.join(__dirname, 'Artifacts'))) {
    fs.mkdirSync(path.join(__dirname, 'Artifacts'));
  }
  if (!fs.existsSync(path.join(__dirname, 'Bin'))) {
    fs.mkdirSync(path.join(__dirname, 'Bin'));
  }
  if (!fs.existsSync(path.join(__dirname, 'Bin\\Coverage'))) {
    fs.mkdirSync(path.join(__dirname, 'Bin\\Coverage'));
  }
  if (!fs.existsSync(path.join(__dirname, 'Lib'))) {
    fs.mkdirSync(path.join(__dirname, 'Lib'));
  }
  return gutil.log('create-folders:ended');
});

// compile the main project
gulp.task("compile", ["create-folders"], function() {
  pp.chdir(path.join(__dirname, "src"));
  var bb = dcc("Project1.dpr", "..\\Bin", "..\\Lib");
  if (dcc.dccHasError(bb)) {
    throw Error("Task: compile");
  }
});

// compile the test project
gulp.task("compile-tests", ["compile"], function() {
  pp.chdir(path.join(__dirname, "tests"));
  var bb = dcc("Project1Tests.dpr", "..\\Bin", "..\\Lib", 
    "..\\Lib;C:\\Users\\alefr\\Documents\\GitHub\\_forks\\DUnitX",
    "-GD", "CI")
  if (dcc.dccHasError(bb)) {
    throw Error("Task: compile-tests");
  }
});

// run unit tests
gulp.task("unit-test", ["compile-tests"], function() {
  pp.chdir(path.join(__dirname, "Bin"));
  var bb = cp.spawnSync(path.join(__dirname, 'Bin\\Project1Tests.exe'));
  gutil.log(bb.output.toString());
});

// run code coverage
gulp.task("code-coverage", function() {
  var bb = codeCoverage("Project1Tests", "src", "uCalculadora.pas", __dirname);
  gutil.log(bb);
});


// zip the artifacts
gulp.task("zip", function() {
  return gulp.src('./Bin/**')
    .pipe(zip('Build.zip'))
    .pipe(gulp.dest('./Artifacts'));
});

// watch
gulp.task("watch", function() {
  gulp.watch("src/*.pas", ["compile"]);
  gulp.watch("tests/*.pas", ["unit-test"]);
});
