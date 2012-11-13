var mysql = require('mysql');
var startTime = Date.now();

try {
  //connect to the DB
  var db = mysql.createConnection({
    host     : '127.0.0.1',
    user     : 'root',
    password : '',
    database : 'test'
  });
  db.connect();

  db.query('TRUNCATE test', function() {
    //close the connection
    db.end();
  });
} catch (ex) {
  console.log('Node MySQL Error: ' + ex);
  process.exit();
}

