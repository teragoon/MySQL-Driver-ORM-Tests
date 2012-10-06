# MySQL Driver & ORM comparisons

This tests the speed at which each of the various MySQL drivers and ORMs writes, reads, and
truncates 10,000 rows of data.


## Results

These tests were run on a mid-2012 Retina MacBook Pro with the following specs:

CPU: 2.6 GHz Intel Core i7
RAM: 16 GB 1600 MHz DDR3
HDD: 512 GB Solid State (500.28 GB APPLE SSD SM512E)

PHP 5.3.15
Node 0.8.0

[PUT RESULTS HERE]


## Setup (if you want to run them yourself)
Make sure you have the Required Components (below) installed/enabled, then run the following from
the root of the project:
    npm install -d
    composer install
    ./run_tests.sh

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

database: test
  encoding: utf8
table: test
  encoding: utf8
  type: InnoDB
  columns:
    id : INT
    data : VARCHAR(255)


## Todo

1. Figure out why I get a max connections error for the EventEmitter in the sequelize test. It's so
   slow that I feel like something has to be wrong.
2. Figure out how to use Eloquent without the Laravel framework if possible. I dont think it matters
   that much for this test since the timer doesn't start until the route has been resolved, but it
   may be adding some extra run time for the queries. who knows.