var cp = require("child_process"),
    gutil = require("gulp-util"),
    path = require('path');

function codeCoverage(applicationName, sourceDirectory, sourceUnit, rootDirectory) {
    var bb = cp.spawnSync(path.join(rootDirectory, 'coverage\\CodeCoverage.exe'), [
        "-e",  path.join(rootDirectory, "Bin", applicationName + ".exe"), 
        "-m",  path.join(rootDirectory, "Bin", applicationName + ".map"),
        "-sd", path.join(rootDirectory, sourceDirectory),
        "-u", sourceUnit,
        "-html", "-emma", "-xml", 
        "-od", path.join(rootDirectory, "Bin", "Coverage")   
        ]);
    gutil.log(bb.output.toString());    
    return bb.output.toString();
}
// function codeCoverage(applicationName, sourceDirectory, sourceUnit) {
//     var bb = cp.spawnSync(path.join(__dirname, 'coverage\\CodeCoverage.exe'), [
//         "-e",  path.join(__dirname, "Bin", applicationName + ".exe"), 
//         "-m",  path.join(__dirname, "Bin", applicationName + ".map"),
//         "-sd", path.join(__dirname, sourceDirectory),
//         "-u", sourceUnit,
//         "-html", "-emma", "-xml", 
//         "-od", path.join(__dirname, "Bin", "Coverage")   
//         ]);
//     gutil.log(bb.output.toString());    
//     return bb.output.toString();
// }

/*
  var codeCoverage = require("./codeCoverage");
  codeCoverage("Project1Tests", "src", "uCalculadora.pas");
*/

module.exports = codeCoverage;