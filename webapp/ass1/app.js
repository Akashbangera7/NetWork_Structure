var express=require("express");
var bodyParser=require('body-parser');

var connection = require('./config');
var app = express();

var authenticateController=require('./routes/authenticate');
var registerController=require('./routes/register');

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', function (req, res) {
   res.sendFile( __dirname + "/" + "index.html" );
})


app.get('/login', function (req, res) {
   res.sendFile( __dirname + "/" + "login.html" );
})

app.get('/crud', function (req, res) {
   res.sendFile( __dirname + "/" + "crud.html" );
})
/* route to handle login and registration */
// app.post('/api/register',registerController.register);
// app.post('/api/authenticate',authenticateController.authenticate);

console.log(authenticateController);
app.post('/routes/register', registerController.register);
app.post('/routes/authenticate', authenticateController.authenticate);
app.listen(3000);
