var Sequelize = require("sequelize");

var startTime = Date.now();

var totalRows = 10000;

try {
  //connect to the DB
  var sequelize = new Sequelize('test', 'root', '', {
    host: '127.0.0.1',
    dialect: 'mysql',
    logging: false,
    maxConcurrentQueries: totalRows
  });

  //define our model
  var TestModel = sequelize.define('Test', {
    id: Sequelize.INTEGER,
    data: Sequelize.STRING
  }, {
    timestamps: false,
    freezeTableName: true
  });

  //read all 10,000 rows from the database
  TestModel.findAll().complete(function(err) {
    if(err) throw err;

    //report the script duration
    console.log((Date.now() - startTime) / 1000);

    //close the connection
    sequelize = null;
  });
} catch (ex) {
  console.log('Sequelize Error: ' + ex);
  process.exit();
}

