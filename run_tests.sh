#!/usr/bin/env bash

# arrays of commands to be run and their readable names
##  you can comment out the commands you aren't interested in, but don't remove them or the names
##  won't match up anymore
commands[0]="node nodejs/mysql/server.js"
commands[1]="node nodejs/sequelize/server.js"
commands[2]="node nodejs/sequelize/server1.js"
commands[3]="node nodejs/mysql-queue/server.js"
commands[4]="php php/pdo/index.php"
commands[5]="node nodejs/mysql/server2.js"
commands[6]="node nodejs/sequelize/server2.js"
commands[7]="php php/pdo/index2.php"

names[0]="NodeJS_mysql"
names[1]="NodeJS_sequelize_1"
names[2]="NodeJS_sequelize_10"
names[3]="NodeJS_mysql_queue"
names[4]="PHP_PDO"
names[5]="NodeJS_mysql"
names[6]="NodeJS_sequelize"
names[7]="PHP_PDO"

types[0]="driver"
types[1]="orm"
types[2]="orm"
types[3]="trans"
types[4]="driver"
types[5]="driver"
types[6]="orm"
types[7]="driver"

#
# iterate over the array running each test 3 times
#
for i in ${!commands[*]}
do
  # create a string with the name and type of the driver or ORM being tested separated by colons (:)
  results[$i]=${names[$i]}:${types[$i]}:

  # insert data before run select test
  if [ $i -eq 0 ]
  then
	$(`node nodejs/truncate.js`)
  elif [ $i -eq 3]
  then
	$(`node nodejs/insert.js`)
  fi

  #
  # run each test 3 times
  #
  for (( run=0; run < 3; run++ ))
  do
    # run the test and store the output, truncating the result to 2 decimal places
    result[$run]=$(printf %.3f `${commands[$i]}`)

    # add the number, truncated to 2 decimal places, to the test string followed by a colon (:)
    results[$i]=${results[$i]}${result[$run]}:
  done

  #
  # average the results of the 3 runs
  #
  total=0
  for time in ${result[@]}
  do
    total=`echo "$total+$time"|bc`
  done

  # add the average to the test string
  results[$i]=${results[$i]}`echo "scale=2;$total/${#result[@]}"|bc`
done

#
# output a nice table of the data
#

# print a nice top border and header row for the table
BORDER="+----------------------+--------+--------+--------+--------+--------+"
echo ""
echo $BORDER
echo "| Driver/ORM           | Type   |  Run 1 |  Run 2 |  Run 3 | Average|"
echo $BORDER

for result in ${results[@]}
do
  # split each result by the colon (:) and print the results in table format
  IFS=":" read -ra resultData <<< $result
  printf "| %-20s | %-6s | %-6s | %-6s | %-6s | %-6s |\n" ${resultData[0]} ${resultData[1]} \
                                                          ${resultData[2]} ${resultData[3]} \
                                                          ${resultData[4]}
done

# print a bottom border for the table
echo $BORDER
echo ""
