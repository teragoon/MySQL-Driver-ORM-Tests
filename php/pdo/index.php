<?php
$startTime = microtime(true);

try
{
    //connect to the DB
    $db = new PDO('mysql:host=127.0.0.1;dbname=test', 'root', '');

    //using stored procedures since it's a basic feature of PDO
    $procedure = $db->prepare('INSERT INTO test (id, data) VALUES (?, ?)');
    $procedure->bindParam(1, $row);
    $procedure->bindParam(2, $data);

    //write 10,000 rows to the database
    for($row = 1; $row <= 10000; $row++)
    {
        $data = 'Some data for row ' . $row;
        $procedure->execute();
    }

    //read all 10,000 rows from the database
    $db->query('SELECT * FROM test');

    //report the script duration
    print microtime(true) - $startTime;

    //truncate the table data
    $db->query('TRUNCATE test');

    //close the connection
    $db = null;
}
catch (PDOException $ex)
{
    print 'PDO Error: ' . $ex->getMessage();
    die();
}
