var Sequelize = require("sequelize");

var startTime = Date.now();

var totalRows = 10000;

try {
  //connect to the DB
  var sequelize = new Sequelize('test', 'root', '', {
    host: '127.0.0.1',
    dialect: 'mysql',
    logging: false,
    maxConcurrentQueries: 100
    ,pool: { maxConnections: 10, maxIdleTime: 30}
  });

  //define our model
  var TestModel = sequelize.define('Test', {
    id: Sequelize.INTEGER,
    data: Sequelize.STRING
  }, {
    timestamps: false,
    freezeTableName: true
  });

  //write 10,000 rows to the database
  var rowsWritten = 0;
  for(var row = 1; row <= totalRows; row++) {
    var data = 'Some data for row ' + row;
    TestModel.create({ id: row, data: data }).success(function() {
      //once all rows have been written do the SELECT and TRUNCATE
      if(++rowsWritten >= totalRows) {
        //read all 10,000 rows from the database
        TestModel.findAll().complete(function(err) {
          if(err) throw err;

          //report the script duration
          console.log((Date.now() - startTime) / 1000);

          //truncate the table data
          TestModel.sync({force: true});

          //close the connection
          sequelize = null;
        });
      }
    });
  }
} catch (ex) {
  console.log('Sequelize Error: ' + ex);
  process.exit();
}

