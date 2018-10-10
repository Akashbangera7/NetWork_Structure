var express=require("express");
var bodyParser=require('body-parser');


var app = express();

var http = require('http')
var auth = require('basic-auth')
var compare = require('tsscmp')

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'Samanushetty@7',
  database : 'ass3'
});
connection.connect(function(err){
if(!err) {
    console.log("Database is connected");
} else {
    console.log("Error while connecting with database");
}
});

app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));
//end body-parser configuration

//create app server
var server = app.listen(3000,  "127.0.0.1", function () {

  var host = server.address().address
  var port = server.address().port

  console.log("Example app listening at http://%s:%s", host, port)

});


// to get passward :   user.pass  and if you want username  : user.name
//rest api to get a transaction data
app.get('/transaction', function (req, res) {
   var user = auth(req)

  //Select username,password from login where username = user.name && password = user.username
   connection.query(`select username,password from login where username = '${user.name}' && password = '${user.pass}'`, function (error, results) {
	  if (error) throw error;
    connection.query('select * from transaction', function (error, results, fields) {
 	  if (error) throw error;

 	  res.end(JSON.stringify(results));
 	});
	  res.send(results);
	});
});

app.get('/transaction/:id', function (req, res) {
   console.log(req);
   connection.query('select * from transaction where id=?', [req.params.id], function (error, results, fields) {
	  if (error) throw error;

	  res.end(JSON.stringify(results));
	});
});

//rest api to create a new record into mysql database
app.post('/transaction', function (req, res) {
   var postData  = req.body;
   connection.query('INSERT INTO transaction SET ?', postData, function (error, results, fields) {
	  if (error) throw error;
	  res.end(JSON.stringify(results));
	});
});

//rest api to update record into mysql database
app.put('/transaction/:id', function (req, res) {
  console.log(req.params.id);
  var sql = `UPDATE transaction SET description = '${req.body.description}',merchant = '${req.body.merchant}',amount = '${req.body.amount}',date = '${req.body.date}',category = '${req.body.category}' WHERE id = '${req.params.id}'`;
  connection.query(sql,function(err,trans){
    if(err)
    {throw err;}
    res.send(trans);
  });
  //  connection.query('UPDATE `transaction` SET `description`=?,`merchant`=?,`amount`=?,`date`=?,`category`=? where `id`=?', [req.params.id,req.body.transaction,req.body.merchant,req.body.amount,req.body.date,req.body.category], function (error, results, fields) {
	//   if (error) throw error;
	//   res.end(JSON.stringify(results));
	// });
});

app.delete('/transaction', function (req, res) {
   console.log(req.body);
   connection.query('DELETE FROM `transaction` WHERE `id`=?', [req.body.id], function (error, results, fields) {
	  if (error) throw error;
	  res.end('Record has been deleted!');
	});
});
// server.listen(3000)
