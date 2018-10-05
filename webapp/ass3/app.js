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
  password : 'Joshisujay@1996',
  database : 'ass1'
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

//rest api to get a transaction data
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
app.put('/transaction', function (req, res) {
   connection.query('UPDATE `transaction` SET `description`=?,`merchant`=?,`amount`=?,`date`=?,`category`=? where `id`=?', [req.body.employee_name,req.body.employee_salary, req.body.employee_age, req.body.id], function (error, results, fields) {
	  if (error) throw error;
	  res.end(JSON.stringify(results));
	});
});

app.delete('/transaction', function (req, res) {
   console.log(req.body);
   connection.query('DELETE FROM `transaction` WHERE `id`=?', [req.body.id], function (error, results, fields) {
	  if (error) throw error;
	  res.end('Record has been deleted!');
	});
});
// server.listen(3000)
