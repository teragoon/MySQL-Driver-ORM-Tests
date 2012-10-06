# MySQL Driver & ORM comparisons

This tests the speed at which each of the various MySQL drivers and ORMs writes, reads, and
truncates 10,000 rows of data.

## Schema

database: test
  encoding: utf8
table: test
  encoding: utf8
  type: InnoDB
  columns:
    id : INT
    data : VARCHAR(255)