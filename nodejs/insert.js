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

  //write 10,000 rows to the database
  var rowsWritten = 0;
  var totalRows = 10000;
  for(var row = 1; row <= totalRows; row++) {
    var data = 'Some data for row ' + row;
    db.query('INSERT INTO test (id, data) VALUES (?, ?)', [row, data], function() {
      //once all rows have been written do the SELECT and TRUNCATE
      if(++rowsWritten >= totalRows) {
        //close the connection
        db.end();
      }
    });
  }
} catch (ex) {
  console.log('Node MySQL Error: ' + ex);
  process.exit();
}

