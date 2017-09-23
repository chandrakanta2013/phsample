var express = require('express');
var bodyParser = require('body-parser');
var app = express();

// Database
var mysql = require('mysql');
var sqlCredentials = {
  host     : 'localhost',
  user     : 'root',
  password : 'password',
  database : 'phsample'
};
var db = mysql.createConnection(sqlCredentials);
db.connect(function(err) {
  if (err) throw err;
  console.log("Database Connected!");
});

var program = require('./routes/program');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Make our db accessible to our router
app.use(function(req,res,next){
    req.db = db;
    next();
});

app.use('/program', program);

/// catch 404 and forwarding to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});


module.exports = app;
