var Cryptr = require('cryptr');

cryptr = new Cryptr('myTotalySecretKey');

var connection = require('./../config');





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

                xhr.send() // send request

                // response.writeHead(200, {'Content-Type': 'text/html'});
                // fs.readFile('./crud.html', null, function(error, data) {
                //     if (error) {
                //         response.writeHead(404);
                //         response.write('File not found!');
                //     } else {
                //         response.write(data);
                //     }
                //     response.end();
                // });




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
