# MySQL Driver & ORM comparisons

This tests the speed at which each of the various MySQL drivers and ORMs writes, reads, and
truncates 10,000 rows of data.


## Results

These tests were run on a mid-2012 Retina MacBook Pro with the following specs:

* CPU: 2.80 GHz Intel Core i5
* RAM: 4 GB
* HDD: 750 GB SATA-2 7200RPM 16MB
* PHP 5.2.9
* Node 0.8.12

```
+----------------------+--------+--------+--------+--------+--------+
| Driver/ORM           | Type   | Run 1  | Run 2  | Run 3  | Average|
+----------------------+--------+--------+--------+--------+--------+
| NodeJS_mysql         | driver | 43.148 | 34.969 | 34.792 |        |
| NodeJS_sequelize_1   | orm    | 46.830 | 52.933 | 49.480 |        |
| NodeJS_sequelize_10  | orm    | 13.408 | 13.241 | 12.648 |        |
| NodeJS_mysql_queue   | trans  |  5.358 |  4.880 |  4.741 |        |
| PHP_PDO              | driver | 32.905 | 36.375 | 31.431 |        |
| NodeJS_mysql         | driver |  0.108 |  0.188 |  0.196 |        |
| NodeJS_sequelize     | orm    |  0.133 |  0.132 |  0.132 |        |
| PHP_PDO              | driver |  0.004 |  0.004 |  0.003 |        |
+----------------------+--------+-------+-------+-------+-------+
```


## Setup (if you want to run them yourself)
Make sure you have the Required Components (below) installed/enabled, then run the following from
the root of the project:
```
npm install -d
composer install
./run_tests.sh
```

### Required Components
To replicate these tests it is recommended that you have the following components installed/enabled:

#### PHP

* PHP 5.2+
* PDO
* php_mysql
* Composer

#### Node

* NodeJS 0.7.0+
* NPM - Node Package Manager


## Database Schema

```
database: test
  encoding: utf8
table: test
  encoding: utf8
  type: InnoDB
  columns:
    id : INT
    data : VARCHAR(255)
```


## Todo

1. Figure out why I get a max connections error for the EventEmitter in the sequelize test. It's so
   slow that I feel like something has to be wrong.
   => add like this when connect to the DB( pool: { maxConnections: 1, maxIdleTime: 30} )
2. Figure out how to use Eloquent without the Laravel framework if possible. I dont think it matters
   that much for this test since the timer doesn't start until the route has been resolved, but it
   may be adding some extra run time for the queries. who knows.