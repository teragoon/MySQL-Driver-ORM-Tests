<?php
$startTime = microtime(true);

try
{
    //connect to the DB
    $db = new PDO('mysql:host=127.0.0.1;dbname=test', 'root', '');

    //read all 10,000 rows from the database
    $aResults = $db->query('SELECT * FROM test');

    //report the script duration
    print microtime(true) - $startTime;

    //close the connection
    $db = null;
}
catch (PDOException $ex)
{
    print 'PDO Error: ' . $ex->getMessage();
    die();
}
