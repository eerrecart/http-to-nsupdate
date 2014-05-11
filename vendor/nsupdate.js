
var NSUPDATE = "nsupdate";
var KEY_ALGORITHM = "hmac-md5";

var os = require('os');
var fs = require('fs');
var child_process = require('child_process');

exports.run = function(key, commands, callback) {
  var nsupdate = child_process.spawn(NSUPDATE, ['-y', key]);
  
  var errors = '';
  
  nsupdate.stderr.on('data', function(data) {
    console.log("NSUPDATE (stderr): " + data);
    errors += data;
  });
  nsupdate.stdout.on('data', function(data) {
    console.log("NSUPDATE (stdout): " + data);
  });
  nsupdate.on('error', callback);
  nsupdate.on('exit', function(status) {
    if(status === 0) {
      if(errors.length > 0 && errors.match(/could not/)) {
        callback("Invalid key");
      } else if(errors.length > 0) {
        callback("Unknown error");
      } else {
        callback();
      }
    } else {
      callback("Exited with status code: " + status);
    }
  });

  nsupdate.stdin.write(commands);
  nsupdate.stdin.end();

};
