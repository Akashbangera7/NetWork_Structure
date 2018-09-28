var Cryptr = require('cryptr');
cryptr = new Cryptr('myTotalySecretKey');

var connection = require('./../config');


var loc = '35.731252, 139.730291' // Tokyo expressed as lat,lng tuple
var targetDate = new Date() // Current date/time of user computer
var timestamp = targetDate.getTime()/1000 + targetDate.getTimezoneOffset() * 60 // Current UTC date/time expressed as seconds since midnight, January 1, 1970 UTC
var apikey = 'YOUR_TIMEZONE_API_KEY_HERE'
var apicall = 'https://maps.googleapis.com/maps/api/timezone/json?location=' + loc + '&timestamp=' + timestamp + '&key=' + apikey
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
var xhr = new XMLHttpRequest() // create new XMLHttpRequest2 object
xhr.open('GET', apicall)


module.exports.authenticate=function(req,res){
    var email=req.body.email;
    var password=req.body.password;


    connection.query('SELECT * FROM users WHERE email = ?',[email], function (error, results, fields) {
      if (error) {
          res.json({
            status:false,
            message:'there are some error with query'
            })
      }else{

        if(results.length >0){
  decryptedString = cryptr.decrypt(results[0].password);
            if(password==decryptedString){
                res.json({
                    status:true,
                    message:'successfully logged in '
                })
                xhr.onload = function(){
                    if (xhr.status === 200){ // if Ajax request successful
                        var output = JSON.parse(xhr.responseText) // convert returned JSON string to JSON object
                        console.log(output.status) // log API return status for debugging purposes
                        if (output.status == 'OK'){ // if API reports everything was returned successfully
                            var offsets = output.dstOffset * 1000 + output.rawOffset * 1000 // get DST and time zone offsets in milliseconds
                            var localdate = new Date(timestamp * 1000 + offsets) // Date object containing current time of Tokyo (timestamp + dstOffset + rawOffset)
                            console.log(localdate.toLocaleString()) // Display current Tokyo date and time
                        }
                    }
                    else{
                        alert('Request failed.  Returned status of ' + xhr.status)
                    }
                }
                xhr.send() // send request
            }else{
                res.json({
                  status:false,
                  message:"Email and password does not match"
                 });
            }

        }
        else{
          res.json({
              status:false,
            message:"Email does not exits"
          });
        }
      }
    });
}
