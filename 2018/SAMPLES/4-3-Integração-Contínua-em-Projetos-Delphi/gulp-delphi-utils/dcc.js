// module dcc.js

var cp = require("child_process"),
    gutil = require("gulp-util");

function dcc(projectName, exeOuputDirectory, dcuOutputDirectory, unitDirectories, mapFile, defineConditionals) {

    var params = [];
    params.push("-B");
    params.push(projectName);
    params.push("-E" + exeOuputDirectory);
    params.push("-NU" + dcuOutputDirectory);
    if (mapFile) {
        params.push(mapFile);
    }
    if (unitDirectories) {
        params.push("-U" + unitDirectories);
    }
    if (defineConditionals) {
        params.push("-D" + defineConditionals);
    }
    var bb = cp.spawnSync("dcc32", params);
    // var bb = cp.spawnSync("dcc32", [
    //     "-B", 
    //     projectName,
    //     "-E" + exeOuputDirectory, 
    //     "-NU" + dcuOutputDirectory,
    //     unitDirectories ? "-U" + unitDirectories : "", 
    //     mapFile ? "-GD" : "",
    //     defineConditionals ? "-D" + defineConditionals : ""]);
    gutil.log(bb.output.toString());
    return bb.output.toString();
}

function dccHasError(output) {
    var re = RegExp(/.*(Fatal|Error):.*/);
    var matches = re.exec(output);
    return matches;
}

/* sample
  var dcc = require('./dcc');
  dcc("Project1Tests.dpr", "..\\Bin", "..\\Lib", "..\\Lib;C:\\Users\\alefr\\Documents\\GitHub\\_forks\\DUnitX", true, "CI");
*/

module.exports = dcc;
module.exports.dccHasError = dccHasError;