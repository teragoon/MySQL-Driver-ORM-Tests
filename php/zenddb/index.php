<?php

require 'vendor/autoload.php';

use Zend\Db\Adapter\Adapter;

$startTime = microtime(true);

try
{
    //connect to the database
    $adapter = new Adapter(array(
        'driver' => 'Pdo_Mysql',
        'database' => 'test',
        'username' => 'root',
        'hostname' => '127.0.0.1'
    ));

    //write 10,000 rows to the database
    $procedure = $adapter->createStatement('INSERT INTO test (id, data) VALUES (?, ?)');
    for($row = 1; $row <= 10000; $row++)
    {
        $data = 'Some data for row ' . $row;
        $procedure->execute(array($row, $data));
    }

    //read all 10,000 rows from the database
    $adapter->query('SELECT * FROM test');

    //report the script duration
    print microtime(true) - $startTime;

    //truncate the table data
    $adapter->query('TRUNCATE test')->execute();
}
catch(Exception $e)
{
    print 'ZendDb Error: ' . $e->getMessage();
}

