<?php

require 'vendor/autoload.php';

use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;


$startTime = microtime(true);

try
{
    /**
     * @ORM\Entity
     * @ORM\Table(name="test")
     */
    class TestModel
    {
        /**
         * @ORM\Column(type="integer")
         */
        protected $id;

        /**
         * @ORM\Column(type="string", length=255)
         */
        protected $data;


        /**
         * Set id
         *
         * @param integer $id
         * @return TestModel
         */
        public function setId($id)
        {
            $this->id = $id;

            return $this;
        }

        /**
         * Get id
         *
         * @return integer
         */
        public function getId()
        {
            return $this->id;
        }

        /**
         * Set data
         *
         * @param string $data
         * @return TestModel
         */
        public function setData($data)
        {
            $this->data = $data;

            return $this;
        }

        /**
         * Get data
         *
         * @return string
         */
        public function getData()
        {
            return $this->data;
        }
    }

    //connect to the database
    $config = Setup::createYAMLMetadataConfiguration(array(__DIR__), true);
    $em = EntityManager::create(array(
        'driver' => 'pdo_mysql',
        'host' => '127.0.0.1',
        'user' => 'root',
        'dbname' => 'test'
    ), $config);

    //write 10,000 rows to the database
    for($row = 1; $row <= 10000; $row++)
    {
        $data = 'Some data for row ' . $row;
        $model = new TestModel();
        $model->setId($row)->setData($data);
        $em->persist($model);
    }
    $em->flush();

    //read all 10,000 rows from the database
    $em->getRepository('TestModel')->findAll();

    //report the script duration
    print microtime(true) - $startTime;

    //truncate the table data
    try {
        $emptyRsm = new \Doctrine\ORM\Query\ResultSetMapping();
        $em->createNativeQuery('TRUNCATE test', $emptyRsm)->execute();
    }
    catch (Exception $ignore) {}
}
catch (Exception $e)
{
    print 'Doctrine Error: ' . $e->getMessage();
}