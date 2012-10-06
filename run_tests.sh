#!/usr/bin/env bash

#arrays of commands to be run and their readable names
names[0]="NodeJS_mysql"
names[1]="NodeJS_sequelize"
names[2]="PHP_PDO"
names[3]="PHP_laravel_raw"
names[4]="PHP_laravel_eloquent"
names[5]="PHP_symphony_doctrine"
names[6]="PHP_zend_zenddb"

commands[0]="node nodejs/mysql/server.js"
commands[1]="node nodejs/sequelize/server.js"
commands[2]="php php/pdo/index.php"
commands[3]="php php/laravel_raw/artisan route:call GET /"
commands[4]="echo 'TODO'"
commands[5]="echo 'TODO'"
commands[6]="echo 'TODO'"

#iterate over the array running each test 3 times
for i in ${!commands[*]}
do
  #create a string with the name of the driver or ORM being tested followed by a colon (:)
  results[$i]=${names[$i]}:

  #run each test 3 times
  for (( run=0; run < 3; run++ ))
  do
    #run the test and store the output, truncating the result to 2 decimal places
    result[$run]=$(printf %.2f `${commands[$i]}`)

    #add the number, truncated to 2 decimal places, to the test string followed by a colon (:)
    results[$i]=${results[$i]}${result[$run]}:
  done

  #average the results of the 3 runs
  total=0
  for time in ${result[@]}
  do
    total=`echo "$total+$time" | bc`
  done

  #add the average to the test string
  results[$i]=${results[$i]}`echo "scale=2;$total/${#result[@]}" | bc`
done

echo ${results[@]}


#TODO: output a nice table of the data