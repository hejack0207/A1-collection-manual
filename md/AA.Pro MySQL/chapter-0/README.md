## check to make sure the old_id and new_id exists

SELECT count(*) INTO old_count FROM customer WHERE customer_id = old_id;

SELECT count(*) INTO new_count FROM customer WHERE customer_id = new_id;

IF !old_count THEN

SET error = 'old id does not exist';

ELSEIF !new_count THEN

SET error = 'new id does not exist';

ELSE

UPDATE address SET customer_id = new_id WHERE customer_id = old_id;

SELECT row_count() INTO addresses_changed;


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

UPDATE payment SET customer_id = new_id WHERE customer_id = old_id;

SELECT row_count() INTO payments_changed;

UPDATE cust_order SET customer_id = new_id WHERE customer_id = old_id;

SELECT row_count() INTO orders_changed;

DELETE FROM customer WHERE customer_id = old_id;

SELECT addresses_changed,payments_changed,orders_changed;

END IF;

END

//

DELIMITER ;

When entering multiple statement blocks into MySQL, you need to first change the

default delimiter to something other than a semicolon (;), so MySQL will allow you to enter

a ; without having the client process the input. Listing 9-3 begins by using the delimiter

statement: DELIMITER //, which changes the delimiter to //. When you’re ready to have your

procedure created, type //, and the client will process your entire procedure. When you’re

finished working on your procedures, change the delimiter back to the standard semicolon

with: DELIMITER ;, as you can see at the end of Listing 9-3. We’ll explain the other parts of this

listing in detail shortly.

Listing 9-4 shows how to call this procedure with the required parameters and get the

results from the procedure. We’ll look at the details of executing stored procedures in the

“Using Stored Procedures” section later in this chapter.

Listing 9-4. Calling the Stored Procedure

mysql> call merge_customers (1,4,@error);

+-------------------+------------------+----------------+

| addresses_changed | payments_changed | orders_changed |

+-------------------+------------------+----------------+

|                 2 |                2 |              2 |

+-------------------+------------------+----------------+

1 row in set (0.23 sec)

Now, let’s step through each part of the stored procedure to see how it’s constructed and

what options are available.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

The CREATE Statement

You create a stored procedure using the CREATE statement, which takes a procedure name, fol-

lowed by parameters in parentheses, followed by procedure characteristics, and ending with

the series of statements to be run when the procedure is called. Here is the syntax:

mysql> CREATE PROCEDURE [database.]<name> ([<parameters>]) [<characteristics>]

<body statements>

The name may be prefixed with a database name, and it must be followed by parentheses.

If the database is not provided, MySQL creates the procedure in the current database or gives

a No database selected error if a database is not active. Procedure names can be up to 64

characters long.

■Caution Avoid conflicts with built-in functions by not using built-in function names for your procedure.

If you must have a procedure with the same name as a MySQL function, putting a space between the name

and the parentheses will help MySQL differentiate between the two. For example, a build in function for get-

ting all uppercase text is upper(). We suggest you don’t, but if you must create a stored procedure with the

same name, use upper () (note the space between the name and the opening parenthesis) to distinguish it

from the built-in function.

You can set parameters for a stored procedure using the following syntax:

[IN|OUT|INOUT] <name> <data type>

If you don’t specify IN, OUT, or INOUT for the parameter, it will default to IN. These three

types of parameters work as follows:

• An IN parameter is set and passed into the stored procedure to use internally in its

processing.

• An OUT parameter is set within the procedure, but accessed by the caller.

• An INOUT parameter is passed into the procedure for internal use, but is also available to

the caller after the procedure has completed.

The name and data type of the parameter are used in the stored procedure for referencing

and setting values going in and out of the procedure. The data type can be any valid data type

for MySQL, and it specifies what type of data will be stored in the parameter. You’ll see a detailed

example of passing arguments in and out of a procedure in the “Using Stored Procedures” sec-

tion (Listings 9-13 and 9-16) later in this chapter.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

The stored procedure characteristics include a number of options for how the stored pro-

cedure behaves. Table 9-1 lists the available options with a description of how they affect the

stored procedure.

Table 9-1. Characteristics Used to Create a Stored Procedure

Characteristic

Value

LANGUAGE

SQL

Description

SQL SECURITY

DEFINER or INVOKER

COMMENT

This is the language that was used to write the stored

procedure. While MySQL intends to implement other

languages with external procedures, currently SQL is

the only valid option.

The SQL SECURITY characteristic tells MySQL which user

to use for permissions when running the procedure. If

it’s set to DEFINER, the stored procedure will be run using

the privileges of the user who created the procedure. If

INVOKER is specified, the user calling the procedure will

be used for obtaining access to the tables. The default, if

not specified, is DEFINER.

The COMMENT characteristic is a place to enter notes

about a stored procedure. The comment is displayed

in SHOW CREATE PROCEDURE commands.

■Caution The COMMENT characteristic is an extension to SQL:2003, which means that procedures with a

comment in the definition may not easily move to another SQL:2003-compliant database.

The Procedure Body

The body of a stored procedure contains the collection of SQL statements that make up the

actual procedure. In addition to the typical SQL statements you use to interact with data in

your database, the SQL:2003 specification includes a number of additional commands to store

variables, make decisions, and loop over sets of records.

■Note MySQL allows you to put Data Definition Language (DDL) statements (CREATE, ALTER, and so on) in

the body of a stored procedure. This is part of the SQL:2003 standard, but it is labeled as an optional feature

and may not be supported in other databases that comply with the standard.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

BEGIN and END Statements

You use the BEGIN and END statements to group statements in procedures with more than one

SQL statement. Declarations can be made only within a BEGIN . . . END block.

You can define a label for the block to clarify your code, as shown here:

customer: BEGIN

<SQL statement>;

<SQL statement>;

END customer

The labels must match exactly.

The DECLARE Statement

The DECLARE statement is used to create local variables, conditions, handlers, and cursors within

the procedure. You can use DECLARE only as the first statements immediately within a BEGIN

block. The declarations must occur  with variables first, cursors second, and handlers last.

A common declaration is the local variable, which is done with a variable name and type:

DECLARE <name> <data type> [DEFAULT];

Variable declarations can use any valid data type for MySQL, and may include an optional

default value. In Listing 9-3, several declarations are made, including a number of variables for

counting items as the statements in the procedure are processed:

Here, we’ll look at how to declare variables, conditions, and handlers. Cursors are covered

DECLARE new_count INT DEFAULT 0;

in more detail in Chapter 11.

Variables

Stored procedures can access and set local, session, and global variables. Local variables are

either passed in as parameters or created using the DECLARE statement, and they are used in

the stored procedure by referencing the name of the parameter or declared variable.

You can set variables in several ways. Using the DECLARE statement with a DEFAULT will set

the value of a local variable:

DECLARE customer_count INT DEFAULT 0;

SET customer_count = 5;

setting multiple variables in one statement:

SET customer_count = 5, order_count = 50;

You can assign values to local, session, and global variables using the SET statement:

MySQL’s SET statement includes an extension to the SQL:2003 standard that permits


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

■Caution Setting multiple variables in a single statement is a MySQL extension to the SQL:2003 standard.

Using this syntax may make your procedures less portable.

Using SELECT . . . INTO is another method for setting variables within your stored pro-

cedure. This allows you to query a table and push the results into a variable as a part of the

query. SELECT . . . INTO works only if you are selecting a single row of data:

SELECT COUNT(*) INTO customer_count FROM customer;

You can also select multiple values into multiple variables:

SELECT customer_id,name INTO new_id,new_name FROM customer LIMIT 1;

■Caution Use caution when creating variables in stored procedures. If variable names are the same as

field names in a table, you may encounter unexpected results. You might want to define a naming convention

for all variables in stored procedures to avoid conflicts with other items in the namespace.

Conditions and Handlers

When making declarations in your stored procedure, your list of declarations can include

statements to indicate special handling when certain conditions arise. When you have a col-

lection of statements being processed, being able to detect the outcome of those statements

and proactively do something to help the procedure be successful can be important to your

caller.

Suppose one of the stored procedures created for your online store included a statement

to update the customer’s name. The column for the customer’s name is CHAR(10), which is

smaller than you would like, but is the most your legacy order-entry system can handle. The

normal behavior for MySQL when updating a record is to truncate the inserted value to a

length that fits the column. For numerous reasons, this is unacceptable to you. Fortunately,

when MySQL does a truncation, it issues a warning and returns an error, and also sets the

SQLSTATE to indicate that during the query, the data was truncated.

■Note More than 2,000 error numbers can be raised as errors or warnings from MySQL. Each MySQL

error number has a message and a corresponding SQLSTATE value. For the details of each error number and

its meaning, see http://dev.mysql.com/doc/mysql/en/Error-handling.html.

Handlers are designed to detect when certain errors or warnings have been triggered by

statements and allow you to take action. A handler is declared with a handler type, condition,

and statement:

DECLARE <handler type> HANDLER FOR <condition> <statement>;


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Handler Types

The handler type is either CONTINUE or EXIT.3 CONTINUE means that when a certain error or

warning is issued, MySQL will run the provided statement and continue running the state-

ments in the procedure. The EXIT handler type tells MySQL that when the condition is met,

it should run the statement and exit the current BEGIN . . . END block.

Here’s a handler statement with an EXIT handler type:

DECLARE EXIT HANDLER FOR truncated_name

UPDATE customer SET name = old_name WHERE customer_id = cust_id;

In this statement, the EXIT handler type tells the procedure to execute the statement, and then

exit when a truncation occurs.

Conditions

The handler condition is what triggers the handler to act. You can define your own conditions

and reference them by name, or choose from a set of conditions that are provided by default

in MySQL. Table 9-2 shows the MySQL handler conditions.

Table 9-2. MySQL Handler Conditions

Condition

SQLSTATE '<number>'

Description

<self-defined condition name>

SQLWARNING

NOT FOUND

SQLEXCEPTION

<MySQL error>

A specific warning or error number, which is described in the

MySQL documentation. The number must be enclosed in

quotes (typically single).

The name of the self-defined condition you created using the

DECLARE . . . CONDITION statement.

Matches any SQLSTATE that begins with 01. Using this

condition will allow you to catch a wide range of states.

Matches any SQLSTATE beginning with 02. Using this state lets

you catch any instance where the query references a missing

table, database, and so on.

Matches every SQLSTATE except those beginning with 01 or 02.

Using a specific error will cause the handler to execute for the

specific MySQL error.

■Tip Creating self-defined conditions improves readability of your code. Rather than using the MySQL error

or SQLSTATE number, you are assigning a name to that state, which will be more understandable than just

having the number.

3. The UNDO handler type, which is part of the SQL:2003 specification, is not currently supported in

MySQL.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

To create a self-defined condition, use a condition declaration with a name and a value:

DECLARE <condition name> CONDITION FOR <condition value>;

The condition name will be used in a DECLARE . . . HANDLER definition. The condition value can

be either a MySQL error number or a SQLSTATE code. For example, to catch when some data has

been truncated, the condition declaration with the MySQL error number looks like this:

DECLARE truncated_name CONDITION FOR 1265;

Or if you wanted to use the SQLSTATE number, you would write the same statement like

this:

DECLARE truncated_name CONDITION FOR SQLSTATE '01000';

■Caution A single SQLSTATE value can be assigned to multiple MySQL error numbers, meaning that if

you use the SQLSTATE numbers, you may have different errors that generate the same SQLSTATE. This can

help or hinder the effectiveness of your handler. In some cases, you want to match all occurrences of a cer-

tain type of error, which are grouped under a certain SQLSTATE. In the example, we want to find a very

specific error, so it makes more sense to use the MySQL error code.

Statements

The last piece of the handler declaration is a statement, which will be run before the stored

procedure either continues or exits, depending on the handler type you chose. For example, to

catch a case where the name had been truncated, your stored procedure might look like the

one shown in Listing 9-5.

Listing 9-5. Declaring a Condition and Handler

DELIMITER //

CREATE PROCEDURE update_name (IN cust_id INT, IN new_name VARCHAR(20))

BEGIN

DECLARE old_name VARCHAR(10);

DECLARE truncated_name CONDITION for 1265;

DECLARE EXIT HANDLER FOR truncated_name

UPDATE customer SET name = old_name WHERE customer_id = cust_id;

SELECT name INTO old_name FROM customer WHERE customer_id = cust_id;

UPDATE customer SET name = new_name WHERE customer_id = cust_id;

SELECT customer_id,name FROM customer WHERE customer_id = cust_id;

END

//

DELIMITER ;

The update_name procedure accepts a customer ID (cust_id) and a new name (new_name).

The first two statements declare a variable to store the old name and a condition named


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

truncated_name, which specifies MySQL error 1265 as the condition. MySQL error 1265 indi-

cates that a field in the statement was truncated when the statement was processed. The third

declaration is a handler statement that tells the procedure that if the truncated_name state is

reached, to update the customer record to the old name and exit.

The stored procedure runs the declarations first, and then selects the current name for

that customer into the old_name variable. On the following UPDATE statement, depending on

the length of the name to be inserted, the query result may be a MySQL error 1265. If so, the

handler for truncated_name runs the statement associated with the handler:

UPDATE customer SET name = old_name WHERE customer_id = cust_id;

This query sets the name back to the original value. The procedure then exits, and no

record is returned to the client.

■Note The handler example demonstration here is really just an elaborate rollback mechanism. The

SQL:2003 standard contains specifications for an UNDO handler type, which would roll back the transaction

block if a particular condition is met. MySQL doesn’t currently support the UNDO handler type, but promises it

is coming.

SQL:2003 flow constructs give you a number of statements to control and organize your state-

ment processing. MySQL supports IF, CASE, LOOP, LEAVE, ITERATE, REPEAT, and WHILE, but does

not currently support the FOR statement.

Flow Controls

IF

The IF statement behaves as you would expect if you’ve written code in another language. It

checks a condition, running the statements in the block if the condition is true. You can add

ELSEIF statements to continue attempting to match conditions and also, if desired, include a

final ELSE statement.

Listing 9-6 shows a piece of a procedure where the shipping cost is being calculated based

on the number of days the customer is willing to wait for delivery. delivery_day is an integer

parameter passed into the procedure.

Listing 9-6. IF Statement

IF delivery_day = 1 THEN

SET shipping = 20;

ELSEIF delivery_day = 2 THEN

SET shipping = 15;

ELSEIF delivery_day = 3 THEN

SET shipping = 10;

ELSE

END IF;

SET shipping = 5;


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

CASE

If you’re checking a uniform condition, such a continual check for number of shipping days,

you might be better off using the CASE construct. Listing 9-7 shows how this same logic

demonstrated in Listing 9-6 could be processed using the CASE statement. Not only does it

seem to improve the readability of the code, but the code in Listing 9-7 runs at least twice as

fast as the code in Listing 9-6. delivery_day is an integer parameter passed into the procedure.

Listing 9-7. CASE Statement

CASE delivery_day

WHEN 1 THEN

WHEN 2 THEN

SET shipping = 20;

SET shipping = 15;

WHEN 3 THEN

SET shipping = 10;

ELSE

SET shipping = 5;

END case;

CASE

WHEN delivery_day = 1 THEN

SET shipping = 20;

WHEN delivery_day = 2 THEN

SET shipping = 15;

WHEN delivery_day = 3  THEN

SET shipping = 10;

ELSE

END CASE;

SET shipping = 5;

The CASE control can also operate without an initial case value, evaluating a condition on

each WHEN block. Listing 9-8 shows the shipping calculator using this syntax. As with Listing 9-7,

Listing 9-8 runs significantly faster than the IF-based logic in Listing 9-6.

Listing 9-8. CASE Statement with Condition Checks

Now that you are up to speed with checking values, we’ll turn our attention to the con-

structs for repeating. The LOOP, LEAVE, ITERATE, REPEAT, and WHILE statements provide methods

to work through a given number of conditions.

LOOP and LEAVE

The LOOP statement creates an ongoing loop that will run until the LEAVE statement is invoked.

Optional to the LOOP is a label, which is a name and a colon prefixed to the LOOP statement,

with the identical name appended to the END LOOP statement. Listing 9-9 demonstrates a LOOP

and LEAVE construct.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Listing 9-9. LOOP Statement with LEAVE

increment: LOOP

SET count = count + 1;

IF count > in_count THEN LEAVE increment;

END IF;

END LOOP increment;

be accompanied by a label.

ITERATE

The LEAVE statement is designed to exit from any flow control. The LEAVE statement must

You can use ITERATE in a LOOP, WHILE, or REPEAT control to indicate that the control should

iterate through the statements in the loop again. Listing 9-10 shows ITERATE added to the

increment example in Listing 9-9. Adding the IF condition to check if the count is less than 20,

and if so iterating, means that the value of count, when the loop is complete, will never be less

than 20, because the ITERATE statement ensures that the addition statement is run repeatedly

until the count reaches 20.

Listing 9-10. Loop with ITERATE Statement

DELIMITER //

CREATE PROCEDURE increment (IN in_count INT)

BEGIN

DECLARE count INT default 0;

increment: LOOP

SET count = count + 1;

IF count < 20 THEN ITERATE increment; END IF;

IF count > in_count THEN LEAVE increment;

END IF;

END LOOP increment;

SELECT count;

END

//

DELIMITER ;

WHILE

Listing 9-11. WHILE Statement

WHILE count < 10 DO

SET count = count + 1;

END WHILE;

The WHILE statement is another mechanism to loop over a set of statements until a condition

is true. Unlike LOOP, where the condition is met within the loop, the WHILE statement requires

specification of the condition when defining the statement. As with loops, you can add a

name to give a name to the WHILE construct. Listing 9-11 shows a simple use of this statement.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

REPEAT

To loop over a set of statements until a post-statement condition is met, use the REPEAT state-

ment. Listing 9-12 shows a simple use. The check_count label is optional, as is the label with

other constructs.

Listing 9-12. REPEAT Statement

check_count: REPEAT

SET count = count + 1;

UNTIL count > 10

END REPEAT check_count;

Using Stored Procedures

If you’ve gone to all the trouble of creating a procedure, you probably want to put it to use.

You may be calling the procedures directly from the MySQL command-line client or from a

program written in PHP, Java, Perl, Python, or another language. Here, we’ll look at how to call

procedures from the command line and from PHP, just to demonstrate calling procedures from

a program. Check the documentation for the specific language you’re using to see which driv-

ers are needed and how the interface for procedures and parameters work in that language.

Calling Procedures from the MySQL Client

From the MySQL client, you use the CALL statement to execute a procedure, providing the

procedure name and correct number of arguments.

CALL [database.]<procedure name> ([<parameter>, <parameter>, …]);

Calling a simple procedure without any parameters is fairly straightforward, as you saw

earlier in the chapter, when we demonstrated calling the get_customer procedure (Listing 9-2).

Listing 9-13 shows an example of calling a stored procedure that requires three arguments:

an old customer ID as the first IN argument, a new customer ID as the second IN argument, and

an OUT argument used in the procedure for setting an error message. Once the stored procedure

has been executed, the @error variable contains a string set inside the stored procedure.

Listing 9-13. Calling a Stored Procedure with IN and OUT Parameters

mysql> CALL merge_customers (8,9,@error);

Query OK, 0 rows affected (0.01 sec)

mysql> SELECT @error;

+-----------------------+

| @error                |

+-----------------------+

| old id does not exist |

+-----------------------+

1 row in set (0.30 sec)


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

If you call a procedure with the wrong number of arguments, MySQL gives an error:

mysql> CALL shop.merge_customers (1,2);

ERROR 1318 (42000): Incorrect number of arguments for PROCEDURE merge_customers; \

expected 3, got 2

Calling Procedures from PHP

In PHP, stored procedures must be called using PHP’s  mysqli extensions. This requires your

PHP code to be compiled with the --with-mysqli option. Listing 9-14 shows how you would

call the get_customers procedure from PHP and report the results.

Listing 9-14. Calling a Stored Procedure from PHP

<?

$mysqli = mysqli_connect("localhost","mkruck","ProMySQL","shop");

if (mysqli_connect_errno()) {

printf("Failed to connect: %s\n", mysqli_connect_error());

exit();

}

if ($result = $mysqli->query("CALL get_customers ()")) {

printf("%d records found\n",$result->num_rows);

while ($row = $result->fetch_row()) {

printf("%d - %s\n",$row[0],$row[1]);

}

}

else {

}

$mysqli->close();

?>

echo $mysqli->error,"\n";

This script makes a connection to the database (checking for failure), calls the stored pro-

cedure, and then prints the number of rows that were returned along with a line for each piece

of the data. If the CALL statement fails, the error is printed.

Running the PHP script in Listing 9-14 generates the output shown in Listing 9-15.

Listing 9-15. Output from a Stored Procedure Called in PHP

6 records found

1 - Mike

2 - Jay

3 - Johanna

4 - Michael

5 - Heidi

6 - Ezra

procedure.

The output from Listing 9-15 shows that six records were returned from the get_customers


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

To merge two of these customers by calling the merge_customers procedure (created in

Listing 9-3) adds a little more complexity because you must pass IN and OUT parameters to the

procedure. A simple way to do this is shown in Listing 9-16.

Listing 9-16. Calling a Stored Procedure with Parameters from PHP

<?

$mysqli = mysqli_connect("localhost","mkruck","ProMySQL","shop");

if (mysqli_connect_errno()) {

printf("Failed to connect: %s\n", mysqli_connect_error());

exit();

}

$old_customer = 1;

$new_customer = 4;

$mysqli->query("CALL merge_customers ($old_customer,$new_customer,@error)");

$result = $mysqli->query("SELECT @error");

if ($result->num_rows) {

while ($row = $result->fetch_row()) {

printf("%s\n",$row[0]);

print "Customer merge successful";

}

}

else {

}

$mysqli->close();

?>

@error:

Customer merge successful

This PHP script will print a success message if the call to the procedure didn’t set the

But if the procedure encountered a problem, such as that one of the records couldn’t be

found, and sets the @error variable with an error message, the PHP script will print that error.

Running the PHP script again, after customer records 1 and 4 have already been merged,

results in the PHP script printing the error message from the procedure:

old id does not exist

■Tip The mysqli extension allows significantly more complex database interaction, such as creating

prepared statements, binding parameters, and so on. For more information, see the PHP documentation at

http://www.php.net/mysqli.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Managing Stored Procedures

Most of the work in an environment where stored procedures are used is in creating the stored

procedure. However, at some point, you will need to manage the procedures in your database.

MySQL provides a set of commands for this purpose.

Viewing Stored Procedures

You have several options when viewing information about stored procedures. To get a summary

of the procedures across all databases in your system, use SHOW PROCEDURE STATUS, which will give

you a summary of information about all the stored procedures in your system. Listing 9-17 shows

the output for three procedures used for listings in this chapter. Using the \G option outputs in

rows instead of columns.

Listing 9-17. Output of SHOW PROCEDURE STATUS

mysql> SHOW PROCEDURE STATUS\G

*************************** 1. row ***************************

Db: shop

Name: get_customers

Type: PROCEDURE

Definer: mkruck01@localhost

Modified: 2005-01-10 23:23:20

Created: 2005-01-10 23:23:20

Security_type: DEFINER

Comment:

Db: shop

Name: get_shipping_cost

Type: PROCEDURE

Definer: mkruck01@localhost

Modified: 2005-01-10 22:45:57

Created: 2005-01-10 22:45:57

Security_type: DEFINER

Comment:

Db: shop

Name: merge_customers

Type: PROCEDURE

Definer: mkruck01@localhost

Modified: 2005-01-10 23:23:20

Created: 2005-01-10 23:23:20

*************************** 2. row ***************************

*************************** 3. row ***************************

Security_type: DEFINER

Comment: get rid of unnecessary data

to just returning the merge_customer procedure.

mysql> SHOW PROCEDURE STATUS LIKE 'merge%'\G

This command can be limited by appending a LIKE clause, in this case limiting the output


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

The SHOW PROCEDURE STATUS statement gives you a nice summary view of all the procedures

in the databases on your machine. To get more details on a stored procedure, use the

SHOW CREATE PROCEDURE statement:

SHOW CREATE PROCEDURE [<database>.]<procedure name>;

This statement shows you the name and the CREATE statement. Listing 9-18 shows an example

of the output for the get_shipping_cost procedure.

Listing 9-18. Output of SHOW CREATE PROCEDURE

mysql> SHOW CREATE PROCEDURE shop.get_shipping_cost\G

*************************** 1. row ***************************

Procedure: get_shipping_cost

sql_mode:

Create Procedure: CREATE PROCEDURE `shop`.`get_shipping_cost`(IN delivery_day INT)

COMMENT 'determine shipping cost based on day of delivery'

BEGIN

declare shipping INT;

case delivery_day

when 1 then set shipping = 20;

when 2 then set shipping = 15;

when 3 then set shipping = 10;

else set shipping = 5;

end case;

select shipping;

END

1 row in set (0.12 sec)

Neither of the views we’ve discussed thus far shows you everything there is to know about

a procedure. The summary provides only a few pieces of summary information, and SHOW ➥

CREATE PROCEDURE shows the name, along with the body as a large, unreadable CREATE statement.

If you have SELECT access on the proc table in the mysql database, a SELECT statement will show

you everything there is to know about all procedures or a particular procedure. Listing 9-19

shows the output from a SELECT of the get_shipping_cost procedure, which shows the proce-

dure’s database, name, language, security type, parameter list, body, definer, comment, and

other information.

Listing 9-19. Output of SELECT from the mysql.proc Table

mysql> SELECT * FROM mysql.proc WHERE name = 'get_shipping_cost'\G

*************************** 1. row ***************************

db: shop

name: get_shipping_cost

type: PROCEDURE

specific_name: get_shipping_cost

language: SQL

sql_data_access: CONTAINS_SQL

is_deterministic: NO


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

security_type: DEFINER

param_list: IN delivery_day INT

returns:

body: BEGIN

declare shipping INT;

case delivery_day

when 1 then set shipping = 20;

when 2 then set shipping = 15;

when 3 then set shipping = 10;

else set shipping = 5;

end case;

select shipping;

END

definer: mkruck01@localhost

created: 2005-01-11 00:01:47

modified: 2005-01-11 00:01:47

sql_mode:

comment: determine shipping cost based on day of delivery

1 row in set (0.12 sec)

As you can see, if you want to view everything there is to know about a procedure, the

direct SELECT on the mysql.proc table will provide the most information.

Altering and Removing Stored Procedures

The ALTER statement lets you change the characteristics of a stored procedure. It has the fol-

lowing syntax:

ALTER PROCEDURE [<database>.]<procedure name> <characteristics>

The ALTER statement can change any of the characteristics used to create the procedure,

as shown earlier in Table 9-1. For example, to change the SQL SECURITY and COMMENT on the

get_customers procedure, you would use the following ALTER statement:

mysql> ALTER PROCEDURE get_customers SQL SECURITY INVOKER

COMMENT 'show all customers';

To remove a stored procedures, use the DROP statement, which has the following syntax:

DROP PROCEDURE [database.]<procedure name>

Editing Stored Procedures

Editing stored procedures doesn’t happen interactively with the database, as with the SHOW,

ALTER, or DROP statements. The process of editing a stored procedure means opening it in an

editor, making the necessary changes, and replacing the existing procedure in the database

with the new one using a DROP and then a CREATE statement.

Choosing an environment for editing stored procedures is similar to finding one for any

kind of programming. If you prefer to work in a text editor like Emacs, vi, or Notepad, you’ll

probably be most comfortable doing the same when working on your procedures. A GUI tool

will make more sense if that’s where you find most of your other development happens.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Regardless of your tool for editing stored procedures, you should use a versioning system

like Subversion or CVS to store and keep track of changes in your stored procedures. Stored

procedures should be treated like any other piece of code in this respect—you’ve spent time

developing it and should take measures to protect your time and effort.

■Tip If you prefer working in a GUI, you might try MySQL Query Browser, a GUI tool for Windows and Linux

that has en excellent interface for editing procedures. The tool will allow you to update the existing proce-

dure with a DROP and CREATE from a button on the interface. More information on the freely available

MySQL Query Browser is available at http://dev.mysql.com/doc/query-browser/en/index.html.

Stored Procedure Permissions

For permissions to create and call stored procedures, MySQL relies on the existing permissions

scheme, which is covered in Chapter 15. Specific to procedures, the MySQL permissions scheme

has the CREATE ROUTINE, ALTER ROUTINE, and EXECUTE privilege.

The permissions required for working with stored procedures are as follows:

Viewing permissions: To view stored procedures with SHOW PROCEDURE STATUS, you must

have SELECT access to the mysql.proc table. To be able to use the SHOW CREATE PROCEDURE,

you must have either SELECT access to the mysql.proc table or the ALTER ROUTINE privilege

for that particular procedure. Both SHOW PROCEDURE STATUS and SHOW CREATE PROCEDURE

were covered earlier in this chapter.

Calling permissions: To call a stored procedure, you need the ability to connect to the

server and have the EXECUTE permission for the procedure. EXECUTE permissions can be

granted globally (in the mysql.user table), at the database level (in the mysql.db table),

or for a specific routine (in the mysql.procs_priv table).

Creating and altering permissions: To govern creating and altering a stored procedure,

MySQL uses the CREATE ROUTINE and ALTER ROUTINE privilege. As with the EXECUTE privi-

lege, permissions for creating or changing procedures can be granted globally (in the

mysql.user table), at the database level (in the mysql.db table), or for a specific routine

(in the mysql.procs_priv table).

Dropping permissions: To drop a procedure, you must have the ALTER ROUTINE privilege.

Permissions for dropping procedures can be granted globally (in the mysql.user table),

at the database level (in the mysql.db table), or for a specific routine (in the mysql.

procs_priv table).

The success of a stored procedure call is also affected by the procedure’s SQL SECURITY

characteristic. If set to DEFINER, the procedure will be run with the permissions of the user

who created the procedure. Procedures will be run as the calling user if SQL SECURITY is set

to INVOKER. In either case, the INVOKER or DEFINER must have appropriate access to the tables

used in the stored procedure or calling the procedure will result in a permission error.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Having the option to run procedures with the permissions of the creator means that you

can create a set of procedures by a user with access to all of the tables, and allow a user who

has no permissions in the tables but does have the ability to connect to the server and execute

the procedure, to run it. This can be a simple, but excellent, way to simplify and enforce secu-

rity in your database.

WHAT’S MISSING IN MYSQL STORED PROCEDURES?

The MySQL AB developers continue to develop stored procedure features in MySQL. As of version 5.0.6, a

few documented statements are still missing from the syntax:

• SIGNAL: Used in a handler to return a SQLSTATE and message text.

• RESIGNAL: Allows you to indicate that a handler should send a SQLSTATE other than the one originally

caught.

• UNDO: Used in defining a handler. This handler type specifies that if a certain condition is reached, the

database should undo the statements previously run within the BEGIN . . . END block.

• FOR: Used to loop over a set of instructions a given number of times.

Summary

Stored procedures in MySQL are a welcome and exciting addition to the 5.0 release. While

there’s a lot of power, and perhaps some efficiency, in moving logic into your database, it’s

important to consider if and how procedures fit into your existing application. Hasty decisions

based on excitement to use cool technology usually lead to problems down the road.

As mentioned in the chapter, users should exercise caution in adopting the stored

procedure functionality until the stability of the 5.0 server matches their environment

requirements. For most users, waiting for the stable release is probably the best choice.

MySQL’s choice of SQL:2003 provides a good set of statements for developing procedures

and a standard for potential inter-database procedure exchange. MySQL provides a good set

of tools for creating, altering, dropping, and viewing procedures.

As MySQL developers continue to develop and flush out their implementation of stored

procedures, we look forward to further developments of the stored procedure functionality

and anxiously await the stable release of the 5.0 branch of MySQL.

In the next chapter, we’ll look at stored functions, another technology available in MySQL

versions 5.0 and later.


C H A P T E R   1 0

■ ■ ■

Functions

More than likely, you’re already familiar with database functions. If you haven’t defined

them yourself in a database that allowed user-defined functions, you’ve probably used one

or more of the functions built into your database. If you’ve ever stuck a LENGTH() function in

a query to find the number of bytes in a string, or used an UPPER() function to make the data

you select return in all uppercase letters, you’re familiar with at least the use of functions.

You may have encountered situations where, within a query, you’ve wanted to use one

of the built-in database functions to perform some simple calculation or manipulation on

a piece of data, but found that the database didn’t offer a function suitable to your needs. Or

maybe the database had a function that looked like it would work, but when you tried it, that

function didn’t give you the kind of results you wanted.

Stored functions, available in MySQL versions 5.0 and later, are the solution many need

for encapsulating pieces of logic. In this chapter, we’ll cover the following topics related to

stored functions:

• Uses of database functions

• Database functions compared with other database tools

• MySQL’s implementation of stored functions

• How to create stored functions

• An example of using functions

• How to view, change, and remove stored functions

• Stored function permissions

• Benchmarks to determine the overhead in using functions


C H A P T E R   1 0   ■ F U N C T I O N S

Database Function Uses

To illustrate the usefulness of stored functions, let’s look at how they might offer a solution

for a problem in the online store application we’ve used in previous chapters. Part of your

system is a table full of customer records. The customer records are used on your web site to

customize the users’ pages by displaying their name when they are at the site. In addition, the

data is used for mailing periodic promotional flyers and for invoicing wholesale customers.

Users create their own accounts on the site, and they can update their contact information

if it changes. The self-service account management leads to variations in the format of the

records. Many users use mixed uppercase and lowercase characters, but some users enter

data in all uppercase or all lowercase.

For your web site and mailings, you’re particularly interested in having the customer’s

first and last name look professional, with the first letter uppercase and the remainder lower-

case. To ensure the name is formatted correctly, you want to handle this as part of the queries

that pull data from the database, as opposed to in the code for the site or mailing list. MySQL

has built-in UPPER() and LOWER() functions, but a thorough review of the string functions

reveals nothing that will achieve the formatting you need. What you need is a function that

will take a string and return the string with the first character converted to uppercase and the

remainder in lowercase.

Stored functions to the rescue. MySQL versions 5.0 and later offer a means for defining

functions to be used in standard SQL statements for performing an endless number of tasks,

including calculations, data validation, data formatting, and data manipulation.

■Note As we write this chapter, MySQL has released version 5.0.6, which is labeled a beta release. While

the database is stable enough to test and document the functionality of stored functions, production users

are encouraged to wait until a release of the 5.0.x branch that is labeled production.

Database functions are a method for encapsulating logic that can be performed with any

number of input arguments, and require that one, and only one, value be returned. Database

functions are called within SELECT, INSERT, or UPDATE statements, generating values on the fly

to be used within the query to change data being saved into a table or returned in a set of

results. A function always returns a single, predefined type set in the definition of the function.

Examining MySQL’s built-in functions, you might conclude that a function is intended to

perform some calculation or manipulation of one or more values to return a value for output

from a SELECT statement or storage in the database (think of the LENGTH() function). When

building your own functions, you can also use other pieces of data (like a session variable)

as a part of the SQL statements that make up the function body. For example, if you created a

ucasefirst() function to solve the problem of customer name formatting, you would use it in

a SQL statement like this:

SELECT user_id, ucasefirst(firstname), ucasefirst(lastname),

email_address FROM user;

We’ll return to this sample ucasefirst() function at the very end of this chapter, after

we’ve covered the details of creating functions.


C H A P T E R   1 0   ■ F U N C T I O N S

Functions Compared with Other Database Tools

Database functions can be used in many ways, so you need to consider how to best use them

for your applications. Throughout this book, we continue to emphasize careful consideration

of the various database technologies as you design and implement your database. As you con-

sider the possible uses for functions in your application and database, you should be thinking

about how functions fit into the bigger picture and if a stored function in the database is the

best choice for the required logic. To help you figure this out, let’s take a look at how functions

compare with some other database tools for manipulating data: stored procedures, views, and

triggers.

While we can’t provide definitive answers as to where each tool fits best, we do suggest

that you think carefully about your overall database and application architecture, and keep

your use of the various database tools consistent and well documented.

Stored Functions vs. Stored Procedures

The syntax for defining the body of stored functions includes the same set of statements

defined for stored procedures, covered in Chapter 9. As we’ve discussed, MySQL’s stored

procedures provide a rich set of syntax to perform logic operations in the database. Like the

body of a procedure, the function body can include things like variables and flow constructs

to encapsulate both small and large pieces of functionality.

So why not just use stored procedures then? While you can do a lot with stored proce-

dures, they aren’t always the best fit for encapsulating pieces of logic. Furthermore, creating a

stored procedure for each piece of logic can be overkill, and needing to call and then process

the results from a procedure is sometimes more work that it’s worth if you need only a small

piece of data to use in another query.

A function can be used directly from within a SELECT, INSERT, or UPDATE statement, and

the result of that function is either saved in the table or returned with the output (depending

on whether you’re getting or saving data). Stored procedures may not return any results, or

they might return a large set of records for further processing and presentation. In contrast, a

stored function always returns a single value.1 The required single-value return makes a func-

tion perfect for logic needed within an existing query.

In summary, the main difference between stored procedures and database functions is

the way they are called and what they return. A stored procedure is executed with an explicit

statement: the CALL command. Stored procedures don’t necessarily return any value, but can

set OUT values and can return one or more data records. A stored procedure can also execute

without returning any data to the client.

Note that the debate surrounding the use of stored procedures, discussed in Chapter 9,

also applies to using stored functions (as well as views and triggers) in the database. Many of

the arguments for and against stored procedures also pertain to using functions in your data-

base, and you should be aware of these arguments when assessing the merits of incorporating

such features into your application.

1. The returned value can be NULL, if there is nothing for the function to return.


C H A P T E R   1 0   ■ F U N C T I O N S

Functions vs. Views

A view provides a way to create a virtual representation of data in one or more tables, which

might include calculating a value on the fly, as a part of the view definition. We will discuss

views in detail in Chapter 12. Here, we would like to point out some overlap they share with

functions.

Like a view, a function can be used to create a column of data on the fly. A difference is

that a function can include many rows of statements and conditional logic, whereas a view

can present only data that can be calculated or formatted within a single SQL SELECT statement.

Before jumping into defining a function, it might be wise to determine whether a view is

better suited to the task. Consider the data set in Listing 10-1, which contains a simple list of

entries from cust_order, a table responsible for representing customer orders.

Listing 10-1. Sample Listing from a Customer Order Table

Suppose you want to create a fourth column that is a calculation of the item_sum

multiplied by your current sales tax rate and added to the shipping to produce a total_cost

column.2 Based on a tax rate of 5%, this desired output might look something like Listing 10-2.

+---------------+----------+----------+

| cust_order_id | item_sum | shipping |

+---------------+----------+----------+

|             1 |    30.95 |    20.00 |

|             2 |    40.56 |    20.00 |

|             3 |   214.34 |    30.01 |

|             4 |   143.65 |    24.99 |

|             5 |   345.99 |    30.01 |

|             6 |   789.24 |    30.01 |

|             7 |     3.45 |    10.00 |

+---------------+----------+----------+

Listing 10-2. Sample Listing of Orders with Calculated Total

+---------------+----------+----------+--------+

| cust_order_id | item_sum | shipping | total  |

+---------------+----------+----------+--------+

|             1 |    30.95 |    20.00 |  52.50 |

|             2 |    40.56 |    20.00 |  62.59 |

|             3 |   214.34 |    30.01 | 255.07 |

|             4 |   143.65 |    24.99 | 175.82 |

|             5 |   345.99 |    30.01 | 393.30 |

|             6 |   789.24 |    30.01 | 858.71 |

|             7 |     3.45 |    10.00 |  13.62 |

+---------------+----------+----------+--------+

2. We’re assuming you want to have the database make this calculation, but it could be easily made in

the calling program as well as a part of the code’s business logic or presentation of the data.


C H A P T E R   1 0   ■ F U N C T I O N S

■Note Storing calculated columns is sometimes considered taboo in database design and administration

circles. But before you blindly agree, consider how not having a calculated column will affect your data. In

the example in Listing 10-2, the total is calculated on the fly and not stored in the database. What happens

when the tax rate increases? If you haven’t stored the total for your customer orders, you end up having old

orders in the system that start looking like they weren’t paid in full because the calculation of the total col-

umn now results in a slightly higher total than it did before the tax increase. It could be argued that the tax

rate could be stored in the table, or a tax table be kept with dates for when particular tax rates were active.

Gives you something to think about, right?

The output from Listing 10-2 has a fourth column, which contains the total cost of the

order, with shipping and tax included. This is fairly easily accomplished with a standard SQL

statement, as shown in Listing 10-3.

Listing 10-3. SELECT Statement with Total Calculated in SQL

mysql> SELECT cust_order_id, item_sum, shipping,

item_sum * .05 + item_sum + shipping AS total

FROM cust_order;

But you’re trying to get away from having your application build SQL statements that

contain calculations, so you’re looking at how a function might be able to encapsulate the

calculation made in the second line of Listing 10-3. You could generate the same output as

in Listing 10-2 by creating a calculate_total() function and using it in the SELECT, as shown

in Listing 10-4.

Listing 10-4. SELECT Statement with Total Calculated in Function

mysql> SELECT cust_order_id, item_sum, shipping,

calculate_total(item_sum,shipping)

AS total FROM cust_order;

Details on how to create the calculate_total() function are coming later in the chapter,

in the “Creating Functions” section (for now, just rest assured that it works). The SQL in Listing

10-4 abstracts the actual calculation of the total. However, it still requires a specific piece of

syntax, calculate_total(item_sum,shipping), to be written into the query. We’ll revisit Listings

10-3 and 10-4 when we talk about benchmarking the overhead in processing a function, in the

“Performance of Functions” section.

By using a view, the SELECT statement to output the same results from Listing 10-2 doesn’t

require any special syntax into the query. You can just run the SELECT against the view, which

represents total in a virtual column as part of the view definition. With a view, the calling SQL

doesn’t need to know anything about the calculation:

mysql> SELECT cust_order_id, item_sum, shipping, total FROM cust_order_view;


C H A P T E R   1 0   ■ F U N C T I O N S

Again, you’ll have to wait until Chapter 12 to get details on how to build a view to support

this query. This simple example demonstrates one instance where functions and views overlap

in their ability to solve a requirement. You can probably think of other scenarios where the two

overlap.

Which should you choose? We can’t answer that question because the decision ultimately

rests on the particular situation. If you are well versed in stored functions, and your database

administrator applauds the use of functions and heckles anyone who asks to have a view cre-

ated, you might be better off with the function. On the other hand, if you’ve designed your

database to include use of views to meet similar requirements elsewhere in your system, you

might find that a view fits better.

As a general rule, use a view when the calculation or manipulation is needed every time a

record is pulled from the table. If the virtual data is not required every time the data is retrieved,

it’s better to use a function that is put in the query only when the manipulated data is needed

as a part of the results.

Functions vs. Triggers

A trigger is a statement, or set of statements that are stored and associated with a particular

event, like an UPDATE or DELETE, that happens on a particular column or table. When the event

happens, the statements in the trigger are executed. We will cover triggers in detail in Chapter

13. Again, our purpose here is to point out where a trigger might be an alternative to a function.

The same example we used in the previous section to compare functions with views can

also be solved by using a trigger. You’ll recall that Listing 10-2 calculated the cost of various

items based on their price, shipping fee, and tax. Triggers provide a set of functionality that

would allow you to calculate the total whenever data is inserted or updated in the table, stor-

ing the total in the table without needing to specify the calculation in the SQL. While you can

get the output from Listing 10-2 to look identical, the solution isn’t exactly the same, because a

trigger requires you to actually store the calculated total in a real column.3 When using a func-

tion or a view, the total can be calculated on the fly and represented in a virtual data column.

You’ve now seen three different tools—functions, views, and triggers—as potential ways

to calculate the order total within the database. Isn’t it nice to have these choices?

Functions in MySQL

MySQL’s function implementation reflects the overall goal of MySQL AB: to provide a simple

but speedy database that doesn’t go overboard on providing unnecessary, or unnecessarily

complex, functionality. The syntax for creating stored functions in MySQL follows closely with

the SQL:2003 syntax used for creating stored procedures. Our experience with MySQL and

other databases shows that if you have ever dabbled in user-defined functions in Microsoft

SQL Server, DB2, Oracle, Informix, or PostgreSQL, creating functions in MySQL will be quite

familiar.

3.

Interestingly enough, you can actually use the function from within the trigger to perform the calcula-

tion of the value to be stored in the table when a trigger statement executes.


C H A P T E R   1 0   ■ F U N C T I O N S

■Note The official standard for syntax used to build stored functions is ISO/IEC 9075-x:2003, where x is a

range of numbers between 1 and 14 that indicate many different parts of the standard. For short, the stan-

dard is often referred to as SQL:2003, SQL-2003, or SQL 2003. We refer to the standard as SQL:2003, since

the official specification uses the colon (:) as a separator, and MySQL documentation uses this format. The

standard can be found on the ISO web site (http://www.iso.org) by doing a search for 9075. The stan-

dard is available for a fee.

Like stored procedures, MySQL functions are stored in the proc table in the mysql data-

base. Also, as with stored procedures, MySQL loads functions into memory when the database

starts up or when the function is created or modified. The server does not dynamically load

the function from where it is stored in the mysql.proc table when you issue a statement that

requires the function. Given the overlap between stored procedures and stored functions, it

shouldn’t surprise you that in the documentation, MySQL lumps both stored procedures and

functions into one term: routines.

USER-DEFINED AND NATIVE FUNCTIONS

In versions prior to 5.0, the options for adding functions to MySQL were to either create a user-defined

function (UDF) or add a native function. UDFs and native functions are still a part of MySQL in versions later

than 5.0.

The UDF requires writing a piece of code in C or C++ that is compiled and then referenced from

within MySQL with the CREATE FUNCTION statement. The CREATE FUNCTION statement includes a

SONAME keyword that tells MySQL where to find the shared object that will execute the logic of the function.

When MySQL starts, or when the CREATE FUNCTION statement is issued with the SONAME keyword, MySQL

loads in the active UDFs and makes them available for use in queries to the database (unless you started the

database with --skip-grant-tables; in which case, no functions are loaded).

To create a native function in MySQL, you are required to make modifications to the MySQL source

code, defining your function as a part of the source to be built in the MySQL binary.

In MySQL 5.0, the stored function shares the CREATE FUNCTION syntax with UDFs. The CREATE ➥

FUNCTION and other statements for building and managing functions also apply to the stored function,

which is a set of SQL statements stored in the database and loaded from the mysql.proc table when

MySQL starts up. There is no compiled C or C++ code involved in writing a stored function. The difference

between a stored function and a UDF is that in the CREATE statement, the stored function will have a set of

SQL statements, where the UDF will have the SONAME keyword that points to the compiled C or C++ code.

Because UDFs run on the system, not in the database, they have access to system information. Stored

functions, on the other hand, have access to data and settings in the MySQL server, but not to the system or

server. Depending on what logic you need from the function, one or the other may better suit your needs.

For documentation on creating native functions in MySQL, see http://dev.mysql.com/doc/

mysql/en/functions.html.


C H A P T E R   1 0   ■ F U N C T I O N S

Creating Functions

In our discussion about how stored functions fit in with other database tools, we hinted at

using a function to calculate some values on the fly. In this first example, we aim to show you

just how simple creating a function can be. Let’s review the customer order scenario we pre-

sented earlier in our discussion of functions versus other database tools. Listing 10-5 shows

some sample data from a table that contains customer orders.

Listing 10-5. Sample Listing from a Customer Order Table

+---------------+----------+----------+

| cust_order_id | item_sum | shipping |

+---------------+----------+----------+

|             1 |    30.95 |    20.00 |

|             2 |    40.56 |    20.00 |

|             3 |   214.34 |    30.01 |

|             4 |   143.65 |    24.99 |

|             5 |   345.99 |    30.01 |

|             6 |   789.24 |    30.01 |

|             7 |     3.45 |    10.00 |

+---------------+----------+----------+

You are trying to generate a fourth column representing the total cost, which is the

item_sum with 5% sales tax and the shipping charges added. Listing 10-6 shows the CREATE

statement for the calculate_total() function.

Listing 10-6. CREATE Statement for calculate_total()

CREATE FUNCTION calculate_total

(cost DECIMAL(10,2), shipping DECIMAL(10,2))

RETURNS DECIMAL(10,2)

RETURN cost * 1.05 + shipping;

Listing 10-6 presents a CREATE statement with a function name, two incoming parameters,

a declaration of the type that will be returned, and a body. The body consists of a single state-

ment that returns the calculation of the cost, multiplied by the tax and added to the shipping

cost.

Any SELECT statement using the function simply needs to pass the correct parameters to

the function, as shown in Listing 10-7.

Listing 10-7. Using the calculate_total() Function

mysql> SELECT cust_order_id, item_sum, shipping,

calculate_total(item_sum,shipping) AS total

FROM cust_order;

When the query is executed, the function will be called for each row, performing the cal-

culation and returning the result to be included in the output of the resultset. The resulting

output is shown in Listing 10-8.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-8. Output from SELECT Using the calculate_total() Function

+---------------+----------+----------+--------+

| cust_order_id | item_sum | shipping | total  |

+---------------+----------+----------+--------+

|             1 |    30.95 |    20.00 |  52.50 |

|             2 |    40.56 |    20.00 |  62.59 |

|             3 |   214.34 |    30.01 | 255.07 |

|             4 |   143.65 |    24.99 | 175.82 |

|             5 |   345.99 |    30.01 | 393.30 |

|             6 |   789.24 |    30.01 | 858.71 |

|             7 |     3.45 |    10.00 |  13.62 |

+---------------+----------+----------+--------+

7 rows in set (0.00 sec)

CREATE Statement

As you’ve seen, a function is brought into existence in the database with a CREATE statement.

This statement requires a function name, some input parameters, a return type, and one or

more SQL statements in the function body with at least one return statement. The complete

CREATE statement syntax looks like this:

CREATE FUNCTION [database.]<name> (<input parameters>)

RETURNS <data type> [characteristics] <body>;

The syntax for building functions allows for endless possibilities for putting pieces of logic

under a simple interface for calling from within your SQL statements. Let’s examine the pieces

of the statement and discuss how each affects the behavior of the function.

■Tip Before you embark on defining functionality to encapsulate a bit of processing, check the MySQL

documentation on the existing built-in functions. MySQL provides a rich set of functions for manipulating

strings, numbers, dates, full-text search, variable casts, and groupings.

Function Name

The name of the stored function must not be the same as another stored function in the data-

base. It can be the same as a built-in function (although we strongly discourage it), in which

case you refer to the stored function by using a space between the name and the opening

parenthesis for input parameters. The name of any database in the system can be prepended

to the function name to create a stored function outside the currently active database.

■Tip For clarity and consistency, you may want to have your style guide require that SQL statements

always include a space after the function name when using stored functions. This will prevent the accidental

use of a built-in function. Calling a nonexistent stored function resulting in an error is better than using the

wrong function and moving on with erroneous data.


C H A P T E R   1 0   ■ F U N C T I O N S

For example, if you want to create a procedure to determine the amount of tax that

should be added to the order, your function name might be calculate_tax:

CREATE FUNCTION calculate_tax . . .

Input Parameters

Enclosed in parentheses after the function name is a list of input parameters that are required

to run the function, along with the data type that is expected for the parameter. Each parameter

must have a name and a data type. The data type can be any valid MySQL data type. Parameters

are separated by a comma. For example, if you were going to accept a dollar amount in your

calculate_tax() function, the input parameters would be added immediately after the function

name:

CREATE FUNCTION calculate_tax (cost DECIMAL(10,2)) . . .

When calling a stored function, if you do not specify the correct number of parameters,

MySQL will return an error indicating an incorrect number of arguments.

■Note In Chapter 9, we explained how procedure parameters can be specified as IN, OUT, or INOUT.

Stored functions do not allow for this syntax. All parameters after the function name are passed into the

function, and the only value that comes out of the function is the return. A CREATE FUNCTION statement will

fail if the IN, OUT, or INOUT syntax is used in defining the parameters, because these keywords are not part

of the CREATE FUNCTION statement.

Return Value

The stored function is required to have the RETURNS keyword with a valid MySQL data type. The

RETURNS keyword comes directly after the input parameters, and is followed by the data type:

CREATE FUNCTION calculate_tax (cost DECIMAL(10,2))

RETURNS DECIMAL(10,2)

. . .

When the function is called, the result of the function will be placed in the query as the

value to be returned with the record (for SELECT) or saved into the table (for INSERT and

UPDATE).

■Caution With both input and return values in a function, the data type is required to define the function.

However, when calling the function, MySQL doesn’t verify that you are passing in the correct data type.

Passing in an unmatching data type can lead to some interesting and unpredictable results. MySQL will cast

the values into the appropriate type for the function, which leads to return values that might be different than

expected. For your own sanity, make sure that when you call a function, you pass in arguments with the cor-

rect data type and use the returned data type appropriately.


C H A P T E R   1 0   ■ F U N C T I O N S

Characteristics

Characteristics in the definition of a stored function give the parser hints as to how the func-

tion is written and should be processed. Table 10-1 describes the available characteristics.

Table 10-1. Characteristics Used to Create a Stored Function

Characteristic

Value

Description

[NOT] DETERMINISTIC

MySQL currently accepts this keyword but does

nothing with it. In the future, setting a function

to be deterministic will tell the query parser that

for a given set of parameters, the results will

always be the same. Knowing a function is

deterministic will allow the MySQL server to

optimize the use of the function. The default is

NOT DETERMINISTIC. The DETERMINISTIC

characteristic isn’t allowed in function ALTER

statements.

The language that was used to write the body

of the function. Currently, SQL is the only valid

option (and the default). MySQL has suggested

that in the future, other languages will be

supported.

Tells MySQL which user to use for permissions

when running a function. If it’s set to DEFINER,

the stored function will be run using the

privileges of the user who created the function.

If INVOKER is specified, the user calling the

function will be used for obtaining access to the

tables. DEFINER is the default if this characteristic

is not specified.

A place to enter notes about a stored function.

The comment is displayed in SHOW CREATE ➥

FUNCTION commands.

LANGUAGE

SQL

SQL SECURITY

DEFINER or INVOKER

COMMENT

■Caution The COMMENT characteristic is an extension to SQL:2003, which means that functions with a

comment in the definition may not easily move to another SQL:2003-compliant database.

In the CREATE statement, characteristics are entered immediately following the return data

type. For a function where you want to be sure the caller’s permissions are used in running the

function, add that syntax, as follows:

CREATE FUNCTION calculate_tax (cost DECIMAL(10,2))

RETURNS DECIMAL(10,2)

SQL SECURITY DEFINER

. . .


C H A P T E R   1 0   ■ F U N C T I O N S

The Function Body

The body of the stored function is a collection of SQL statements that contain the logic to take

place in the function. As you saw in the example in Listing 10-6, the body can consist of one

simple statement. While the single-statement function is useful, you can do considerably

more in a function by using multiple statements. The length of the body is limited to 64KB

of data, because the body is stored in a BLOB field.4

If you’ve dabbled in stored procedures (and/or read Chapter 9), the syntax used for func-

tions will be familiar, because it’s the same. Here, we’ll review blocks, declarations, variables,

and flow constructs as they are used in functions.

BEGIN . . . END Statements

The BEGIN and END statements are used to group statements, and they are required for func-

tions with more than one SQL statement. Any declarations must be made within this block

and appear before any other statements in a BEGIN . . . END block.

The block can be modified with labels for clarifying code, as shown in Listing 10-9. The

label on the BEGIN and END must match exactly.

Listing 10-9. BEGIN . . . END Block with Labels

DELIMITER //

CREATE FUNCTION calculate_tax (cost DECIMAL(10,2))

RETURNS DECIMAL(10,2)

SQL SECURITY DEFINER

tax: BEGIN

DECLARE order_tax DECIMAL(10,2);

SET order_tax = cost * .05;;

RETURN order_tax;

END tax

//

DELIMITER ;

As when you’re creating a stored procedure with multiple statements, when entering mul-

tiple statement blocks into MySQL, change the default delimiter to something other than a

semicolon (;), so MySQL will allow you to enter a semicolon without having the client process

the input. Change the delimiter by using the delimiter statement: DELIMITER //. When you’re

ready to have your function created, type //, and the client will process the entire set of state-

ments that make up your stored function. When you’re finished working on your functions,

change the delimiter back to the standard semicolon with DELIMITER ;.

4. A storage amount of 64KB for the function body allows you to store around 1,000 lines of code, pro-

vided you average 60 characters on each line.


C H A P T E R   1 0   ■ F U N C T I O N S

DECLARE Statements

As demonstrated in Listing 10-9, the DECLARE statement is used to create local variables,

conditions, handlers, and cursors within the procedure. DECLARE can be used only in the first

statements immediately within a BEGIN block. The declarations must occur variables first, cur-

sors second, and handlers last. A common declaration is the local variable, which is done with

a variable name and type:

DECLARE <name> <data type> [default];

The default value is optional when declaring a variable.

The following is an example of declaring an integer named order_tax with an initial

DECLARE order_tax DECIMAL(10,2) DEFAULT 0;

Here, we’ll take a closer look at declaring variables, conditions, and handlers. Cursors,

which are also created with the DECLARE statement, are covered in more detail in Chapter 11.

value of 0:

Variables

Functions can access and set local, session, and global variables. Local variables are either

passed in as parameters or created using the DECLARE statement, and are used in the stored

function by referencing the name of the parameter or declared variable.

LOCAL, SESSION, AND GLOBAL VARIABLES IN MYSQL

MySQL has three different kinds of variables:

• Local variables: These variables are set in the scope of a statement or block of statements. Once that

statement or block of statements has completed, the variable goes out of scope. An example of a local

variable is order_tax: DECLARE order_tax DECIMAL(10,2);.

• Session variables: These variables are set in the scope of your session with the MySQL server. A ses-

sion starts with a connection to the server and ends when the connection is closed. Variables can be

created and referenced throughout the time you maintain your connection to the MySQL server, and go

out of scope once the connection is terminated. Variables created during your connection cannot be

referenced from other sessions. To declare or reference a session variable, prefix the variable name

with an @ symbol: SET @total_count = 100;.

• Global variables: These variables exist across connections. They are set using the GLOBAL keyword:

SET GLOBAL max_connections = 300;. Global variables are not self-defined, but are tied to the

configuration of the running server. As shown, the global variable max_connections is used by

MySQL to determine how many concurrent sessions, or connections, it will allow.


C H A P T E R   1 0   ■ F U N C T I O N S

You can set variables in several ways. Using the DECLARE statement with a DEFAULT will set

the value of a local variable, as shown in the previous example.

Values can be assigned to local, session, and global variables using the SET statement:

SET @total_shipping_cost = @total_shipping_cost + 5.00;

MySQL’s SET statement includes an extension that permits setting multiple variables in

one statement:

SET shipping_cost = 5, @total_shipping_cost = @total_shipping_cost + 5.00;

Note that this extension is not SQL:2003-compliant.

Conditions and Handlers

By declaring conditions and handlers, MySQL allows you to catch certain MySQL errors or

SQLSTATE conditions. Errors are raised for many different reasons (MySQL includes more than

2,000 error conditions), but are predominantly centered on permissions, changes in the data-

base structure, and changes in the data. Declaring conditions and handlers in functions works

just as it does in stored procedures, which was covered in detail in Chapter 9.

Listing 10-10 shows an example of declaring a condition and handling the rise of that

condition.

DELIMITER //

Listing 10-10. Declaring a Condition and Handler

CREATE FUNCTION perform_logic (some_input INT(10)) returns INT(10)

BEGIN

DECLARE problem CONDITION FOR 1265;

DECLARE EXIT HANDLER FOR problem

RETURN NULL;

# do some logic, if the problem condition is met

# the function will exit, returning a NULL

RETURN 1;

END

//

DELIMITER ;

In this example, the MySQL error number 1265 means that data was truncated when sav-

ing to a table. Any truncated field would raise the condition and cause the function to exit

with a return of NULL. The complete list of SQLSTATE values and MySQL error codes is available

at http://dev.mysql.com/doc/mysql/en/error-handling.html.


C H A P T E R   1 0   ■ F U N C T I O N S

Flow Constructs

SQL:2003 flow constructs give you a number of statements to control and organize your state-

ment processing. MySQL supports IF, CASE, LOOP, LEAVE, ITERATE, REPEAT, and WHILE, but does

not currently support the FOR statement.

Flow controls for functions are identical to flow controls for stored procedures, which

were discussed in Chapter 9. Here, we’ll review the constructs and look at some examples using

functions. We’ll begin with the IF and CASE constructs for checking values, and then turn our

attention to the looping constructs: LOOP, LEAVE, ITERATE, REPEAT, and WHILE statements.

IF

The IF statement checks a condition and runs the statements in the block if the condition is

true. If needed, you can add ELSEIF statements to continue attempting to match conditions,

and you can include a final ELSE statement. Listing 10-11 shows a piece of a function where

the shipping cost is being calculated based on the number of days the customer is willing to

wait for delivery. delivery_day is an integer parameter passed into the function when it’s

called.

Listing 10-11. IF Statement

DELIMITER //

CREATE FUNCTION delivery_day_shipping (delivery_day INT(1)) RETURNS INT(2)

BEGIN

DECLARE shipping_cost INT(2) DEFAULT 0;

IF delivery_day = 1 THEN

SET shipping_cost = 20;

ELSEIF delivery_day = 2 THEN

SET shipping_cost = 15;

ELSEIF delivery_day = 3 THEN

SET shipping_cost = 10;

SET shipping_cost = 5;

ELSE

END IF;

RETURN shipping_cost;

END

//

DELIMITER ;


C H A P T E R   1 0   ■ F U N C T I O N S

CASE

For checking a uniform condition, you can use a CASE construct rather than an IF construct.

Listing 10-12 shows how to use a CASE statement to accomplish the same conditions as the

previous IF . . . ELSEIF . . . ELSE statement in Listing 10-11. Not only do they improve the read-

ability of your code, but CASE statements generally run faster than the corresponding IF

constructs. In this example, the integer parameter delivery_day is passed into the function

from the caller.

Listing 10-12. CASE Statement in a Function

DELIMITER //

CREATE FUNCTION delivery_day_shipping (delivery_day INT(1)) RETURNS INT(2)

BEGIN

DECLARE shipping_cost INT(2) DEFAULT 0;

CASE delivery_day

WHEN 1 THEN

SET shipping_cost = 20;

SET shipping_cost = 15;

SET shipping_cost = 10;

WHEN 2 THEN

WHEN 3 THEN

ELSE

SET shipping_cost = 5;

END CASE;

RETURN shipping_cost;

END

//

DELIMITER ;

■Caution Unlike IF statements, CASE statements must find a match; otherwise, MySQL will return an

error. However, you can get around this by using an ELSE statement, which makes sure that a catchall exe-

cutes when no other condition is met.

The CASE control can also operate without an initial case value, evaluating a different condi-

tion on each WHEN statement. This is useful if you want to check different conditions in the same

CASE statement. Listing 10-13 shows the shipping calculator using this syntax. The function is

similar to the one in Listing 10-12, but adds the ability to pass in a preferred status. If preferred

is 1, the shipping is always returned as 2, a special shipping price for preferred customers. By

using the CASE statements with the condition checked on each line, you can first check the case

where preferred is set, and then move on to the other cases. As with Listing 10-12, Listing 10-13

runs significantly faster than the IF-based logic in Listing 10-11.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-13. CASE Statement with Condition Checks

DELIMITER //

CREATE FUNCTION delivery_day_shipping (delivery_day INT(1),preferred INT(1))

RETURNS INT(2)

BEGIN

DECLARE shipping_cost INT(2) DEFAULT 0;

CASE

WHEN preferred = 1 THEN

SET shipping_cost = 2;

WHEN delivery_day = 1 THEN

SET shipping_cost = 20;

WHEN delivery_day = 2 THEN

SET shipping_cost = 15;

WHEN delivery_day = 3  THEN

SET shipping_cost = 10;

ELSE

SET shipping_cost = 5;

END CASE;

RETURN shipping_cost;

END

//

DELIMITER ;

LOOP and LEAVE

The LOOP statement creates a repeating loop that will run until the LEAVE statement is invoked.

Optional to the LOOP is a label, which is a name and a colon prepended to the LOOP statement,

with the identical name appended to the END LOOP statement. To exit the loop, a LEAVE state-

ment can be invoked. The LEAVE keyword requires a loop label. The LEAVE statement must be

accompanied by a label, which means that to use a LEAVE, you must have a name assigned to

the loop.

Listing 10-14 demonstrates use of both LOOP and LEAVE in the round_down_tenth() func-

tion. This function takes an integer and returns the next lowest integer that is a multiple of

ten. Where is this useful? Suppose you are dynamically creating a graph of number of orders

each day for the past month, but for clarity, you want to center numbers around multiples of

ten, but not round up and risk presenting data that’s not based in reality. round_down_tenth()

will give you the closest multiple of ten lower than the number passed to the function.

Listing 10-14. LOOP Statement with LEAVE

DELIMITER //

CREATE FUNCTION round_down_tenth (quantity INT(10)) RETURNS INT(10)

BEGIN


C H A P T E R   1 0   ■ F U N C T I O N S

increment: LOOP

IF quantity MOD 10 < 1 THEN

LEAVE increment;

END IF;

SET quantity = quantity - 1;

END LOOP increment;

RETURN quantity;

END

//

DELIMITER ;

ITERATE

increment: LOOP

IF quantity MOD 12 > 0 THEN

SET quantity = quantity + 1;

ITERATE increment;

END IF;

IF quantity MOD 8 < 1 THEN

LEAVE increment;

END IF;

SET quantity = quantity + 1;

END LOOP increment;

The ITERATE statement is used in the LOOP, WHILE, and REPEAT controls to indicate that control

should iterate through the statements in the loop again. You can use this to prevent the loop

from reaching a secondary piece of logic until the looping has satisfied the first condition.

For example, suppose you needed to order a supply of baseball caps, based on the volume

of orders from last month. The supplier provides them by the dozen, so you are required to

order them in quantities of 12. However, you sell them in batches of 8, so you want to make

sure that the quantity you order will match the requirements of both the supplier and your

sales. Listing 10-15 shows a function that can accomplish this by finding the next highest

multiple of two numbers.

Listing 10-15. LOOP Statement with ITERATE

DELIMITER //

CREATE FUNCTION find_common_multiple (quantity INT(10)) RETURNS INT(10)

BEGIN


C H A P T E R   1 0   ■ F U N C T I O N S

RETURN quantity;

END

//

DELIMITER ;

WHILE . . . DO

Using the find_common_multiple() function first finds a multiple of 12, iterating in a

smaller loop because of the ITERATE increment statement early in the logic. Once a dozen is

found, the loop then considers if the number is also a multiple of 8; if not, it increments the

quantity and goes back to the first condition.

Another mechanism to loop over a set of statements until a condition is true is the WHILE state-

ment. Unlike LOOP, where the condition is met within the loop, the WHILE statement requires

specification of the condition when defining the statement. As with LOOP constructs, a label

can be placed before and after the WHILE constructs.

Listing 10-16 shows a simple use of this statement in a function that takes an integer

and returns the next value that is a multiple of 12. This kind of function is helpful if you have

something like an order fulfillment system that automatically submits an order for restocking

of the warehouse based on last month’s order volume, but is required to order by the dozen.

Listing 10-16. WHILE Statement

DELIMITER //

CREATE FUNCTION round_up_dozen (quantity INT(10)) RETURNS INT(10)

BEGIN

WHILE quantity MOD 12 > 0 DO

SET quantity = quantity + 1;

END WHILE;

RETURN quantity;

END

//

DELIMITER ;

REPEAT

To loop over a set of statements until a post-statement condition is met, use the REPEAT

statement. The REPEAT statement ensures that your instructions will be run at least once.

Building on a previous example, let’s say that each month you take the quantity of a prod-

uct sold and place an order for that many, plus whatever it takes to make the ordered quantity

come out in dozens. But you need to have at least one of the products available every month

for a charity donation, so you really need the amount sold last month, plus one for this month

rounded up to the nearest dozen. The function in Listing 10-17 does just that.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-17. REPEAT Statement

DELIMITER //

CREATE FUNCTION order_quantity (quantity INT(10)) RETURNS INT(10)

BEGIN

REPEAT

SET quantity = quantity + 1;

UNTIL quantity MOD 12 = 0

END REPEAT;

RETURN quantity;

END

//

The function in Listing 10-17 first adds one to the incoming quantity before it starts the

process of determining when it will reach the next quantity divisible by 12.

■Caution When a stored function is created, the syntax of the body isn’t fully checked to determine if the

function will fail at runtime. You should verify the validity of each function by testing it with a sample data set

before releasing it into production.

Using Functions

As you’ve seen, functions are executed by using the function name from within SELECT, INSERT,

and UPDATE statements. When using functions, you can prepend the database name to the

function name. If the function you are referencing doesn’t exist in the currently active data-

base, a function does not exist error will occur.

In this section, we’ll take a look at a stored function that uses several of the available

statements.

■Note Although the examples in this chapter focus on numeric calculations and text manipulation, stored

functions can also access data in your tables with SQL statements like SELECT . . . INTO or UPDATE to

retrieve and manipulate data in your tables.

For the client, order data includes a date the order was placed, a sum of all the items on

the order, and a column that contains the number of days until the customer wants the order

delivered to a home or work address (contained in the rush_ship column). Listing 10-18 shows

the table output.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-18. Sample Listing from the order Table

+---------------+------------+----------+------------------+

| cust_order_id | order_date | item_sum |        rush_ship |

+---------------+------------+----------+------------------+

|             1 | 2005-08-31 |    30.95 |                1 |

|             2 | 2005-08-27 |    40.56 |                3 |

|             3 | 2005-09-27 |   214.34 |             NULL |

|             4 | 2005-09-01 |   143.65 |             NULL |

|             5 | 2005-09-10 |   345.99 |                5 |

|             6 | 2005-08-28 |   789.24 |                1 |

|             7 | 2005-09-01 |     3.45 |                1 |

+---------------+------------+----------+------------------+

7 rows in set (0.00 sec)

Your client has provided you with a few rules on how to calculate the shipping, rush ship-

ping, and tax charges. Your client wants to be able to see this data, along with the total for the

customer’s order. Based on the client-provided information, you will create a number of func-

tions to generate this data. Let’s start with a calc_tax() function, as shown in Listing 10-19,

which takes the item cost and returns the amount of tax required.

Listing 10-19. Function to Calculate Tax

DELIMITER //

CREATE FUNCTION calc_tax (cost DECIMAL(10,2)) RETURNS DECIMAL(10,2)

RETURN cost * .05

//

DELIMITER ;

The next function will calculate the shipping charges, based on the sum of the items.

Listing 10-20 shows the calc_shipping() function, which calculates the shipping charges

based on the sum of the items and the client’s shipping ranges.

Listing 10-20. Function to Calculate Shipping

DELIMITER //

CREATE FUNCTION calc_shipping (cost DECIMAL(10,2)) RETURNS DECIMAL(10,2)

BEGIN

DECLARE shipping_cost DECIMAL(10,2);

SET shipping_cost = 0;

IF cost < 25.00 THEN

SET shipping_cost = 10.00;

ELSEIF cost < 100.00 THEN

SET shipping_cost = 20.00;

ELSEIF cost < 200.00 THEN

SET shipping_cost = 30.00;


C H A P T E R   1 0   ■ F U N C T I O N S

ELSE

END IF;

SET shipping_cost = 40.00;

RETURN shipping_cost;

END

//

DELIMITER ;

Listing 10-20 takes the cost of the items in the order and returns a flat-rate shipping charge.

Now that you have the shipping charge, you need to add in any additional rush-shipping charges,

depending on how many days the customer is willing to wait for the package to arrive. Listing 10-21

shows the calc_rush_shipping() function, which has the breakdown of days and costs.

Listing 10-21. Function to Calculate Rush Shipping Charges

DELIMITER //

CREATE FUNCTION calc_rush_shipping (rush_ship INT(10)) RETURNS DECIMAL(10,2)

BEGIN

DECLARE rush_shipping_cost DECIMAL(10,2);

SET rush_shipping_cost = 20.00;

SET rush_shipping_cost = 15.00;

SET rush_shipping_cost = 10.00;

SET rush_shipping_cost = 0.00;

RETURN rush_shipping_cost;

CASE rush_ship

WHEN 1 THEN

WHEN 2 THEN

WHEN 3 THEN

ELSE

END CASE;

END

//

DELIMITER ;

Lastly, you need a calc_total() function, which will calculate the total of all these items.

Listing 10-22 shows the CREATE statement for a function that takes two arguments, and calls

the calc_tax(), calc_shipping(), and calc_rush_shipping() functions to create a total cost

for this customer’s order.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-22. Function to Calculate Total Cost

DELIMITER //

CREATE FUNCTION calc_total (item_sum DECIMAL(10,2), rush_ship INT(10))

RETURNS DECIMAL(10,2)

BEGIN

DECLARE order_total DECIMAL(10,2);

SET order_total = item_sum + calc_tax(item_sum) +

calc_shipping(item_sum) + calc_rush_shipping(rush_ship);

RETURN ROUND(order_total,2);

END

//

DELIMITER ;

The calc_total() function takes the item_sum and rush_ship values and encapsulates the

three previously created functions to create a total order cost.

Notice how functions can be called from within functions. In Listing 10-22, the calc_total()

function calls the calc_tax(), calc_shipping(), and calc_rush_shipping() functions to create a

calculation of the return values from all three.

■Note Theoretically, there is no limit to the number of layers in defining functions. However, you might

start to find that after just a few layers, keeping track of them becomes unwieldy. Again, it’s always good to

plan the implementation details before doing something like embarking on a multilevel function scheme.

Also, notice that the function definition in Listing 10-22 uses the built-in ROUND()

function. For all of these function and variable declarations, the data type is DECIMAL(10,2),

which should give a dollar and cent decimal, but when all the functions were compiled

together in the calc_total() function, digits four and five places to the right of the decimal

started to appear. To ensure that the results make sense for the application or client, the

ROUND() function forces the data to output with just two decimal places.

The query to get the information the client has requested is shown in Listing 10-23.

Listing 10-23. SELECT Statement Using Created Functions

SELECT cust_order_id AS id, order_date, item_sum, rush_ship,

calc_tax(item_sum) AS tax,

calc_shipping(item_sum) AS shipping,

calc_rush_shipping(rush_ship) AS rush,

calc_total(item_sum,rush_ship) AS total

FROM cust_order;


C H A P T E R   1 0   ■ F U N C T I O N S

The output from this query produces a nice table filled with the appropriate results, as

shown in Listing 10-24.

Listing 10-24. Output from SELECT Using Created Functions

+----+------------+----------+-----------+-------+----------+-------+--------+

| id | order_date | item_sum | rush_ship | tax   | shipping | rush  | total  |

+----+------------+----------+-----------+-------+----------+-------+--------+

|  1 | 2005-08-31 |    30.95 |         1 |  1.55 |    20.00 | 20.00 |  72.50 |

|  2 | 2005-08-27 |    40.56 |         3 |  2.03 |    20.00 | 10.00 |  72.59 |

|  3 | 2005-09-27 |   214.34 |      NULL | 10.72 |    40.00 |  0.00 | 265.06 |

|  4 | 2005-09-01 |   143.65 |      NULL |  7.18 |    30.00 |  0.00 | 180.83 |

|  5 | 2005-09-10 |   345.99 |         5 | 17.30 |    40.00 |  0.00 | 403.29 |

|  6 | 2005-08-28 |   789.24 |         1 | 39.46 |    40.00 | 20.00 | 888.70 |

|  7 | 2005-09-01 |     3.45 |         1 |  0.17 |    10.00 | 20.00 |  33.62 |

+----+------------+----------+-----------+-------+----------+-------+--------+

7 rows in set (0.00 sec)

Managing Functions

After you’ve created a collection of functions in the database, you’ll likely need to manage

them. As with stored procedures, you can view, change, and remove stored functions.

Viewing Functions

MySQL offers several ways to view the existing functions in your database. To see all of

the functions across all databases, use the SHOW FUNCTION STATUS command, as shown in

Listing 10-25.

■Note In the examples here, we use the \G switch from the mysql client utility to display the results in

rows, rather than in columns.

Listing 10-25. Output of SHOW FUNCTION STATUS

mysql> SHOW FUNCTION STATUS\G

*************************** 1. row ***************************

Db: shop

Name: calc_rush_shipping

Type: FUNCTION

Definer: mkruck@localhost

Modified: 2005-02-09 20:13:06

Created: 2005-02-09 20:13:06

Security_type: DEFINER

Comment:


*************************** 2. row ***************************

C H A P T E R   1 0   ■ F U N C T I O N S

*************************** 3. row ***************************

*************************** 4. row ***************************

Db: shop

Name: calc_shipping

Type: FUNCTION

Definer: mkruck@localhost

Modified: 2005-02-09 20:13:06

Created: 2005-02-09 20:13:06

Security_type: DEFINER

Comment:

Db: shop

Name: calc_tax

Type: FUNCTION

Definer: mkruck@localhost

Modified: 2005-02-09 20:13:06

Created: 2005-02-09 20:13:06

Security_type: DEFINER

Comment:

Db: shop

Name: calc_total

Type: FUNCTION

Definer: mkruck@localhost

Modified: 2005-02-09 20:13:06

Created: 2005-02-09 20:13:06

Security_type: DEFINER

Comment:

4 rows in set (0.00 sec)

This command displays a few pieces of information about each function in all databases.

The Db indicates the database where the function is defined, and the Name indicates the name

used to create and call the function. For SHOW FUNCTION STATUS, the Type will always have a

value of FUNCTION. The Definer is the person who created the function.

■Note The definer of a function is not changed when an ALTER statement is processed for a function.

To change who defined a function, the function must be dropped and then re-created by the desired user.

The Modified and Created fields tell you when the function was last changed and when it

was first created in the database, respectively. The Security_type indicates whether the func-

tion is being executed using the permissions of the user who defined the function or the user

who is calling the function.

The SHOW FUNCTION STATUS command presents a nice summary, but to see what’s in a

function, you’ll want to use the SHOW CREATE FUNCTION command. Listing 10-26 shows the

output of this statement for the calc_total() function.


C H A P T E R   1 0   ■ F U N C T I O N S

Listing 10-26. Output of SHOW CREATE FUNCTION

mysql> SHOW CREATE FUNCTION shop.calc_total\G

*************************** 1. row ***************************

Function: calc_total

sql_mode:

Create Function: CREATE FUNCTION `shop`.`calc_total`(item_sum decimal(10,2),

rush_ship int) RETURNS decimal(10,2)

begin

declare order_total decimal(10,2);

set order_total = item_sum + calc_tax(item_sum) +

calc_shipping(item_sum) + calc_rush_shipping(rush_ship);

return round(order_total,2);

end

This command lets you view the CREATE statement for any function in any database.

It provides the name, SQL mode, and the CREATE statement.

In Listings 10-25 and 10-26, you don’t see the deterministic and language settings. If you

want to get at the raw data for a function, and you have access to the mysql database, you can

select information from the mysql.proc table and get all the underlying data. A raw view of

the data gives you slightly more information than what you can get from the SHOW commands.

For example, Listing 10-27 shows the SELECT statement for the calc_total() function and its

output.

Listing 10-27. Output of Function Data from mysql.proc Table

SELECT * FROM mysql.proc WHERE name = 'calc_total'\G

*************************** 1. row ***************************

db: shop

name: calc_total

type: FUNCTION

specific_name: calc_total

language: SQL

sql_data_access: CONTAINS_SQL

is_deterministic: NO

security_type: DEFINER

param_list: item_sum decimal(10,2), rush_ship int

returns: decimal(10,2)

body: begin

declare order_total decimal(10,2);

set order_total = item_sum + calc_tax(item_sum) +

calc_shipping(item_sum) + calc_rush_shipping(rush_ship);

return round(order_total,2);

end

definer: mkruck@localhost

created: 2005-02-09 20:45:53

modified: 2005-02-09 20:45:53

sql_mode:

comment:


C H A P T E R   1 0   ■ F U N C T I O N S

Here, you see the various pieces of the function, including language and is_deterministic,

broken into separate fields. This view of the defined functions is cleaner if you are looking for a

quick list of parameters or return types.

Changing and Removing Functions

MySQL provides an ALTER statement for stored functions, but as with stored procedures, the

ALTER statement can change only the characteristics of a function, not the SQL statements that

make up the body. The ALTER statement has the following syntax:

ALTER FUNCTION [database.]<name> <characteristics>;

Here is an example:

mysql> ALTER FUNCTION shop.calc_total

COMMENT 'encapsulate all functions for one big total';

You can change multiple characteristics within a single ALTER statement. If a characteris-

tic isn’t specified in the statement, the value is left as it was when the function was created.

You can change all the characteristics listed in Table 10-1, shown earlier in the chapter, with

one exception: the DETERMINISTIC characteristic isn’t allowed in the ALTER statement.

To remove a stored function, use the DROP command:

DROP FUNCTION [database.]<name>

Here is an example:

mysql> DROP FUNCTION shop.calc_shipping;

As expected, the DROP statement removes the function from the mysql.proc table.

Function Permissions

When speaking of permissions in regard to stored functions, two main sets are involved:

permissions to create and manage stored functions, and permissions to use functions.

To create a function in a database, the user must have the CREATE ROUTINE privilege.

To change an existing function, the user must have the ALTER ROUTINE privilege. Permissions

for creating or changing procedures can be granted globally (in the mysql.user table), at the

database level (in the mysql.db table), or for a specific routine (in the mysql.procs_priv table).

To use a function, the caller must have the EXECUTE privilege for the particular database.

When the function is called, the actions in the function are performed either by the user

who is executing the function or the user who defined the function, depending on if the

SQL SECURITY is set to DEFINER or INVOKER. As with the CREATE and ALTER statements, permissions

for executing a function can be granted globally (in the mysql.user table), at the database level

(in the mysql.db table), or for a specific routine (in the mysql.procs_priv table).

When a stored function is created, the creator is automatically granted the ALTER ROUTINE

and EXECUTE privilege for that routine.

Chapter 15 addresses account administration and permissions, and provides more details

on granting users appropriate permissions for managing and using stored functions.


C H A P T E R   1 0   ■ F U N C T I O N S

Performance of Functions

We discussed benchmarking in detail in Chapter 6. As you might expect, you can perform

various benchmarks to look at how functions affect the performance of a query. Here, we were

primarily interested in creating a simple example that demonstrated the overhead required to

send parameters to a function and get the result back, rather than focusing on the actual pro-

cessing within the function itself.

To benchmark the overhead in using a function, we took the statement from Listing 10-3

and compared performance of that SELECT statement with the statement in Listing 10-4.

Because this is a fairly simple function, the differences in performance should be primarily

due to the time it takes to pass the item_sum and shipping values into the function and get

the result.

The metrics were performed on MySQL 5.0.2, running on a single AMD64 2800+, with

1GB of RAM and a 10KB RPM SCSI data disk (separate from the boot disk). The database is

using the prebuilt binary for AMD64 downloaded from the MySQL web site and is using all

default options on startup (no .my.cnf file used on startup).

What we found is that repeated tests running the calculation ten million times directly

in the SQL statement took an average of 6.8 seconds, or 1.47 million operations per second.

Listing 10-28 shows the statement.

We then created a function, calculate_total() shown in Listing 10-29, to abstract the

calculation shown in the second line of Listing 10-28.

Listing 10-28. Simple Calculation Directly in Query

mysql> SELECT cust_order_id, item_sum, shipping,

item_sum * .05 + item_sum + shipping AS total

FROM cust_order;

Listing 10-29. CREATE Statement for calculate_total()

CREATE FUNCTION calculate_total

(cost DECIMAL(10,2), shipping DECIMAL(10,2))

RETURNS DECIMAL(10,2)

RETURN cost * 1.05 + shipping;

With this function defined in the database, we ran the query in Listing 10-30 repeatedly

on the same ten million rows that we ran the query from Listing 10-28. In this instance,

instead of the calculation happening directly in the query, we used the calculate_total()

function.

Listing 10-30. Simple Calculation Using Function

mysql> SELECT cust_order_id, item_sum, shipping,

calculate_total(item_sum,shipping) AS total

FROM cust_order;

We found on average it took 9.4 seconds to process the rows, or about 1.06 million opera-

tions per second.


C H A P T E R   1 0   ■ F U N C T I O N S

Are those numbers significant? A lot depends on how much data you need to process. If

you have billions of rows of data that you’re considering filtering through a function, you may

want to perform some benchmarks of your own to determine the impact the functions will

have on your performance. For anyone processing smaller amounts of data (tens of thou-

sands), the difference of having a function in the statement will be insignificant.

■Caution Throughout this chapter, we’ve discussed using functions in SELECT, INSERT, and UPDATE

statements. To be sure we’re clear, we do not suggest putting a function in the WHERE clause of a query,

unless there is deliberate reason to have it there. Using functions in the WHERE clause invalidates any benefit

of using an index. Using functions prevents the database from performing lookups on those index keys,

meaning that your query will require a full-table scan. Use caution when building the WHERE clause of your

SQL statements, and use a function only if you are sure you do not need the indexes.

Summary

We’ve been through a lot of details on using stored functions in MySQL. We started the chapter

looking at functions in general, and how functions compare with other database-level tools. In

addition to finding the right use for functions to meet the requirements set for your database,

you should be familiar with the specifics of MySQL’s implementation of functions before div-

ing into moving pieces of your business logic into functions.

After reviewing the general concepts of stored functions, we dug into examples and

details of the commands used to build functions. We looked at how to create functions to

encapsulate calculations, and how to create functions that use other functions. We also went

through details on managing existing functions with the SHOW, ALTER, and DROP commands.

We concluded the chapter by discussing the permission scheme for functions and looked

into the significance of functions on query performance.

At the beginning of the chapter, we talked about needing a function to convert a state-

ment to make the first character uppercase and the rest in lowercase. To bring the chapter full

circle, here’s the ucasefirst() function:

CREATE FUNCTION ucasefirst (phrase VARCHAR(255)) RETURNS VARCHAR(255)

RETURN CONCAT(UCASE(SUBSTR(phrase,1,1)),SUBSTR(LCASE(phrase),2));

And here’s how it works:

mysql> SELECT ucasefirst("tEST THe caSE-CHANGING funCtion!");

+------------------------------------------------+

| ucasefirst("tEST THe caSE-CHANGING funCtion!") |

+------------------------------------------------+

| Test the case-changing function!               |

+------------------------------------------------+

The ability to create your own functions in MySQL—whether to perform a calculation,

manipulate data, or format data using native SQL statements—gives you a simple, yet powerful

set of commands and syntax. Using stored functions, you can now encapsulate and organize

logic, extending your database to better meet the needs of your application and users.


C H A P T E R   1 1

■ ■ ■

Cursors

In the previous chapters, we looked at both stored procedures and stored functions, and the

new possibilities they bring to MySQL 5.0. As we explored these new routines, we left out a

very useful piece of syntax that opens up even more possibilities in the use of stored routines:

the syntax for cursors.

Cursors, like stored procedures and functions, are new to MySQL in version 5.0. Cursors

are a welcome addition for people who are coming from cursor-capable databases or have

been using MySQL but grumbling about not being able to use cursors. Most major databases

provide cursor functionality, including DB2, Oracle, SQL Server, Sybase, and PostgreSQL. With

5.0, MySQL joins the ranks of other cursor-capable database systems.

Even if you haven’t used cursors in a database before, this chapter will provide the infor-

mation you need to try them out. In this chapter, we will cover the following topics related to

cursors:

• Database cursor basics

• MySQL’s implementation of cursors

• How to create cursors

• An example of using cursors

Database Cursors

Back in Chapter 9, all of the stored procedure examples looked at data in singular form,

selecting one or two columns from a single record in a table into a variable or two to use in

making a decision. You might have places where using single pieces of data meets your needs,

but you’re probably left thinking that unless a routine can work with sets of data, stored proce-

dures or functions aren’t of much use to you. For example, you might have a stored procedure

that needs to be capable of processing a large set of records, inserting data into a set of tables

based on the values in each record. Doing all of this within a stored procedure makes a lot of

sense, but you need to be able to issue a SELECT statement, retrieve the rows, and loop through

them one at a time to determine how each record should be handled.

With the addition of support for cursors in MySQL 5.0, processing sets of data within a stored

routine is possible. The database cursor allows you to issue a SELECT statement in a procedure,

either on a single table or joining multiple tables, and use a pointer to the data in the results to

iterate over each record. With each record, you can use all of the available routine logic discussed

in Chapter 9 and 10 to make decisions about what needs done with each record.


C H A P T E R   1 1   ■ C U R S O R S

■Note As of writing this chapter, MySQL has released version 5.0.6, which is labeled a beta release. While

the cursor functionality in the database is stable enough to test and document, production users are encour-

aged to wait until a release of the 5.0.x branch that is labeled production.

In database terms, a cursor is a pointer to a record in a set of results in the database. Using

a database cursor allows you to issue a query, but rather than getting back the set of query

records, you get back a pointer to the data that allows you to interact with the set of records.

The cursor provides a mechanism to use the data, allowing you to issue commands to read

information, move to another record, make a change to the data, and so on. Once the cursor

has been created, it remains actively pointed at the data until it is closed or the connection to

the database is closed.

A popular use of cursors is to issue a query that requests a cursor in return, and then have

code control the cursor to iterate through the set of records, performing logic based on the

information in each row.

As with stored procedures, stored functions, and other technologies, there is a debate as

to where cursors are appropriate. Some suggest that cursors should be a last resort. They say

that, in most cases, it’s better to return the entire resultset to the client to work with than to tie

up the database keeping track of a cursor over a period of time. Others suggest that cursors are

a preferred method for interacting with large sets of data. They say that using cursors allows

for more immediate access to the data and reduces the load on the database, because cursors

can return the data to the client incrementally, and only as needed by the client. Whether cur-

sors are appropriate for your application is a question you must answer when looking at the

needs of your users and the stewards of the data. Before you decide to invest time and energy

into using cursors, you should carefully weigh the implications of moving data processing for

multiple-row data sets out of your application and into the database.

Before looking at the details of using cursors with MySQL, let’s review some basic cursor

concepts, to give you some context for MySQL’s cursor implementation.

Server and Client Cursors

The two major types of cursors are server-side cursors and client-side cursors. Server-side

cursors let you open a cursor in code that is run inside the database. You are not able to send

the cursor, or a pointer to control the cursor, to an external client for interaction with the

database. Server-side cursors are opened, used, and closed from within a routine inside

the database. The cursor is opened and closed without any interaction with an external

client, other than calling the procedure that may use a cursor internally.

A database system that allows client-side cursors provides the ability to open a cursor

from a client outside the database (for example, in your application) and have the database

return the cursor to the external client for control. Where client-side cursors are in use, you

will see the client or application make a query to the database that asks for a cursor, instead of

the record set, in the return. The client gets the cursor from the database, and then uses logic

built into the application to control the cursor’s movement, retrieval, and modification of

data. Once the application has finished, it is expected to close the cursor.

MySQL offers only server-side cursors.


C H A P T E R   1 1   ■ C U R S O R S

Cursor Movement

Depending on the database, control over the movement of the cursor varies. In its simplest

form, a cursor moves forward one record at a time and gives you no control over the direction

or spacing of the movement.

More sophisticated implementations will allow you to move the cursor both forward and

backward. Beyond the ability to move backward is the capability to skip to certain records,

based on either a record number or a position relative to where the cursor is currently posi-

tioned. It’s also common to see a command to move the cursor back to the first or forward

to the last record.

MySQL cursors are of the forward-only type.

Data Behind the Cursor

You might wonder exactly where the cursor resides and what data it’s using when you’re scroll-

ing around. The SQL standard specifies that cursors can be either insensitive or asensitive.

An insensitive cursor is one that points at a temporary copy of the data. Any changes in

the data while the cursor is open are hidden from the cursor, because the cursor is looking at

a snapshot of the data taken at the time the cursor was requested. The snapshot of the data

sticks around until the cursor is closed.

An asensitive cursor points at the real data, not a cached or temporary copy. A cursor that

points at the actual data becomes available faster than an insensitive cursor, because the data

doesn’t need to be copied to a temporary place. However, when using a cursor that points at

the actual data, changes in the underlying data from another connection may affect the data

being used by the cursor.

MySQL cursors are asensitive.

Read and Write Cursors

The most common type of cursor returned from a database is a cursor used for reading data.

However, some cursors can make changes to the record where the cursor is currently posi-

tioned.

The ability to write via a database cursor opens up a lot of additional options for your

cursor use. With a write cursor, you could run a query, perform some logic on the fields in the

query, and make updates to the fields in the record based on the logic. To do this same kind of

thing from the client would take getting the entire resultset and then performing numerous

updates on each row.

MySQL cursors are read-only.

Cursors in MySQL

MySQL comes with cursor functionality in version 5.0 and later. As you would expect, MySQL

has implemented a small core of cursor functionality that can accomplish a lot.


C H A P T E R   1 1   ■ C U R S O R S

■Note MySQL developers have been pretty clear over the years that their primary focus is on developing

features for use in production and building new functionality based on what database users are requesting.

This leads to database feature implementations that are simple because they contain only what the user

needs. It also keeps the amount of code in the database to a minimum for better performance, fewer bugs,

and easier debugging when there are bugs.

MySQL’s cursor implementation can be summarized in one statement: MySQL cursors

are read-only, server-side, forward-moving, and asensitive. As our earlier discussion indicated,

because they are server-side cursors, they can be used only within stored routines in the data-

base. You cannot request a cursor from a client, and the database is not capable of returning a

cursor for external control.

Being ready-only, MySQL cursors are limited to the use of the cursor to retrieve information

from the database, not to make changes. If you want to make changes to the data retrieved

through a cursor, you’ll need to issue a separate UPDATE statement.

MySQL cursors can move only forward, one record at a time. The FETCH statement is used

to move the cursor forward one record. If you need to move forward more than one record—

for example, because you want to process every fifth record—you could use IF statements

with a variable to perform your logic every so many FETCH statements.

MySQL supports asensitive, but not insensitive, cursors. This means that when you open

a cursor to read information from a table, the actual table data is used when grabbing infor-

mation, as opposed to a cached copy or temporary table to isolate the cursor’s interaction

with the data from other client interaction. With cursors in MySQL being asensitive, you aren’t

required to wait until the data is loaded from the main table storage to a temporary location to

start fetching the data. This also means that you might find that data changes through other

connections to the database at the time you are using your cursor. These changes may show

up as you move through the records retrieved by your cursor declaration.

■Note In the case of using a recursive procedure or function with a cursor, you are allowed to keep the

cursor open while the stored procedure or function hands control to another instance of itself. There is no

limit to the number of cursors that can be open, but too many open cursors can consume enough resources

to crash your database. Look for a configuration option in the near future that will let you limit the number of

open cursors.

Creating Cursors

Let’s start with a simple example so you can get some idea of what a function with a cursor

looks like. For this example, suppose we have been asked to build an easy way for employees

to get a list of the cities where we have order-processing facilities. Since we took great care to

normalize our data, all cities are stored in a central table. The employees could just SELECT

from the city table, but the vertical list of city names output from the SELECT isn’t acceptable.


C H A P T E R   1 1   ■ C U R S O R S

The employees use this information to dynamically generate documents that must put the

city names in a sentence.

■Note In the examples in this chapter, we focus on using cursors in stored procedures and stored func-

tions, but cursors can also be used in triggers. However, we recommend that you keep trigger processing to

a minimum, using triggers only for simple tasks that verify or manipulate the data. Use extended processing,

like cursors, in a trigger only if absolutely necessary. Triggers are covered in Chapter 13.

We could write a tool that goes to the database, gets the list, and formats the results in a

string to be used in a paragraph, or we could put this into a function and let the employees call

the function. Listing 11-1 shows how we might build the city_list() function.

Listing 11-1. city_list() Function

DELIMITER //

CREATE FUNCTION city_list() RETURNS VARCHAR(255)

BEGIN

DECLARE finished INTEGER DEFAULT 0;

DECLARE city_name VARCHAR(50) DEFAULT "";

DECLARE list VARCHAR(255) DEFAULT "";

DECLARE city_cur CURSOR FOR SELECT name FROM city ORDER BY name;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN city_cur;

get_city: LOOP

FETCH city_cur INTO city_name;

IF finished THEN

LEAVE get_city;

END IF;

SET list = CONCAT(list,", ",city_name);

END LOOP get_city;

CLOSE city_cur;

RETURN SUBSTR(list,3);

END

//

DELIMITER ;


C H A P T E R   1 1   ■ C U R S O R S

When entering multiple statement blocks into MySQL, you need to first change the

default delimiter to something other than a semicolon (;), so MySQL will allow you to enter

a ; without having the client process the input. Listing 11-1 begins by using the delimiter

statement: DELIMITER //, which changes the delimiter to //. When you’re ready to have your

procedure created, type //, and the client will process your entire procedure. When you’re

finished working on your procedures, change the delimiter back to the standard semicolon

with DELIMITER ;, as you can see at the end of Listing 11-1.

The differences in this function definition from the ones you saw in Chapter 10 are the

DECLARE…CURSOR, OPEN, FETCH, and CLOSE statements, as well as the HANDLER declaration. These

are the statements for using cursors.

Before we look at the syntax for the statements related to cursors, let’s step through what’s

happening in the city_list() function. It starts with a number of variable declarations, a cur-

sor declaration to get city names from the city table, and a handler declaration to help you

determine when you’ve reached the end of the results. It then opens the cursor and iterates

through the results, fetching each record, checking if the fetch failed, and adding the name of

the current city to our string. Finally, it returns the string to the caller. Using this function is

simple, as shown in Listing 11-2.

Listing 11-2. Using the city_list() Function

mysql> SELECT city_list() AS cities;

+----------------------------------+

| cities                           |

+----------------------------------+

| Berlin, Boston, Columbus, London |

+----------------------------------+

1 row in set (0.05 sec)

The employees who need to have a string list of all the cities in the system can now use

this function where required. It will always get the list of current city names in the city table.

The statements for using cursors are intertwined with statements to build the overall

routine, but appear in the order DECLARE, OPEN, FETCH, and CLOSE as you build a procedure or

function that uses a cursor.

DECLARE Statements

When building a stored procedure or function that requires a cursor, a few DECLARE statements

are needed. You may recall from our coverage of stored procedures in Chapter 9 that declara-

tions must be ordered variables first, cursors second, and handlers last.

Variables

When using a cursor, you need to declare at least two variables. One is the variable that will be

used to indicate that the cursor has reached the end of the record set. In Listing 11-1, we used

the finished variable for this purpose:

DECLARE finished INTEGER DEFAULT 0;


C H A P T E R   1 1   ■ C U R S O R S

The finished variable was initialized to 0. During the loop over the record, this variable is

checked with an IF statement to determine if the last record has been reached. We’ll look at

the loop shortly, when we discuss the HANDLER statement.

Beyond the variable for exiting the loop, you also need to declare a variable for each field

that you will FETCH from the cursor. In this example, we’re getting only one field from each row,

so we declare only one variable to store the field value being pulled from the row of data:

DECLARE city_name VARCHAR(50) DEFAULT "";

When you’re iterating over the records, the FETCH statement gets the field value from the

cursor and assigns the value to the variable. We’ll cover fetching data from the records in the

upcoming section about the FETCH statement.

Each time the loop iterates, city_name will be set to the value of name for the current row

and be available for use in whatever logic you’re performing in the loop. In this case, we’re

building a string.

We also have declared a list variable that is created to store the joined city names. This

variable will eventually be used for the return to the client.

Once we’ve declared the variables for the procedure, we can declare the cursor itself. The

statement to create the cursor is shown here:

DECLARE <cursor name> CURSOR FOR <SELECT statement>;

This statement simply defines the cursor, but does not actually process the statement or

create the pointer to the data. The DECLARE statement from Listing 11-1 shows how this looks

in practice:

DECLARE city_cur CURSOR FOR SELECT name FROM city ORDER BY name;

Here, we create a cursor named city_cur, which is defined as a pointer to the data from a

SELECT statement that will retrieve all the names from the city table.

Cursor

Handler

A HANDLER statement is required to detect and handle when the cursor cannot find any more

records. Each time the FETCH statement is processed, it attempts to get the next row of data.

When it has reached the end of the set of results, it will not be able to find another set of data.

At that time, a condition will be raised, the handler will be activated, and the handler will set

up for the iteration over the records to exit. (Refer to Chapter 9 for more information about

handlers.)

In the example in Listing 11-1, we declared a finished variable, initially set to 0. We then

created a handler that says, “When FETCH has raised the condition that it couldn’t find a record

to read, set the finished variable to 1,” as follows:

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;


C H A P T E R   1 1   ■ C U R S O R S

Each time the loop iterates, it attempts to FETCH, and then immediately checks the

finished variable to see if it was changed by the condition being raised. If the finished vari-

able wasn’t changed by an activation of the HANDLER statement, the loop continues. This logic

is repeated for each iteration through the loop:

get_city: LOOP

END LOOP get_city;

FETCH city_cur INTO city_name;

IF finished THEN

LEAVE get_city;

END IF;

SET list = CONCAT(list,", ",city_name);

If the FETCH can’t get a row, a NOT FOUND condition is raised. This condition is handled by

the handler, which sets finished to 1. The IF finished THEN statement will then be satisfied,

and the loop will exit on the LEAVE statement. A loop label, get_city in this example, is

required to use the LEAVE statement. (See Chapter 9 for details on flow constructs, including

the LOOP, IF... THEN, and LEAVE statements.)

■Caution You may be tempted to use the REPEAT statement for your iterations, but be careful. The REPEAT

mechanism is problematic because it doesn’t allow you to check to see if the FETCH caused the reset of the

finished variable until the bottom of the loop. If you don’t check if the loop should exit immediately after

the FETCH, you will execute statements, even though the end of the resultset has been reached.

OPEN Statement

After you have declared the necessary variables and the cursor itself, you can activate the cur-

sor by using the OPEN statement:

For our example, where the cursor was declared as city_cur, the OPEN statement looks

OPEN <cursor name>;

like:

OPEN city_cur;

When you issue this statement, the SELECT statement in the cursor declaration is processed,

and the cursor is pointed at the first record in the statement, ready for a FETCH to happen.

■Tip A cursor declaration can be opened multiple times within a stored procedure. If the cursor has been

closed, the OPEN statement can be used to run the SQL statement again and give you a pointer to the data.

This might be helpful if you have a set of records that needs to be used several times in a procedure or

function.


C H A P T E R   1 1   ■ C U R S O R S

FETCH Statement

The FETCH statement gets the data from the record, assigns it to a variable, and tells the cursor

to move to the next record. The FETCH statement requires a cursor name and a variable:

FETCH <cursor name> INTO <variable name>[, <variable name>, …];

The example in Listing 11-1 fetches the record from the city_cur cursor and puts that

single value into the city_name variable:

FETCH city_cur INTO city_name;

If your SELECT statement in DECLARE…CURSOR contains more than one column, you’ll be

required to provide a comma-delimited list of variables to use when assigning the value of

each field to a variable. For example, if the SELECT statement in Listing 11-1 had also specified

the city_id, we would have needed to declare a variable to hold the city_id when it was

fetched.

CLOSE Statement

When you are finished with the cursor, you should close it. The CLOSE statement to accomplish

this is simple:

CLOSE <cursor name>;

CLOSE city_cur;

In Listing 11-1, we close the city_cur cursor as follows:

Closing the cursor removes the pointer from the data. If you don’t issue the CLOSE state-

ment, the cursor will remain open until your connection to the database is closed.

■Tip You can have multiple cursors within a single stored procedure, each with its own DECLARE statement.

You can have them opened at the same time and FETCH from them within the same loop, or in separate iter-

ations at different points in your procedure or function. Be aware that the NOT FOUND condition will be met

when any of the FETCH statements finds that it is at the end of the record set. There is no way to assign a

condition to a specific cursor.

Using Cursors

We started the chapter with a scenario where you needed to process multiple records and

move them to a set of other tables in your system, with the appropriate table for a row being

decided by the data in the row. Now, let’s see how you might solve this type of problem with a

stored procedure and cursor.

Sticking with the online store example we’ve been using in previous chapters, suppose we

have a login table that keeps track of when a customer logs in to our system. We use this infor-

mation to keep a customer login history for statistics, as well as to record login information in


C H A P T E R   1 1   ■ C U R S O R S

case a security issue arises. We also use this table to show users their login history for the past

week. Because we have user counts in the hundreds of thousands at any given point, and

users log in to the system many times throughout each day, the table that tracks their access

grows quickly, as expected. Within just a few months, the login process, which checks the last

login and inserts a new record, and the page that displays the recent login information both

show signs of problems with scalability.

Since we really want only the logins from the past week, we don’t need all the information

to stay in the login table. To reduce the size of our login table, we decide to create a

login_archive table and push the older information in the login table into this archive.

From our customer support group and reps, we learn that the data would be even more

useful if it were separated using the region of the user and placed in tables replicated out to

the regional offices during the archive process. To do this, we create an archive table for each

of three main regions: login_archive_south, login_archive_northeast, and login_archive_

northwest. However, we still need a way to go through all of the data and move it to the right

place.

This scenario is perfect for a stored procedure that uses a cursor to go through each line

of the data and move it into different tables. Since we don’t actually need to see any of the data

in the client during this process, using a stored procedure will give us better performance,

because data does not need to flow back and forth between the client and the database. The

interaction with the data and the data itself stays inside the database until the process is

complete. Listing 11-3 shows the login_archive() procedure built to accomplish this task.

Listing 11-3. login_archive() Procedure

DELIMITER //

CREATE PROCEDURE login_archive()

BEGIN

DECLARE finished INTEGER DEFAULT 0;

DECLARE cust_id INTEGER;

DECLARE log_id INTEGER;

DECLARE time DATETIME;

DECLARE moved_count INTEGER DEFAULT 0;

DECLARE customer_region INTEGER;

DECLARE login_curs CURSOR FOR SELECT l.customer_id, l.login_time,

c.region, l.login_id

FROM login l, customer c

WHERE l.customer_id = c.customer_id

AND to_days(l.login_time) < to_days(now())-7;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN login_curs;

move_login: LOOP


C H A P T E R   1 1   ■ C U R S O R S

FETCH login_curs INTO cust_id, time, customer_region, log_id;

IF finished THEN

LEAVE move_login;

END IF;

IF customer_region = 1 THEN

INSERT INTO login_northeast SET customer_id = cust_id,

login_time = time;

ELSEIF customer_region = 2 THEN

INSERT INTO login_northwest SET customer_id = cust_id,

login_time = time;

INSERT INTO login_south SET customer_id = cust_id,

login_time = time;

ELSE

END IF;

DELETE from login where login_id = log_id;

SET moved_count = moved_count + 1;

END LOOP move_login;

CLOSE login_curs;

SELECT moved_count as 'records archived';

END

//

DELIMITER ;

This stored procedure starts with the expected declaration of the finished variable and

other variables for storing fetched data, as well as the cursor and handler declaration. We also

create the moved_count variable for keeping track of how many records are moved. The SQL

statement that defines the cursor is a bit more complex than our first example, but nothing

out of the ordinary. It joins two tables and includes a WHERE clause to limit the results to

records that are older than seven days.

We then open the cursor and use the LOOP statement to go through each record. Notice

that the FETCH statement assigns values to multiple variables, correlated with the number of

columns in the SELECT statement that defined city_cur. After the FETCH, we first check to see if

we’ve reached the end of the records, exiting if we have. If we’re not ready to exit, we use the

values in the record to determine which region the customer belongs in, and INSERT the record

into the appropriate table. Finally, in the loop, we DELETE the record that was just moved so it

isn’t in the login table (one of the main purposes for the archive process) and increment the

moved_count variable.

Let’s try this to make sure that the procedure is moving the data appropriately. A look at

the record counts shows that there’s a lot of information in the login table, and none in the

region-specific tables. Listing 11-4 shows the output from four queries to get record counts.


C H A P T E R   1 1   ■ C U R S O R S

Listing 11-4. Record Counts Before Calling archive_login()

mysql> SELECT COUNT(*) AS login FROM login;

+-------+

| login |

+-------+

| 10000 |

+-------+

1 row in set (0.17 sec)

mysql> SELECT COUNT(*) AS login_northwest FROM login_northwest;

+-----------------+

| login_northwest |

+-----------------+

|               0 |

+-----------------+

1 row in set (0.01 sec)

mysql> SELECT COUNT(*) AS login_northeast FROM login_northeast;

+-----------------+

| login_northeast |

+-----------------+

|               0 |

+-----------------+

1 row in set (0.01 sec)

mysql> SELECT COUNT(*) AS login_south FROM login_south;

+-------------+

| login_south |

+-------------+

|           0 |

+-------------+

1 row in set (0.00 sec)

Now, let’s see what happens when we execute the stored procedure, with its internal cur-

sor mechanism, using the CALL statement, as shown in Listing 11-5.

Listing 11-5. Running login_archive()

mysql> CALL login_archive();

+------------------+

| records archived |

+------------------+

|             3757 |

+------------------+

1 row in set (9.58 sec)


The return from login_archive() tells us that 3,757 of our 10,000 records were archived.

To verify that records were moved into the appropriate place, we can run the queries to

check the counts of each table, as shown in Listing 11-6.

C H A P T E R   1 1   ■ C U R S O R S

Listing 11-6. Record Counts After Calling archive_login()

mysql> SELECT COUNT(*) AS login FROM login;

+-------+

| login |

+-------+

|  6243 |

+-------+

1 row in set (0.24 sec)

mysql> SELECT COUNT(*) AS login_northwest FROM login_northwest;

+-----------------+

| login_northwest |

+-----------------+

|            1344 |

+-----------------+

1 row in set (0.01 sec)

mysql> SELECT COUNT(*) AS login_northeast FROM login_northeast;

+-----------------+

| login_northeast |

+-----------------+

|            1256 |

+-----------------+

1 row in set (0.01 sec)

mysql> SELECT COUNT(*) AS login_south FROM login_south;

+-------------+

| login_south |

+-------------+

|        1157 |

+-------------+

1 row in set (0.00 sec)

The output from the counts on the tables indicates that some of the login table’s records

were moved to the three regional archive tables, and that there are still 6,243 records left. A

look at the login table reveals that the remaining records are from logins from the past seven

days, as we anticipated.


C H A P T E R   1 1   ■ C U R S O R S

Summary

With the ability to add cursors into stored procedures and functions, you gain a powerful set

of commands to process data, specifically in sets of results in your tables.

Cursors are used in stored procedures, functions, and triggers to iterate through sets of

data, assigning local variables to the field values in the data and using those values to perform

logic or additional SQL statements. As with all database tools, you must carefully consider

how cursors meet the needs of your users and application and determine whether using them

within a procedure or function will provide the best solution to the problem you are attempt-

ing to solve.

The cursor syntax is simple and easy to add into the syntax for stored routines in the data-

base. With just four additional statements, MySQL keeps focused on doing the most with the

least.

The chapter worked through two examples: a simple function and a stored procedure.

Both examples provide a starting point for thinking about how your database could benefit

from the use of cursors.

All said, cursors are the icing on the cake of stored routines. The ability to process large

sets of data within your database opens up countless new options in planning and imple-

menting the functionality and tools that are required of any database administrator or

application programmer.


C H A P T E R   1 2

■ ■ ■

Views

MySQL is all about storing and retrieving relational data. A lot of data stored in a database is

dynamic, in the sense that data is being added, updated, or removed. Data is also dynamic in the

sense that as you collect it, you find new questions to ask about the data and new ways to arrange

the relationships between various pieces of data. A part of this forward motion includes looking

at the data in different ways—including new columns, joining tables not previously associated

with one another, summarizing data in new ways, and so on.

Views offer one solution to the ever-changing need for rearranging and changing how

data is presented. Views are new to MySQL as of version 5.0. Perhaps you’ve started using

them already, or have used them in another database system. Maybe you’ve heard other

developers or database administrators describe using views. Even if you have no idea what

views are, this chapter is the right place to be to learn why and how views can make things

easier for everyone.

This chapter delves into views in MySQL, and covers the following areas:

• Uses for database views

• MySQL’s implementation of views

• How to create views

• Updatable views

• Views of views

• View permissions

• Performance of views

• How to display, change, and remove views

Database View Uses

Have you ever wanted to let a user build queries that would look at only certain rows of data

in a particular table? Have you ever wanted to have data from several tables merged together

into a single, dynamically updated table? Have you ever wanted to create an “alias” for a table,

having it appear under two names but contain the same data? One way to accomplish these

goals, which involve virtual representations of tables, is to use views.


C H A P T E R   1 2   ■ V I E W S

A view provides a mechanism for interacting with rows and columns of data contained

in one or more tables. From the client, a view behaves like a table, in that it has a specific

number of columns and contains any number of rows of data. The view can be used in a

SELECT statement, just like any other table. The view can also be used to update data in

certain circumstances.

In the database, a view is defined primarily by a query that performs a SELECT on one or

more tables. A view definition also includes some keywords to help the database know how to

process interactions with the data through the view. A view can even contain columns that are

results of database functions or column aggregation. In essence, a view is a way for you to take

a SELECT statement, put it inside the server, and make the results into a table that can be

queried and is always current with the tables in the FROM clause in the defining query.

Another way to think of a view is that it’s like telling the server that, before it runs an

incoming SQL statement, it needs to first issue a predefined SELECT statement. Once the pre-

defined statement has been executed, the server should run the incoming SQL statement on

the data retrieved in the predefined SELECT statement.

For example, suppose you have a customer table with id, name, age, and household_income

fields. A SELECT on this table can get any of those four fields. If you wanted to hide the

house_hold_income field from certain employees, or hide it from your application, you

could define a view with a SELECT statement like this:

SELECT id, name, age FROM customer;

If you named the view customer_info, any SELECT statements against the view would be

able to retrieve only columns and records that show up in the predefined statement—id, name,

and age—from the table. Since the customer_info table is based on a SELECT from the customer

table, results from the customer_info table will always be exactly what you would find in the

customer table, less the household_income column.

The following are some reasons why database designers, database administrators, develop-

ers, and other database folks might want to implement views in their database or application:

Query abstraction: You want a way to abstract queries from the user, resulting in a simpli-

fied data interface, reduced network traffic, and data representations different from the

actual tables. Complex queries can be cumbersome in the code, as well as a burden on

network bandwidth.

Limited access: For efficiency or security, you want to limit access to a subset of data in a

particular table or set of tables. For example, a table must consist of product orders from

around the world, but have fulfillment centers in certain regions that should see only

orders for their region. You might create a view for each region to provide that region the

ability to view and update its data but not data from another region.

Backward-compatibility: For backward-compatibility, you want to provide access to a

particular table under a separate name, which acts as an interface to the referenced table.

For instance, if you are refactoring a particular table, you might use a view to continue to

return results based on the original table structure to mask changes in the table.

Security: Some database systems support only read-only views, or give you the ability to

specify that a view is read-only. In systems where views can be created as read-only, they

can be used to enforce security, giving people access to a view of the table that cannot be

updated.


C H A P T E R   1 2   ■ V I E W S

Development: Views can allow multiple developers to point their development code to

a single database, yet make changes in specific tables. This can be useful in multiuser

development environments, where each developer possesses his or her own database for

development. To begin, the developer’s database contains views of the tables in the cen-

tral database. In the instance where a developer needs to alter a table for development,

that developer can change the view, or drop the view and create a local copy of the table.

After completing the code changes, the ALTER statements made to the local tables are

made in the central database, and the developer replaces his or her local copies of the

tables with views of the newly altered tables in the central database.

Virtual fields: In a database design where storing calculated fields is not permitted, or in

situations where new calculated fields need to be added, views can provide a virtual rep-

resentation of those columns that are calculated as the query is executed. A view will

solve a problem like having a basket table with a quantity and unit_cost field where you

want to display the total_price (product of quantity and price_each) but don’t want to

store it in a table. A view can join the columns of a physical table with dynamically calcu-

lated columns to provide calculations without needing to store those calculations in the

database.

Views in MySQL

MySQL’s implementation of views conforms to the SQL:2003 standard, except in a few cases,

which are noted as appropriate throughout the chapter.

Views are associated with a specific database and are stored in a MySQL data dictionary

file, located in /<datadir>/<database_name>/<view_name>.frm. Data dictionary files for views

are stored in plain-text format, which means you can view the SQL that defines the view, as

well as the other attributes of the view, with a text viewer or editor.

■Note As we write this chapter, MySQL has released version 5.0.6, which is labeled a beta release. While

the database is stable enough to test and document the functionality of views, production users are encour-

aged to wait until a release of the 5.0.x branch that is labeled for production.

The MySQL server processes queries of views in two different ways:

• MySQL creates a temporary table of the data results from the view’s defining SELECT

statement, and then executes the incoming SQL against the temporary table.

• MySQL combines the incoming SQL statement with the view’s defining SELECT state-

ment, creating a new, single SQL statement. This SQL statement is executed against the

tables.

Both methods, and how to control MySQL’s choice of which method to use, are covered in

more detail in the next section.


C H A P T E R   1 2   ■ V I E W S

Queries against a view will be stored in the query cache if the cache is enabled and the

query can be stored in the cache.1 If available, data is always pulled from the buffering subsys-

tem to avoid making a call to the disk. (See Chapter 4 for more information about MySQL

buffering subsystems.)

MySQL supports views of views. The SELECT statement that defines a view can contain

references to other views in the database.

MySQL views contain a built-in versioning system. When a view is altered or replaced, a

copy of the data dictionary file (.frm file) for the existing view is copied into the arc (archive)

directory within the directory of that particular database. The three most recent data diction-

ary files are stored for each replaced or altered view. The archive copies of the data dictionary

files are kept even after the view is dropped. The archive files are deleted when the database is

dropped.

Now that we’ve described how MySQL implements views, we can move on to the details

of building and maintaining views.

■Note If you’re familiar with MySQL’s MERGE storage engine, you might be wondering how its tables differ

from views. As explained in Chapter 5, the MERGE storage engine allows you to join multiple identical tables

into one virtual table. The tables must be identical, and when creating a MERGE table, you aren’t allowed to

limit the columns or rows by a SELECT statement. In contrast, views afford you a great deal of flexibility on

what columns and rows to choose, from any number of varied tables.

Creating Views

At a minimum, creating a view requires a view name and a SQL statement:

CREATE VIEW <name> AS <SELECT statement>;

Suppose you have a customer table that has a customer_id, region, and name column.

A sample output of a few rows from this table is shown in Listing 12-1.

Listing 12-1. Records in customer Table

+-------------+--------+---------+

| customer_id | region | name    |

+-------------+--------+---------+

|           1 |      1 | Mike    |

|           2 |      1 | Jay     |

|           3 |      2 | Johanna |

|           4 |      2 | Michael |

|           5 |      3 | Heidi   |

|           6 |      3 | Ezra    |

+-------------+--------+---------+

1. Details on what makes a query qualify for the query cache are available at http://dev.mysql.com/

doc/mysql/en/query-cache-how.html.


C H A P T E R   1 2   ■ V I E W S

A view might come in handy if you want certain employees to see the data in this table,

but limit them to seeing only the customers in region 1. Listing 12-2 shows how to create a

simple view to serve as an alias for the customer table, limiting the records to just those in

region 1.

Listing 12-2. Creating a Simple View

mysql> CREATE VIEW customer_region1 AS

SELECT customer_id, name FROM customer WHERE region = 1;

Once the view is created, you can query it in the same way as any other table. Listing 12-3

shows a query against the customer_region1 view with the returned results.

Listing 12-3. Selecting from a View

mysql> SELECT * FROM customer_region1;

+-------------+------+

| customer_id | name |

+-------------+------+

|           1 | Mike |

|           2 | Jay  |

+-------------+------+

The statement in Listing 12-3 is just like any other SELECT, but instead of getting data directly

from some tables, it goes through the view. This view has been defined as the customer_id and

name columns of all records in the customer table where the region is 1. When you use SELECT *,

you get the two columns defined in the view instead of the three columns in the underlying table.

The CREATE Statement

Much of the power of a view is contained in the SQL statement that defines the view. However,

a number of syntax options in addition to the SELECT statement are important in building a

view. The CREATE statement, with a complete list of user-defined fields looks like this:

CREATE [OR REPLACE] [<algorithm attributes>] VIEW [database.]< name> [(<columns>)]

AS <SELECT statement> [<check options>]

When creating a view, you can use the OR REPLACE syntax to prevent a MySQL error in the

instance that the view is already defined. In some cases, such as when you would rather be

notified that you are overwriting an existing view, not using the OR REPLACE is preferred.

■Note Permissions for creating, using, and managing views are covered later in the “View Permissions”

section. If you are experiencing permission problems, refer to that section to clarify what privileges are

necessary when working with views.


C H A P T E R   1 2   ■ V I E W S

Let’s break this statement down into each of the user-defined components to further

explore how a view is created.

Algorithm Attributes

As mentioned earlier in the chapter, views are processed one of two ways. The algorithm

attributes for a view allow you to have some control over which of these mechanisms MySQL

uses when executing the query. These attributes are MERGE, TEMPTABLE, and UNDEFINED. Let’s see

what each one of these attributes means.

■Caution The ALGORITHM syntax is not included in the SQL:2003 specification. While this syntax is helpful

in controlling the behavior of your view, it may mean your view definition statements aren’t compatible with

other database systems that support the SQL:2003 syntax standard.

MERGE

Specifying a MERGE algorithm tells the query parser to attempt to combine the incoming SQL

statement with the SELECT statement that defines the view and create one SQL statement to

process. If MySQL can do this, it can run just one query, which is more efficient than creating

a temporary table. For this reason, MERGE is the preferred algorithm.

To demonstrate how this works, let’s look at the view we used in Listing 12-2 and see

how a SELECT statement could be combined with the view definition. Here is the statement

to create the customer_region1 view using the MERGE algorithm:

CREATE ALGORITHM = MERGE VIEW customer_region1 AS

SELECT customer_id, name FROM customer WHERE region = 1;

Let’s say we wanted to get the name of the customer with customer_id of 1 from this view.

The SELECT statement would look like this:

SELECT name FROM customer_region1 WHERE customer_id = 1;

With a MERGE algorithm, MySQL combines the query with the SELECT statement in the view

definition to come up with a single query to execute:

SELECT name FROM customer WHERE customer_id = 1 AND region = 1;

In this case, MySQL used the column name from the incoming SELECT and combined

the WHERE clauses from both the incoming query and the SELECT statement that defines the

customer_region1 view.


C H A P T E R   1 2   ■ V I E W S

When the view doesn’t represent a one-to-one relationship with records in the underlying

tables, MERGE isn’t allowed. A relationship between the view and its underlying tables that is

not one-to-one is created by using aggregation functions (SUM(), MIN(), MAX(), and so on) or

by using the DISTINCT, GROUP BY, HAVING, and UNION keywords. In instances where the MERGE

algorithm isn’t allowed, the database switches the ALGORITHM value to UNDEFINED.

TEMPTABLE

The TEMPTABLE algorithm forces a view to load the data from the underlying tables into a tem-

porary table, using the SELECT statement that defines the view. Once the data is loaded to the

temporary table, the incoming statement is executed against the temporary table.

Using a temporary table for a view adds overhead because all the data must be moved

into the temporary table before the incoming statement can be processed. However, moving

the data to a temporary table means the underlying tables can be released from any locks

while the temporary table is used to finish the execution of the query. In some systems, mini-

mal lock time is important. The TEMPTABLE option for views will mean the least amount of lock

time for the view’s underlying tables.

Views that reference only literal values are required to use a temporary table. Views that

use temporary tables are never updatable. Updatable views are covered in the “Creating

Updatable Views” section later in the chapter.

UNDEFINED

Setting the view algorithm to UNDEFINED tells the query parser to make the choice between

the MERGE and TEMPTABLE algorithms. The parser prefers the MERGE method, so it will use

that method unless a condition forces it to use a temporary table. As noted earlier, the MERGE

method can’t be used when the view doesn’t represent a one-to-one relationship with records

in the underlying tables.

UNDEFINED is the default, and it will be used if you omit the ALGORITHM keyword (or you can

explicitly specify ALGORITHM = UNDEFINED). UNDEFINED is also used if the view specifies MERGE but

can be processed only by using a temporary table.

View Name

The view name is the name used in SQL statements to query the view. Names of views share

the same namespace as tables in the database, which means you can’t have a view with the

same name as a table within the same database.

The NAME parameter can be prefixed with a database name, which allows you to explicitly

specify the database where the view should be created. If the database name isn’t prepended,

the view will be created in the currently active database. If there is no currently active data-

base, the CREATE statement will return an error.


C H A P T E R   1 2   ■ V I E W S

■Tip If you want to create views as aliases for security or abstraction, consider creating a separate data-

base where your views are defined. Doing this means that the client uses a completely different database to

view data, and you can use the same names as your tables for your views, because they aren’t in the same

namespace as the database where your tables are stored.

Column Names

Setting optional column names in a view allows you to change how the results are labeled

when returned to the client. The number of columns specified in the column list must match

the number of columns returned from the SELECT statement that defines the view. Listing 12-4

demonstrates creating the customer_region1 view, using the optional column names to specify

the column labels returned with the query results.

Listing 12-4. Creating a View with Specified Column Names

mysql> CREATE VIEW customer_region1 (id, firstname) AS

SELECT customer_id, name FROM customer WHERE region = 1;

The results returned from the customer_region1 view will now label the columns as speci-

fied in the CREATE statement, as demonstrated in Listing 12-5.

Listing 12-5. Selecting from the View with Specified Column Names

mysql> SELECT * FROM customer_region1;

+----+-----------+

| id | firstname |

+----+-----------+

|  1 | Mike      |

|  2 | Jay       |

+----+-----------+

■Note You may discover that column names can also be changed in the output from a view by using the

AS keyword for renaming columns with the SQL statement that defines the view. While this works, we rec-

ommend avoiding it and using the method demonstrated in Listing 12-4. Using AS in your defining SELECT

statement complicates combining SQL statements when using the MERGE algorithm. In addition, the

SQL:2003 standard specifies using the column list when changing the names of your columns.

The SELECT Statement

The SELECT statement can query a single table, multiple tables, or a union of multiple SELECT

statements. Any table or column referenced in the SQL statement of the view must exist. The

query parser checks these tables when the view is created.


C H A P T E R   1 2   ■ V I E W S

A few things aren’t allowed in a query that defines a view:

• A view definition cannot contain a subquery in the FROM clause of the SQL statement.

• User, system, or local variables are not allowed in the SQL SELECT statement.

• Views can’t point at temporary tables (temporary views cannot be created).

• Triggers cannot be associated with a view.

• Views created within stored procedures can’t reference parameters in the stored procedure.

■Caution When creating a view, the underlying tables and columns are checked. If the structure of those

underlying tables is changed after the view has been created, the view will need to be updated; otherwise,

queries to the view may return errors.

We’ve already reviewed a few examples of a view representing data from a single table in

Listings 12-2 and 12-4. In the following sections, we’ll go through using multiple tables with a

join and combining multiple SELECT statements with UNION. These techniques allow you to

create complex views of the data.

Joining Tables

Continuing with the order fulfillment theme, let’s suppose that the general fulfillment man-

ager wants to be able to view all orders going out from all fulfillment centers. In addition to the

order_id and the ship_date, she also wants to see customer and address information for the

order. To satisfy this request, we create a view called all_orders, which combines the order,

customer, and address tables. The SELECT statement is fairly complex, so giving the manager a

view that is easy to select from makes finding the data much easier. Listing 12-6 shows the

CREATE statement.

Listing 12-6. Creating a View with Joined Tables

mysql> CREATE ALGORITHM = TEMPTABLE VIEW all_orders

(order_id, ship_date, region, customer_id, name, address) AS

SELECT o.cust_order_id, o.ship_date, c.region, c.customer_id, c.name, a.address

FROM customer c, address a, cust_order o

WHERE o.customer_id = c.customer_id

AND c.customer_id = a.customer_id

AND o.customer_id = a.customer_id

AND o.address_id = a.address_id;

When creating the all_orders view, we use the TEMPTABLE algorithm to ensure the view,

and its underlying tables, won’t be updated through the view. A simple SELECT statement

retrieves all of the important information, as shown in Listing 12-7.


C H A P T E R   1 2   ■ V I E W S

Listing 12-7. Output of the View with Joined Tables

mysql> SELECT * FROM all_orders;

+----------+------------+--------+-------------+---------+------------------------+

| order_id | ship_date  | region | customer_id | name    | address                |

+----------+------------+--------+-------------+---------+------------------------+

|        1 | 2005-08-31 |      1 |           1 | Mike    | 123 My Street          |

|        2 | 2005-08-27 |      1 |           1 | Mike    | 456 My Business Street |

|        3 | 2005-09-27 |      1 |           2 | Jay     | 123 That Street        |

|        4 | 2005-09-01 |      1 |           2 | Jay     | 123 That Street        |

|        6 | 2005-08-28 |      2 |           3 | Johanna | 123 Home Street        |

|        5 | 2005-09-10 |      2 |           3 | Johanna | 456 Work Street        |

|        7 | 2005-09-01 |      2 |           4 | Michael | 123 My Street          |

+----------+------------+--------+-------------+---------+------------------------+

7 rows in set (0.00 sec)

The results returned from a query to the all_orders view is a nice summary of informa-

tion from three different tables, yet the manager can get at the data without needing to issue a

sophisticated query each time. Also, if the manager wants to sort results by different fields, or

limit the results, she can easily add the ORDER BY or LIMIT syntax, without needing to deal with

such a large statement, as shown in Listing 12-8.

Listing 12-8. Adding ORDER BY to the Joined Table View

mysql> SELECT * FROM all_orders ORDER BY ship_date;

+----------+------------+--------+-------------+---------+------------------------+

| order_id | ship_date  | region | customer_id | name    | address                |

+----------+------------+--------+-------------+---------+------------------------+

|        2 | 2005-08-27 |      1 |           1 | Mike    | 456 My Business Street |

|        6 | 2005-08-28 |      2 |           3 | Johanna | 123 Home Street        |

|        1 | 2005-08-31 |      1 |           1 | Mike    | 123 My Street          |

|        7 | 2005-09-01 |      2 |           4 | Michael | 123 My Street          |

|        4 | 2005-09-01 |      1 |           2 | Jay     | 123 That Street        |

|        5 | 2005-09-10 |      2 |           3 | Johanna | 456 Work Street        |

|        3 | 2005-09-27 |      1 |           2 | Jay     | 123 That Street        |

+----------+------------+--------+-------------+---------+------------------------+

7 rows in set (0.00 sec)

If the manager prefers the order to be sorted a certain way all the time, we could specify

the sort as an ORDER BY clause in the SQL statement that defines the view.

■Note In the case that a view has an ORDER BY clause, the results will be sorted before being returned

to the client. If the client has also specified a sort, the results returned from the view will be resorted so the

final output matches the query sent by the client. This is true for LIMIT statements as well. If the view limits

the results to a given number, the limit defined in the view will be applied before a limit in the calling query.

The query to get data from a view will never override the query used to define the view.


C H A P T E R   1 2   ■ V I E W S

The manager is indeed quite content with this new feature; however, she also wants to

be able to see the number of orders shipped on each date. We can supply this information by

creating a view of the orders table with a GROUP BY clause, as shown in Listing 12-9.

Listing 12-9. Using a GROUP BY Clause to Create a View

mysql> CREATE ALGORITHM = TEMPTABLE VIEW ship_summary

(date, number_of_orders) AS

SELECT ship_date, count(ship_date)

FROM cust_order

GROUP BY ship_date;

Listing 12-10 shows the output of selecting all of the fields in the ship_summary view.

Listing 12-10. Output of a View with a GROUP BY Clause

mysql> SELECT * FROM ship_summary;

+------------+------------------+

| ship_date  | number_of_orders |

+------------+------------------+

| 2005-08-27 |                1 |

| 2005-08-28 |                1 |

| 2005-08-31 |                1 |

| 2005-09-01 |                2 |

| 2005-09-10 |                1 |

| 2005-09-27 |                1 |

+------------+------------------+

6 rows in set (0.00 sec)

The ship_summary view could easily be tweaked to further break down statistics by adding

a HAVING clause to the GROUP BY statement. Just as you can when using SQL statements to get

data from tables, you can add all kinds of limits to the grouped results when creating a view.

For example, Listing 12-11 shows how to limit the output of the ship_summary to include only

dates where one order was shipped.

Listing 12-11. Using HAVING with GROUP BY to Create a View

mysql> CREATE ALGORITHM = TEMPTABLE VIEW small_ship_dates

(ship_date, number_of_orders) AS

SELECT ship_date, count(ship_date)

FROM cust_order

GROUP BY ship_date

HAVING count(ship_date) < 2

ORDER BY ship_date;

A query of the data using the small_ship_dates view gives us a list of dates where only one

order was shipped, as shown in Listing 12-12.


C H A P T E R   1 2   ■ V I E W S

Listing 12-12. Output of a View with a HAVING Clause

mysql> SELECT * FROM small_ship_dates;

+------------+------------------+

| ship_date  | number_of_orders |

+------------+------------------+

| 2005-08-27 |                1 |

| 2005-08-28 |                1 |

| 2005-08-31 |                1 |

| 2005-09-10 |                1 |

| 2005-09-27 |                1 |

+------------+------------------+

5 rows in set (0.00 sec)

Unioned Tables

Views can also be created by two or more SELECT statements joined together with a UNION

statement. As explained in Chapter 7, the UNION statement allows you to join multiple queries

that have the same fields.

To illustrate how multiple SQL statements might be joined with a UNION, suppose our

online ordering system forwards the order to a certain fulfillment center based on the geo-

graphic location of the person placing the order. Each center keeps a separate record of the

customers. We want to provide a way to query customers across all centers, so we pull their

databases onto a single server and create a view that centralizes their databases onto a single

table using a UNION statement. Listing 12-13 shows a sample of the customer table from the

region 1 database.

Listing 12-13. Sample Customer Database from Region 1

mysql> SELECT * FROM region1.customer;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | Mike    |

|           2 | Jay     |

+-------------+---------+

2 rows in set (0.00 sec)

shown in Listing 12-14.

Listing 12-14. Creating a View with UNION

mysql> CREATE VIEW all_customers AS

SELECT * FROM region1.customer

UNION SELECT * FROM region2.customer

UNION SELECT * FROM region3.customer;

We can easily create a view that pulls data from all three regions with the CREATE statement


C H A P T E R   1 2   ■ V I E W S

A simple SELECT statement will now present results from all three tables, as shown in

Listing 12-15.

Listing 12-15. Output of Selecting from the View Created with UNION

mysql> SELECT * FROM all_customers;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | Mike    |

|           2 | Jay     |

|           3 | Johanna |

|           4 | Michael |

|           5 | Heidi   |

|           6 | Ezra    |

+-------------+---------+

6 rows in set (0.00 sec)

mysql> SELECT * FROM all_customers;

+--------+-------------+---------+

| region | customer_id | name    |

+--------+-------------+---------+

|      1 |           1 | Mike    |

|      1 |           2 | Jay     |

|      2 |           3 | Johanna |

|      2 |           4 | Michael |

|      3 |           5 | Heidi   |

|      3 |           6 | Ezra    |

+--------+-------------+---------+

6 rows in set (0.00 sec)

Listing 12-15 offers a convenient snapshot of the customer data pulled from the three

different regions. The view might be more useful if, along with the combined data, we also

included the data source for each customer record. Listing 12-16 presents a statement for

creating a view that will include a column indicating from which region the customer record

originates.

Listing 12-16. Creating a UNION View with a Data Source

mysql> CREATE OR REPLACE VIEW all_customers (region, customer_id, name) AS

SELECT 1, customer_id, name FROM region1.customer

UNION SELECT 2, customer_id, name FROM region2.customer

UNION SELECT 3, customer_id, name FROM region3.customer;

The output from a simple SELECT statement applied to the all_customers table now

includes the number of the region where the data resides, as shown in Listing 12-17.

Listing 12-17. Output of a UNION View with a Data Source


C H A P T E R   1 2   ■ V I E W S

Check Options

When creating an updatable view (a view that is part of an UPDATE, INSERT, or DELETE state-

ment, as described in the next section), MySQL allows you to specify how much the parser will

do when processing an update. This is done with the WITH CHECK OPTION syntax tacked onto the

end of your SQL statement when creating a view. Enabling check options tells the parser to

review the WHERE clause that defines the view when processing a statement to update a record

or set of records in the view. With check options enabled, you aren’t allowed to insert, update,

or delete any records from the view (and subsequently the underlying table) unless the INSERT,

UPDATE, or DELETE statement affects rows available within the view.

Two keywords can be added to the WITH CHECK OPTION statement: LOCAL and CASCADING.

The default, LOCAL, tells the query parser that when a user is attempting to update a view, a

check should be made of the SELECT statement that defines the view to ensure that the data

being updated is part of the view. Consider a previous example from Listing 12-2, which cre-

ated a view to display customer records from region 1. The view is updatable, but its CREATE

statement doesn’t include the CHECK OPTION syntax. In this case, a user can create an entry in

the table for region 2, even though the view doesn’t permit the user to see customers from

region 2. Listing 12-18 shows the CREATE statement with the WITH LOCAL CHECK OPTION set to

limit updates.

Listing 12-18. Creating a View with Check Options

mysql> CREATE OR REPLACE VIEW customer_region1 AS

SELECT customer_id, name, region FROM customer

WHERE region = 1 WITH LOCAL CHECK OPTION;

An attempted update to the customer_region1 view to set the region to a value not

included in the view results in a MySQL error is shown in Listing 12-19.

Listing 12-19. Illegal Update of a View with Check Options

mysql> UPDATE customer_region1 SET region = 2 WHERE customer_id = 1;

ERROR 1369 (HY000): CHECK OPTION failed 'shop.customer_region1'

■Note WITH CHECK OPTION is used with only an updatable view. If the algorithm is set to TEMPTABLE, or

the SQL statement uses syntax or a keyword that makes the view not updatable, specifying WITH CHECK

OPTION will result in a MySQL error: ERROR 1368 (HY000) at line 5: CHECK OPTION on ➥

non-updatable view.


C H A P T E R   1 2   ■ V I E W S

The CASCADING option checks both the current view, and if the current view is based on

another view, the check looks at that view as well to verify that the change conforms to the

view definition. With the CASCADING keyword, the query parser continues down through all

views until the parser reaches a table to verify that all column and row changes that are in the

issued statement are defined in the hierarchy of views. Creating views based on other views

is covered in the “Defining Views of Views” section later in this chapter.

■Caution The CASCADE modifier to WITH CHECK OPTION is not part of the SQL:2003 specification. Use of

this option, while helpful for views of views, may result in incompatible CREATE statements in other database

systems.

Creating Updatable Views

Depending on the complexity of your views, you may be able to create views that can do more

than provide output of data. Views in MySQL are meant to be updatable, as long as the SQL

statement that creates the view doesn’t represent the underlying tables in such a way that an

update to the underlying data would be impossible to map through the view. We use the term

updatable to mean that a view can be a part of an UPDATE, an INSERT, or a DELETE statement.

To be updatable, the records in the view must have a one-to-one relationship with the

records in the underlying tables. Beyond that general restriction, a few other rules determine

if a view can be updated. The easiest way to describe what kinds of views are updatable is to

define the conditions under which a view becomes disqualified from being updatable. Views

are not updatable in the following cases:

• The view is created with the algorithm specified as TEMPTABLE.

• A table in the FROM clause is reference by a subquery in the WHERE statement.

• There is a subquery in the SELECT clause.

• The SQL statement defining the view joins tables.

• One of the tables in the FROM clause is a non-updatable view.

• The SELECT statement of the view contains an aggregate function such as SUM(),

COUNT(), MAX(), MIN(), and so on.

• The keywords DISTINCT, GROUP BY, HAVING, UNION, or UNION ALL appear in the defining

SQL statement.

As MySQL parses the query, it will consider the rules and mark the view as non-updatable

if any of the conditions are met. If none of these conditions is met, you will have an updatable

view.


C H A P T E R   1 2   ■ V I E W S

To illustrate, let’s go back to our example where we created a view to control which cus-

tomers could be viewed for employees in different regions. The data in the customer table is

shown in Listing 12-20.

Listing 12-20. Records in the customer Table

+-------------+--------+---------+

| customer_id | region | name    |

+-------------+--------+---------+

|           1 |      1 | Mike    |

|           2 |      1 | Jay     |

|           3 |      2 | Johanna |

|           4 |      2 | Michael |

|           5 |      3 | Heidi   |

|           6 |      3 | Ezra    |

+-------------+--------+---------+

Listing 12-21. Creating an Updatable View

CREATE OR REPLACE VIEW customer_region3 AS

SELECT customer_id, name, region FROM customer

WHERE region = 3 WITH LOCAL CHECK OPTION;

Listing 12-22. Records in the customer_region3 View

mysql> SELECT * FROM customer_region3;

+-------------+-------+--------+

| customer_id | name  | region |

+-------------+-------+--------+

|           5 | Heidi |      3 |

|           6 | Ezra  |      3 |

+-------------+-------+--------+

2 rows in set (0.00 sec)

Creating a view that shows just the records from region 3 will give us a one-to-one rela-

tionship between the records in the view and those in the customer table. Listing 12-21 shows

the creation of the customer_region3 view.

A SELECT statement of all the records in this view shows that we’re getting only the appro-

priate records, as shown in Listing 12-22.

Because this view doesn’t violate any of the criteria for creating an updatable view, we are

allowed to update one of the records:

mysql> UPDATE customer_region3 SET name = 'David' WHERE customer_id = 6;

Query OK, 1 row affected (0.01 sec)


C H A P T E R   1 2   ■ V I E W S

If we had specified TEMPTABLE as the algorithm, or had used some other syntax that would

cause the parser to mark the view as non-updatable, we would have a different response to

our attempt to update:

mysql> UPDATE customer_region3 SET name = 'David' WHERE customer_id = 6;

ERROR 1288 (HY000): The target table customer_region3 of the UPDATE is not updatable

Becoming familiar with the different rules for making a view updatable takes some time

and practice. For more reading on MySQL’s view implementation and the rules regarding

updatable views, see http://dev.mysql.com/doc/mysql/en/create-view.html.

Defining Views of Views

Not only does MySQL allow you to create virtual representations of data in tables, you can also

create a virtual representation of a view, or a view of a view. This can go as many levels deep as

you can maintain.

Creating a view of a view is identical to creating a view of a table. You use the same CREATE ➥

VIEW statement, but instead of naming a table in the SQL statement, you use the name of a view.

A view of a view can be a handy way to create cascading levels of access to data. One sce-

nario might involve a table filled with customer order and payment information. At the global

level, you might have a view that excludes payment information, for the global support staff.

At the regional level, you might provide two views: one with all information for a particular

region and a second view of everything except for the payment information. This scenario is

outlined in Table 12-1.

Table 12-1. Cascading Levels of Information for an Online Ordering System

View Name

Staff Position

Available Information

manage_all_orders

Global manager

support_all_orders

Global customer support

manage_region_orders

Regional manager

support_region_orders

Regional customer support

Customer number, address, ordered

items, payment information for all

regions

Customer number, address, ordered

items for all regions

Customer number, address, ordered

items, payment information for single

region

Customer number, address, ordered

items for single region

As discussed earlier in the section on creating views, the CASCADING parameter of WITH ➥

CHECK OPTION is designed to ensure that when you are using views of views, the statement

checks to determine if permissions on making updates to a table will cascade down through

all the view levels. As the check moves down through the levels of views, it checks to make sure

the INSERT, UPDATE, or DELETE operation is being made on data that is available in your view.

As you add more layers with views, it’s important to consider performance issues with

views. View performance is discussed near the end of this chapter. Also, consider if using

views of views adds an extra layer of unnecessary complexity.


C H A P T E R   1 2   ■ V I E W S

Managing Views

Once you have a set of views in place, you’ll likely need to manage those views. MySQL pro-

vides commands to display, change, and remove views.

Displaying Views

You can use the SHOW CREATE VIEW command to view the entire CREATE syntax used when cre-

ating a view:

SHOW CREATE VIEW [<database name>.]name

Listing 12-23 displays the output from the SHOW CREATE VIEW for the all_customers view

(using the \G option for output in rows).

Listing 12-23. Output of SHOW CREATE VIEW

mysql> SHOW CREATE VIEW all_customers\G

*************************** 1. row ***************************

View: all_customers

Create View: CREATE ALGORITHM=UNDEFINED VIEW `shop`.`all_customers`

AS select 1 AS `region`,`region1`.`customer`.`customer_id`

AS `customer_id`,`region1`.`customer`.`name`

AS `name` from `region1`.`customer`

union select 2 AS `2`,`region2`.`customer`.`customer_id`

AS `customer_id`,`region2`.`customer`.`name`

AS `name` from `region2`.`customer`

union select 3 AS `3`,`region3`.`customer`.`customer_id`

AS `customer_id`,`region3`.`customer`.`name`

AS `name` from `region3`.`customer`

1 row in set (0.00 sec)

SHOW CREATE VIEW doesn’t produce the most readable output (we’ve inserted some line

breaks for formatting), but it will provide you with a statement that can be used to re-create

the view. If you require something more readable, and are more interested in seeing the col-

umn names and data types, the DESCRIBE statement works on a view just as it does on a table.

Listing 12-24 shows the output from a DESCRIBE on the all_customers table.

Listing 12-24. Output of DESCRIBE all_customers

mysql> DESCRIBE all_customers;

+-------------+-------------+------+-----+---------+-------+

| Field       | Type        | Null | Key | Default | Extra |

+-------------+-------------+------+-----+---------+-------+

| region      | bigint(20)  | NO   |     | 0       |       |

| customer_id | int(11)     | NO   |     | 0       |       |

| name        | varchar(10) | YES  |     | NULL    |       |

+-------------+-------------+------+-----+---------+-------+

3 rows in set (0.00 sec)


C H A P T E R   1 2   ■ V I E W S

One other place to find information about your views is in the data dictionary file. The data

dictionary file is stored in the directory with the data files for the database. The view name is

used to name the .frm file. If your data directory is /data/mysql, the ship_summary view diction-

ary file can be found at /data/mysql/shop/ship_summary.frm. A look inside this file reveals

numerous expected fields and values, plus some additional ones, as shown in Listing 12-25.

Listing 12-25. The ship_summary.frm Data Dictionary File

shell> cat /data/mysql/shop/ship_summary.frm

TYPE=VIEW

query=select `shop`.`cust_order`.`ship_date` AS `date`,

count(`shop`.`cust_order`.`ship_date`) AS `number_of_orders`

from `shop`.`cust_order`

group by `shop`.`cust_order`.`ship_date`

md5=492eb8a32a6bd3b57b5f9f73be4db621

updatable=0

algorithm=1

with_check_option=0

revision=1

timestamp=2005-04-27 19:44:43

create-version=1

source=CREATE ALGORITHM = TEMPTABLE VIEW ship_summary\n

(date,number_of_orders) AS\n

SELECT ship_date, count(ship_date)\n

FROM cust_order\n

GROUP BY ship_date

The TYPE, updatable, algorithm, with_check_option, and source fields contain values we

set and would expect to be in the definition. The following fields are used internally by

MySQL, but they can provide valuable information:

• query: This information is the internal representation of the view’s SELECT statement.

• md5: This field stores a hash of the view for verification that the data dictionary hasn’t

changed.

• revision: This keeps track of the version number of the view.

• timestamp: This maintains the date and time of the CREATE or last ALTER statement.

• create-version: This is always set to 1 and doesn’t appear to be currently in use, but

perhaps will serve a purpose in the future.

■Note You may notice that in the ship_summary.frm data dictionary file, the query field looks different

from the source. When MySQL gets the CREATE statement, it takes the field labels specified after the view

name and maps them to the <column name> AS <label> syntax for internal use. While we continue to

recommend using the label definitions instead of the AS statement, it is interesting to see how MySQL trans-

forms the CREATE statement for internal use. In this case, we’re seeing the syntax of the SQL:2003 standard

being mapped to the syntax understood by the existing MySQL query parser.


C H A P T E R   1 2   ■ V I E W S

Changing Views

The ALTER VIEW statement is the same as the CREATE statement, except for the omission of

the OR REPLACE option. In fact, the ALTER VIEW statement does the same thing as CREATE OR ➥

REPLACE, except that in the case of ALTER, a view of the same name must already exist. Lack of

a view with the same name will result in a MySQL error. In altering a view, you are required to

specify the attributes, columns, and SQL statement. None of these items is required to stay the

same as the currently defined view, except for the name. The full ALTER statement looks like this:

ALTER [<algorithm attributes>] VIEW [<database>.]< name> [(<columns>)] AS

<SELECT statement> [<check options>]

The algorithm attributes, database, name, columns, SELECT statement, and check options

are covered in detail in the previous section detailing the syntax of the CREATE statement.

To demonstrate using the ALTER VIEW command, suppose the customer support staff has

been using the view created in Listing 12-16, which uses a UNION of multiple customer tables,

but now they have started complaining about it. They would like to see the following changes:

• The query results return a region number, but the regions had been recently assigned

names, and nobody remembers the region numbers anymore. Rather than seeing

region numbers in their SELECT statements, they want to have the appropriate region

name instead.

• Case-sensitivity issues involving the customer table’s name have prompted requests to

capitalize the output of the name column (the names are being used to programmati-

cally compare customer data with names from a purchased mailing list).

• The shipping labels have problems if the names are too long, prompting a request to

provide a column highlighting the name length, so they can scan down and ensure

none of the labels will be misprinted.

All of these requests are easy to accommodate with a few changes to the previous view

definition: change the region to the appropriate names, add a function that changes the name

to uppercase, and add a new column that is a count of the characters in the name column.

The ALTER VIEW statement to make these changes is shown in Listing 12-26.

Listing 12-26. ALTER VIEW Statement

mysql> ALTER VIEW all_customers (region,customer_id,name,name_length)

AS SELECT 'northeast', customer_id, upper(name), length(name) FROM region1.customer

UNION SELECT 'northwest', customer_id, UPPER(name), LENGTH(name)

FROM region2.customer

UNION SELECT 'south', customer_id, upper(name), length(name) FROM region3.customer;

Now the customer support folks will be happier with the query results, and perhaps be

less prone to making mistakes with the zones and package labels. Listing 12-27 shows the

output of the altered view.


C H A P T E R   1 2   ■ V I E W S

Listing 12-27. Output from the Altered View

mysql> SELECT * FROM all_customers;

+-----------+-------------+---------+-------------+

| region    | customer_id | name    | name_length |

+-----------+-------------+---------+-------------+

| northeast |           1 | MIKE    |           4 |

| northeast |           2 | JAY     |           3 |

| northwest |           3 | JOHANNA |           7 |

| northwest |           4 | MICHAEL |           7 |

| south     |           5 | HEIDI   |           5 |

| south     |           6 | EZRA    |           4 |

+-----------+-------------+---------+-------------+

6 rows in set (0.00 sec)

■Note Listings 12-26 and 12-27 demonstrate a simple example of using functions in the view definition to

create new data, which isn’t part of the underlying tables. In the all_customers view, the name_length

column doesn’t exist in the underlying tables, but is the value returned from a function. Views are an excel-

lent way to present new results derived from performing functions on or calculations with existing data.

Removing Views

To delete a view, use the DROP VIEW command. As with all DROP commands (index, table, proce-

dure, database, and so on), DROP VIEW takes one argument: the name of the view to be dropped.

DROP VIEW [IF EXISTS] [<database>.]<name>

For example, to drop the all_customers view, issue this statement:

mysql> DROP VIEW all_customers;

A database name can be prepended to the view name if you want to be explicit or are

dropping a view in a database other than the current, active database. You can add the

IF EXISTS syntax if you would like to prevent an error from occurring if the view does not

exist. A warning is generated when removing a nonexistent view with the IF EXISTS syntax.

■Tip When a view is altered or replaced, MySQL makes a backup copy of the data dictionary file in

<datadir>/<database name>/arc. A copy is not made when the view is dropped. If you accidentally drop

a view, check the arc directory for an old copy that was saved on an ALTER or REPLACE operation. You may

be able to use that copy for re-creating the view.


C H A P T E R   1 2   ■ V I E W S

View Permissions

Permissions on views are fairly straightforward. To create views, you must have the CREATE VIEW

privilege in the database where you are creating a new view. In addition, the creator must have

some privilege on each of the columns specified to be used in the view output, and SELECT privi-

lege for columns used in the WHERE clause of the SQL statement that is a part of the view creation.

To use the ALTER VIEW statement, you must have CREATE VIEW and DROP privileges for the

view you’re attempting to change. As when you’re creating a view, you must have permissions

on the underlying table.

When removing a view, you are required to have the DROP privilege for the view. The DROP

privilege can be granted globally in the mysql.user table or for a specific view in the

tables_priv table.

To use a view, users can be granted SELECT privileges for a specific view, and they can then

select from that view without having any additional privileges on the underlying tables:

GRANT SELECT ON shop.all_customers TO mkruck@localhost;

To update the data in a view, the updating user needs to INSERT, UPDATE, or DELETE permis-

sions on the underlying table or tables to be changed. Managing table permissions is covered

in Chapter 15.

Performance of Views

Perhaps you’re wondering what kind of impact going through a view to the data will have on

the performance of your SQL statements.

First, it’s important to remember that the performance of a view is not going to be any

better than the performance of the underlying tables. If your tables aren’t optimized, or are

organized poorly, a view to clean things up might help the interface, but it won’t help perform-

ance of your queries.

Second, views rely on the indexes of the underlying tables. If your view is created on a

table with ten million records, using a WHERE clause referencing columns without indexes, the

view will perform just as poorly as the query. For the best performance, indexes on underlying

tables should be designed to match the SELECT statement used in defining views.

■Note Views do not have indexes of their own. They rely on the indexes of the underlying tables to provide

optimized lookups.

If your data is well organized and your indexes are in good condition, your views will per-

form well. In essence, when using the MERGE algorithm, MySQL creates a new, single query, which

pulls the appropriate data from the table or tables. There is minimal processing between the

view and the data, meaning your query can execute quickly without a lot of layers or logic to go

through to get to the data. In addition, queries against views are stored in the buffer subsystem

and query cache, if enabled. This means that, in some instances, your query of a view doesn’t

even look at the view or underlying table, but goes directly to the query cache. (See Chapter 4

for more information about MySQL’s buffer subsystem and query cache.)


C H A P T E R   1 2   ■ V I E W S

You will see more of a performance hit if your view uses the TEMPTABLE algorithm. As

explained earlier in the chapter, using this method, the database first retrieves the records

from the underlying tables and puts them in a temporary table, where it then runs the incom-

ing SELECT statement. Depending on the size of your underlying tables, creating and populating

a temporary table can be a significant performance hit.

Running Performance Tests

We ran a number of tests to try to get a sense of the performance implications of using views.

For SELECT, INSERT, UPDATE, and DELETE, we ran a million statements into the database and

averaged the amount of queries processed every second, both when running directly against

the customer table and when running against a view of the customer table, customer_view. The

SELECT statement grabbed all rows in the customer table or customer_view view, sending the

output of eight records into a log file a million times. The INSERT created a million new cus-

tomer records in the customer table or customer_view view, and the UPDATE performed a

million updates on existing records in the customer table or customer_view view. The DELETE

statement removed all million customer records, one at a time. The customer table uses the

MyISAM storage engine.

The metrics were performed on MySQL 5.0.2, running on a single AMD64 2800+, with

1GB of RAM and a 10,000 RPM SCSI data disk. The database is the prebuilt binary for AMD64

and was configured with all default options (no .my.cnf file used on startup), except for when

using the query cache, where the only configuration item was query_cache_size=1000000.

(See Chapter 14 for details on configuring MySQL.) Table 12-2 shows the results in queries

per second.

SQL Statement

Queries/Second on Table

Queries/Second on View

Table 12-2. Performance Tests for MySQL Views

Select all rows in customer table,

query cache disabled

Select all rows in customer table,

query cache enabled

Insert customer record

Update customer record

Delete customer record

11,494

21,052

16,694

17,241

13,698

7,936

21,052

10,111

9,803

8,984

Both the insert and update metrics are against views with simple definitions, not including

WHERE clauses and check options. We ran some additional tests, using a view with a definition

that included a WHERE clause and check options. The difference between a simple view and a

complex view was negligible, adding only a total of five or six seconds when processing a mil-

lion records.

We also tested the performance of views of views and found that adding in another view

layer was comparable to the difference between the table and the first view, meaning that

every view you add will decrease your performance by that much again.

We did not perform tests with views that used temporary tables. Why? We really wanted

to get at how much overhead it takes for MySQL to process a SQL statement, merge it with the

view definition, and return results from the new statement. When you use views with temporary


C H A P T E R   1 2   ■ V I E W S

tables, performance is largely affected by how much data is in your tables. The bottom line is

that test results on temporary tables will be more useful if the tests are performed in your

environment.

Using EXPLAIN

As with queries against tables, you can use the EXPLAIN syntax on a query of a view:

EXPLAIN SELECT * FROM all_orders WHERE customer_id = 1;

The output of the EXPLAIN will reflect the indexes of the underlying tables, not the view

itself, as views do not have indexes. See Chapters 6 and 7 for details on interpreting the output

of EXPLAIN.

Summary

In this chapter, we’ve introduced you to the general concept of views, and some ideas for gen-

eral application of view technology. We discussed the views as implemented by MySQL and

dug into the details of creating and maintaining views. We also went through the updatable

nature of views, using views of views, and performance issues in implementing a view of a real

table. The examples throughout this chapter demonstrated the power of using views in your

application.

As we’ve emphasized throughout the book, it is always important to make technology a

part of your larger application, or even organizational, plans. Using views can be extremely

helpful, but can also cause problems if they aren’t the right fit for the particular need. Always

make an assessment of the organizational, application, and data needs before jumping to a

conclusion about which technology to implement to meet that need.

That being said, views can be a lifesaver to a database administrator, application developer,

end user, or anyone who comes in contact with your database or data. The ability to rearrange,

compile, combine, limit, relabel, hide, and sort data in virtual tables opens up endless possibili-

ties in meeting the demands of your data destinations.


C H A P T E R   1 3

■ ■ ■

Triggers

With the introduction of triggers in versions 5.0.2 and greater, MySQL provides more built-in

support for helping you manage changes to your data. Triggers are a powerful tool for associ-

ating a set of SQL statements with a particular event in your database. As with the other new

features we covered in the previous chapters—stored procedures, stored functions, and cur-

sors—triggers are available in other database systems, such as DB2, Oracle, SQL Server, and

PostgreSQL.

We have a lot of ground to cover in using MySQL’s trigger functionality. This chapter will

discuss the following topics:

• Database trigger basics

• The advantages and disadvantages of using triggers

• MySQL’s implementation of triggers

• How to create triggers

• An example of using triggers

• Trigger permissions

• Performance of triggers

Database Triggers

A database may process changes to its data on the order of thousands of requests per second.

Each request may INSERT, ALTER, or DELETE data from any number of tables. While this possibil-

ity of robust data management is what brought a database into the picture in the first place, it

stands to reason that with each change in the data, you may want to associate particular pieces

of logic. Perhaps you want to avoid inconsistencies by doing some extra data validation before

saving a row. Maybe you would also like to keep track of changes in your tables by saving the

current values into an audit table, before the data changes are made to the table.

Prior to version 5.0.2, you could rely on MySQL to ensure columns matched, and even use

foreign key restraints to ensure integrity, but any further validation would be left to the appli-

cation. Maintaining an audit table would require the application to load the rows that would

be affected by the change prior to making the INSERT, UPDATE, or DELETE; save those rows to the

audit table; and then perform the changes in the data. With MySQL version 5.0.2 and later, you

can now accomplish these tasks with triggers.


C H A P T E R   1 3   ■ T R I G G E R S

A trigger is a statement, or set of statements, that is stored and associated with a particu-

lar event happening on a particular column or table. The current SQL standard, SQL:2003,

specifies that the events allowed to activate a trigger are INSERT, UPDATE, or DELETE. The inten-

tion is to provide a mechanism to run any number of SQL statements whenever data changes

in a given table as a result of one of the activating events. When the specified event occurs, the

trigger is activated, and the statements defined in the trigger are run—either before or after

the event, based on the definition of the trigger. Additionally, triggers are similar to stored pro-

cedures in that you can tap into the power of variables and control structures when creating

the body of the trigger.

Before we look at more details of how MySQL implements triggers, let’s consider the pros

and cons of using triggers in your database applications.

■Note As we write this chapter, MySQL has released version 5.0.6, which is labeled a beta release. While

the database is stable enough to test and document the functionality of triggers, production users are

encouraged to wait until a release of the 5.0.x branch that is labeled for production.

The Debate Over Using Triggers

As you might expect, some application developers and database administrators believe that

using triggers is good practice, and others are passionately against it. A review of some of the

arguments both for and against triggers will give you a sense of the strengths and weaknesses

of development that relies on having triggers in the database. As with all technologies, you

need to determine how your unique application might benefit or suffer from using triggers.

The statements for and against triggers are not MySQL-specific, and include points

pertaining to triggers in general, across all varieties of database systems. Thus, some of the

arguments might apply specifically to functionality available in other database systems but

not currently available in MySQL.

■Note The debate over whether to use a specific technology is often based on favorable or unfavorable

experience with that technology, which may include forced use of technology where it was actually inappro-

priate. This can lead to some vehement and emotional opinions about how useful and appropriate a particular

technology is for an application. When making decisions on how to use technology, you should attempt to be

objective and see both sides of the argument, focusing on how the technology might meet the requirements

for your database or application needs.


C H A P T E R   1 3   ■ T R I G G E R S

Trigger Advantages

Since this chapter is about using triggers, let’s start with a review of the reasons you may find

triggers appropriate for your database:

• Triggers provide a complementary, and more robust, integrity checking mechanism to

foreign keys. Triggers can check more than just the presence of a certain foreign key;

they can verify that the foreign key record has certain other characteristics. Using the

advanced capabilities for integrity checking available with triggers, you can avoid

needing to put some or all data integrity checks in your application.

• You can catch business process errors using triggers. This goes beyond simple data

validation and into the enforcement of more complex rules. For example, if you want

to limit the number of unprocessed orders for an individual customer to five, a trigger

on INSERT could check to make sure there weren’t already five unprocessed orders.

• When enforcing complex rules with triggers, you ensure that in every case where a

change is made, the trigger code is run. If the data rules were contained only in the

code that makes up your web-based application, any changes made in the database

from the MySQL client tools or from other programs outside your web pages wouldn’t

get the same functionality.

• If scheduled tasks or scripts run periodically to perform checks or cleanup of data, trig-

gers can provide a method to put those checks directly in the database. This means you

don’t need to wait for the cron task to run to have the data changed. One example of

this is a cache table that removes expired entries when a new entry is inserted.

• If you need to make changes in one table based on changes in another table, a trigger

handles moving the existing values into a new table more efficiently than the applica-

tion can. An example might be a customer_history table that keeps track of all changes

in the customer table. Before you change a customer record, you write a record to the

customer_history table with the current field values. If you were to put this kind of

functionality in the application, you would need to first select the row of the customer

table and insert the values into the customer_history table before updating the

customer record. That involves execution of three queries from your application. With

a trigger, this functionality is handled in the database, and the application only needs

to send the UPDATE statement.

• Triggers are useful if you need to perform a calculation before inserting or updating a

row. For example, you might want to calculate the total cost based on the item cost and

the shipping, and insert that value in another column. A trigger can take care of auto-

matically calculating and setting the value for the total cost column.

Before you run off to your database and start moving your validation and business logic

into database triggers, let’s consider the reasons why you might not want to use triggers.


C H A P T E R   1 3   ■ T R I G G E R S

Trigger Disadvantages

Although there aren’t as many arguments against using triggers as there are in favor, you

should nonetheless weigh them carefully:

• While triggers might provide extended validation, they aren’t a replacement for all vali-

dation. For instance, using a client-side scripting language to validate a web form is a

simple, user-friendly way to alert the user of an issue, without needing to submit the

form. In most cases, going all the way from the user’s browser through the network and

application to the database just to validate a form field doesn’t make a lot of sense.

• The proliferation of triggers across many tables could result in a situation where a

change in one table sets off a chain of trigger activations that are ultimately difficult

to track and therefore hard to debug. An example might be an update in the customer

table that triggers a change in the address table that activates a trigger in the order

table. If one of the triggers is dropped, or has a bug in how it processes data, tracking

down a problem spread across many triggers on a number of tables can quickly turn

into a nightmare.

• Development tools for triggers aren’t as slick and sophisticated as application develop-

ment tools. If you need a proven development environment for developing your business

logic, the tools for writing database triggers won’t be as readily available as tools for writing

business logic in languages such as PHP, Perl, and Java.

• Editing a PHP script on the file system is more straightforward than getting the trigger

statement out of the database, making changes, and going through the steps to drop

and re-create the trigger.

■Note Chapter 9 includes a discussion regarding the practicality of using stored procedures. That discus-

sion contains a number of points similar to the arguments presented in this chapter for using triggers, and

might provoke some additional thoughts on how to decide to use database technology.

Triggers in MySQL

MySQL aims at using the SQL standards when implementing new or updating existing func-

tionality. MySQL triggers adhere to this rule. With one exception—the use of the NEW and OLD

keywords—the syntax used in MySQL matches the syntax defined for the SQL:2003 standard.

However, there is syntax in the standard that MySQL doesn’t support, such as the ATOMIC and

REFERENCING keywords, the ability to specify column names for an UPDATE trigger, and a WHERE

clause for conditional checks.

If you’re coming from another database environment where you’ve used triggers, you may

find that MySQL’s implementation is similar. In most cases, the MySQL syntax is a smaller sub-

set of the functionality that is used elsewhere.1 Most database systems have trigger support

with helpful syntax extensions, which are not available in MySQL.

1. While the concepts for creating triggers are similar, SQL Server has a unique syntax for creating trig-

gers that differs from the syntax in the current documentation for Oracle, DB2, and PostgreSQL.


C H A P T E R   1 3   ■ T R I G G E R S

MySQL triggers are independent of the storage engines used to store the data. They can

be used with any of the available storage engines. (See Chapter 5 for details on MySQL storage

engines.)

In MySQL, triggers are stored in <data directory/<database name>/<table name>.TRG, a

text file that contains the definitions of all triggers created for events on that table. This file can

contain multiple trigger definitions, which are added to and removed from the file as they are

created and dropped from the MySQL client. Since the file is plain text, it is possible to view

the file in a text viewer or editor. Within the file, you’ll find triggers=, followed by numerous

trigger statements, each surrounded in single quotation marks. Be warned, with longer trigger

definitions, the file becomes seriously unreadable.

■Caution We advise against editing the .TRG file manually with a text editor. It can be done, but direct

editing of the .TRG file could lead to problems in future versions of MySQL if the internal storage mechanism

or format changes.

MySQL triggers are loaded into the database memory when they are created or when the

database is started. Each time an update is made that activates the trigger, the SQL statements

of the trigger are already in memory and don’t need to be read from the trigger file.

When you’re using triggers in MySQL, you should be aware of the following restrictions:

• Triggers cannot call stored procedures.2

• Triggers cannot be created for views or temporary tables.

• Transactions cannot be started or ended within a trigger. This means you can’t do

something like start a transaction in your application, and then close the transaction

with a COMMIT or ROLLBACK statement from within the trigger. (See Chapter 3 for details

on MySQL transactions.)

• Creating a trigger for a table invalidates the query cache. If you rely heavily on the query

cache, be warned that queries being pulled from the cache will need to be regenerated

from the data tables after a trigger is created. (See Chapter 4 for details on the query

cache.)

• Triggers share table-level namespaces. This means that currently you can’t have two

triggers with the same name on a particular table. MySQL encourages using unique

trigger names across an entire database, should the namespace be moved to the data-

base level.3

2. We found that you can actually put the CALL statement in a trigger, but when the trigger fires, it fails

on a procedure does not exist error, even if the procedure exists and can be called from outside the

trigger.

3. The SQL:2003 specification calls for the trigger namespace to be at the database level. MySQL hints at

a future release moving the trigger namespace to the database level, requiring unique trigger names

across an entire database, not just for a specific table.


C H A P T E R   1 3   ■ T R I G G E R S

■Note MySQL is constantly under active development. While we feel it’s important to document the exist-

ing implementation details of triggers in MySQL, we also want to note that the functionality is improving and

will likely mean some of the noted implementation details and limitations will be changed. You can find more

details and current information about MySQL’s trigger implementation at http://dev.mysql.com/doc/

mysql/en/triggers.html.

Now that we’ve gone through the significant pieces that characterize MySQL’s implemen-

tation of triggers, let’s move on to the details of writing SQL to create database triggers.

Creating MySQL Triggers

To get started, let’s go through a simple example. Going back to the scenario introduced earlier

in the chapter, suppose that we need to track changes to our customer table. Rather than need-

ing to program our application to keep a history of the changes, we want to use the database

to take care of the audit trail, creating a record of the current data before it is changed. This

seems like a perfect place to put trigger functionality.

To demonstrate how triggers work, we’ll begin with the same customer table we’ve used in

previous chapters, as shown in Listing 13-1.

Listing 13-1. Records in the customer Table

mysql> SELECT * FROM customer;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | Mike    |

|           2 | Jay     |

|           3 | Johanna |

|           4 | Michael |

|           5 | Heidi   |

|           6 | Ezra    |

+-------------+---------+

6 rows in set (0.00 sec)

In order to keep track of changes in the customer table, we want to add a customer_audit

table. The customer_audit table structure is shown in Listing 13-2.


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-2. Description of the customer_audit Table

mysql> DESC customer_audit

+-------------+-------------+------+-----+---------+----------------+

| Field       | Type        | Null | Key | Default | Extra          |

+-------------+-------------+------+-----+---------+----------------+

| id          | int(11)     | NO   | PRI | NULL    | auto_increment |

| action      | char(50)    | YES  |     | NULL    |                |

| customer_id | int(11)     | YES  |     | NULL    |                |

| name        | varchar(50) | YES  |     | NULL    |                |

| changed     | datetime    | YES  |     | NULL    |                |

+-------------+-------------+------+-----+---------+----------------+

Every time either an UPDATE or DELETE is made to the customer table, we want to record the

action, current customer_id, name, and the time of the change. While doing this in the applica-

tion is possible, it requires getting all matching records before the UPDATE or DELETE statement

and using the application to insert the records into the audit table. With a trigger, the database

can be programmed to take care of creating the log of changes.

To be sure updates are saved as a part of the audit, we create a trigger on the customer

table that will be activated on any UPDATE to the table. Listing 13-3 shows a trigger that is built

to handle updates, named before_customer_update.

Listing 13-3. Creating the before_customer_update Trigger

DELIMITER //

CREATE TRIGGER before_customer_update BEFORE UPDATE ON customer

FOR EACH ROW

BEGIN

INSERT INTO customer_audit

SET action='update',

customer_id = OLD.customer_id,

name = OLD.name,

changed = NOW();

END

//

DELIMITER ;


C H A P T E R   1 3   ■ T R I G G E R S

We will look more closely at the CREATE TRIGGER statement shortly. This trigger, as indi-

cated in the CREATE TRIGGER statement, is set to activate prior to an update to records in the

table. The before_customer_update trigger inserts a row into the customer_audit table each

time a record is updated. We can see this in action by issuing an UPDATE statement, as shown in

Listing 13-4.

Listing 13-4. Updating customer Records

mysql> UPDATE customer SET name=UCASE(name);

Query OK, 6 rows affected (0.01 sec)

■Note As of MySQL version 5.0.6, there is a bug with locking the correct tables when a trigger is activated.

If your trigger contains data-changing statements, you will need to lock the tables used in your trigger. For

this example, the customer and customer_audit tables need to be locked, changing the UPDATE statement

in Listing 13-4 to LOCK TABLES customer WRITE, customer_audit WRITE; UPDATE customer SET ➥

name = ucase(name); UNLOCK TABLES;. As of this writing, this bug is marked as critical and should be

resolved in an upcoming release.

The UPDATE statement in Listing 13-4 will change all the values in the name column of the

customer table to uppercase, as shown in Listing 13-5.

Listing 13-5. Records in the customer Table After Updating

mysql> SELECT * FROM customer;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | MIKE    |

|           2 | JAY     |

|           3 | JOHANNA |

|           4 | MICHAEL |

|           5 | HEIDI   |

|           6 | EZRA    |

+-------------+---------+

Listing 13-5 demonstrates that the record change to uppercase took effect. Now, let’s see

if the trigger activated and logged the previous record. Listing 13-6 shows the records in the

customer_audit table.


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-6. Records in the customer_audit Table After Updating

mysql> SELECT * FROM customer_audit;

+----+--------+-------------+---------+---------------------+

| id | action | customer_id | name    | changed             |

+----+--------+-------------+---------+---------------------+

|  1 | update |           1 | Mike    | 2005-05-10 22:20:44 |

|  2 | update |           2 | Jay     | 2005-05-10 22:20:44 |

|  3 | update |           3 | Johanna | 2005-05-10 22:20:44 |

|  4 | update |           4 | Michael | 2005-05-10 22:20:44 |

|  5 | update |           5 | Heidi   | 2005-05-10 22:20:44 |

|  6 | update |           6 | Ezra    | 2005-05-10 22:20:44 |

+----+--------+-------------+---------+---------------------+

6 rows in set (0.00 sec)

As you can see in Listing 13-6, the customer_audit table contains the previous value for

name and the time it was changed.

As part of our audit trail, we also want to keep track of any records that are removed from

the customer table. The before_customer_delete trigger defined in Listing 13-7 does this for

deletions to the customer table.

Listing 13-7. Creating the before_customer_delete Trigger

DELIMITER //

CREATE TRIGGER before_customer_delete BEFORE DELETE ON customer

FOR EACH ROW

BEGIN

INSERT INTO customer_audit

SET action='delete',

customer_id = OLD.customer_id,

name = OLD.name,

changed = NOW();

END

//

DELIMITER ;

Listing 13-7 looks a lot like the before_customer_update trigger, but the trigger is modified

to respond to DELETE statements against the customer table. Before any row is deleted from the

customer table, a record is inserted into the customer_audit table with the values of that row.

To test the trigger, we issue a command to delete all the records in the customer table:

mysql> DELETE FROM customer;

Query OK, 6 rows affected (0.01 sec)


C H A P T E R   1 3   ■ T R I G G E R S

This statement removes all the records from the customer table and activates the customer

table’s trigger for record deletions. If we look at the customer_audit table, we’ll see a row

inserted for each of the deletions from the customer table, as shown in Listing 13-8.

Listing 13-8. Records in the customer_audit Table After Deletions

mysql> SELECT * FROM customer_audit;

+----+--------+-------------+---------+---------------------+

| id | action | customer_id | name    | changed             |

+----+--------+-------------+---------+---------------------+

|  1 | update |           1 | Mike    | 2005-05-10 22:20:44 |

|  2 | update |           2 | Jay     | 2005-05-10 22:20:44 |

|  3 | update |           3 | Johanna | 2005-05-10 22:20:44 |

|  4 | update |           4 | Michael | 2005-05-10 22:20:44 |

|  5 | update |           5 | Heidi   | 2005-05-10 22:20:44 |

|  6 | update |           6 | Ezra    | 2005-05-10 22:20:44 |

|  7 | delete |           1 | MIKE    | 2005-05-10 23:00:20 |

|  8 | delete |           2 | JAY     | 2005-05-10 23:00:20 |

|  9 | delete |           3 | JOHANNA | 2005-05-10 23:00:20 |

| 10 | delete |           4 | MICHAEL | 2005-05-10 23:00:20 |

| 11 | delete |           5 | HEIDI   | 2005-05-10 23:00:20 |

| 12 | delete |           6 | EZRA    | 2005-05-10 23:00:20 |

+----+--------+-------------+---------+---------------------+

12 rows in set (0.00 sec)

As you can see, the table has entries for both the UPDATE and the DELETE statements we

ran, giving us a history of the changes to the customer table.

Now that you’ve seen some of the syntax and a working example, let’s take a look at the

details of each piece of the CREATE TRIGGER statement.

■Tip When you’re building triggers, we recommend you use a versioning system like CVS or subversion for

the source of the trigger creation statements. Trigger development, like other pieces of your database and

application, results in a piece of code that is valuable to your organization.

The CREATE Statement

The CREATE TRIGGER statement is used to define a trigger and associate it with changes occur-

ring in a table. It has the following syntax:

CREATE TRIGGER <name> <time> <event>

ON <table>

FOR EACH ROW

<body statements>


C H A P T E R   1 3   ■ T R I G G E R S

As you can see here, and in Listings 13-3 and 13-7, the CREATE TRIGGER statement takes

five required pieces: the name, time, event, table name, and one or more body statements.

With the time and event, you must choose from an enumerated set of options:

CREATE TRIGGER <name> [BEFORE | AFTER] [INSERT | UPDATE | DELETE]

As with stored procedures, functions, and cursors, when entering multiple-statement

blocks into MySQL, change the default delimiter to something other than the semicolon (;),

so MySQL will allow you to enter a semicolon without having the client process the input.

Change the delimiter by using the delimiter statement: DELIMITER //. This will change the

delimiter to //, meaning that you can use ; as many times as necessary. When you’re ready to

have your trigger created, type //, and the client will process your entire trigger statement.

When you’re finished working on the trigger, change the delimiter back to the standard semi-

colon with DELIMITER ;.

ALSO IN SQL:2003

MySQL contains a subset of the SQL:2003 syntax for database triggers. More of the syntax will be added in

the future, but currently, the following key items of the SQL:2003 database trigger specification are not

included in MySQL’s trigger syntax:

• When a trigger is declared using the UPDATE event, SQL:2003 allows you to specify a list of specific

columns, restricting the firing of the trigger to updates happening to the defined columns, not just the

entire row.

• Trigger definitions can contain a WHERE clause as a part of FOR EACH ROW. This clause lets you per-

form conditional checks on data in the record and limit running the trigger statements to specific rows

of data.

• The SQL:2003 standard indicates that the BEGIN statement can be followed by an optional ATOMIC

keyword, to make the block execute as one unit.

• The SQL:2003 standard specifies the use of a REFERENCING keyword that can follow the table name.

This part of the statement allows you to assign a name to the current record as well as to the incoming

record. Rather than needing to use OLD and NEW in your body statements, you can assign the old and

new records names like existing_customer and updated_customer, which make the trigger

statements more readable.

An update to the trigger functionality is coming with MySQL 5.1, which promises to have a more full-

featured implementation of the SQL:2003 syntax.

Trigger Name

When you name a trigger, it must conform to database rules for naming objects. The rules for

legal names can be found at http://dev.mysql.com/doc/mysql/en/legal-names.html. Also, the

trigger name must be unique for the table.


C H A P T E R   1 3   ■ T R I G G E R S

Since tables can have multiple triggers defined for different time and event types, we

recommend using a combination of the event type, time, and table name when naming your

triggers. This allows for creating multiple triggers on a single table without having conflicting

names. The SQL:2003 standard calls for unique trigger names across the entire database, so

we also recommend that you use the name of the table when naming your triggers, to avoid

conflicts with other triggers in the database.

Before adding triggers to your database, you should choose a naming convention that can

be used for triggers throughout your database and help clarify the purpose of the trigger. For

example, the names we used in the customer_audit example gave an indication of the scope

of the trigger:

CREATE TRIGGER before_customer_update . . .

CREATE TRIGGER before_customer_delete . . .

Activation Time

You must specify an activation time when you define a trigger. The time can be BEFORE or

AFTER, to run the statements in the trigger either before or after the event occurs. For example,

if you define the trigger to run AFTER an update, when the UPDATE statement is received by the

database, it will perform the update on the table, and then run the statements in the trigger

body. If you need to check the integrity of the fields in an INSERT statement, you will want the

statements in the body of the trigger to run BEFORE the record is inserted into the table.

How do you know what trigger timing is right?

• Use BEFORE when you want to perform an action prior to the change being made in the

table. This might include calculating a value or getting the current record’s values for

use elsewhere.

• Use AFTER if the action you want needs to happen after the changes are made in the table.

For example, if you need to create an empty placeholder entry in a customer_address

table after a new customer record is created, you probably don’t want to create the

customer_address record until after the customer record insertion is completed.

Choosing the trigger time affects what can be done in the body of SQL statements. When

you choose AFTER, the trigger is activated after the event completes, which means you cannot

change the values of the incoming query because the record has already been written to the

table.

In our earlier customer_audit example, both triggers had BEFORE timing:

CREATE TRIGGER before_customer_update BEFORE . . .

CREATE TRIGGER before_customer_delete BEFORE . . .

Event for Activation

When defining a trigger, you are required to specify the event during which the trigger will

activate: INSERT, UPDATE, or DELETE. To make a trigger fire on more than one event, you must

create multiple triggers, one for each event.


C H A P T E R   1 3   ■ T R I G G E R S

As with the activation time for a trigger, the event you specify in the trigger declaration

changes the kinds of SQL statements and logic that can be used in the body of the trigger. For

an INSERT event, there is no OLD record, because this is the initial creation of the record, not

the replacement of an existing one. If the trigger event is DELETE, there will not be a NEW record,

because no new data is being created; it involves only removal of the existing, or OLD, record.

In our customer_audit example, we had one trigger for an UPDATE event and one trigger

for a DELETE event:

CREATE TRIGGER before_customer_update BEFORE UPDATE . . .

CREATE TRIGGER before_customer_delete BEFORE DELETE . . .

Table to Activate the Trigger

When defining a trigger, you are required to specify the table that will activate the trigger on

the given event. As noted in the previous section about MySQL’s implementation of triggers,

the table cannot be a view or a temporary table.

The table name follows the timing and event parts of the trigger definition:

CREATE TRIGGER before_customer_update BEFORE UPDATE ON customer . . .

CREATE TRIGGER before_customer_delete BEFORE DELETE ON customer . . .

Trigger Body Statements

The SQL statements that compose the body of a trigger are where the real action happens.

Prior to the body definition, MySQL requires the keywords FOR EACH ROW, which means that

as an INSERT, UPDATE, or DELETE happens, the defined SQL statement or statements will be

executed one time for each of the records that are affected.

The trigger body can be a single SQL statement, or if wrapped within a BEGIN and END

clause, the body can contain multiple statements. This allows you to run a limitless number

of statements within a single trigger.4

OLD and NEW Keywords

Two keywords are unique to SQL statements used in defining triggers: OLD and NEW. These

keywords allow you to refer to the data before and after the activating event takes place. For

example, if you have defined a trigger that is activated before an update, you will be able to

reference fields in the current database record with OLD.<fieldname>. You can also reference

fields in the incoming record with NEW.<fieldname>. Listings 13-3 and 13-7 showed examples

of using the OLD syntax:

customer_id = OLD.customer_id,

name = OLD.name,

examples.

You’ll see examples of the NEW syntax in getting and setting record values in upcoming

4. We attempted to find a limit for the number of lines in a trigger. However, after successfully running a

script-generated, one million-line trigger (which required a change to the max_allowed_packet setting

to process the CREATE statement), we figured we would call it limitless.


C H A P T E R   1 3   ■ T R I G G E R S

■Note The OLD and NEW keywords are extensions to SQL:2003. However, the OLD and NEW keywords are

more like predefined names that the SQL:2003 standard allows for when using the REFERENCING syntax.

MySQL doesn’t currently support the REFERENCING keyword, so rather than letting you specify the name of

the old and new record, MySQL predefines them as OLD and NEW. In some ways, this makes the coding less

clear, because you can’t specify the names for the records, but it also means you’ll have uniform syntax

throughout all your triggers.

Variables and Flow Control Statements

Just like stored procedures and functions, triggers support the use of variables and flow con-

trols. Refer to Chapters 9 and 10 when you need to build triggers using flow controls. (Also see

http://dev.mysql.com/doc/mysql/en/flow-control-constructs.html.)

Using Triggers

Now that we’ve gone through the details on the syntax used to build a trigger, let’s look at a

second, more involved example to demonstrate the usefulness of triggers.

For this example, let’s suppose we’re working on the table that keeps track of customer

orders. The cust_order table, as shown in Listing 13-9, contains the order ID, date the order

was shipped, the sum of all the items, a discount percentage to be applied, the shipping cost,

and a total.

Listing 13-9. Description of the cust_order Table

mysql> DESC cust_order;

+------------------+------------------+------+-----+---------+----------------+

| Field            | Type             | Null | Key | Default | Extra          |

+------------------+------------------+------+-----+---------+----------------+

| cust_order_id    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |

| ship_date        | date             | YES  |     | NULL    |                |

| item_sum         | decimal(10,2)    | YES  |     | NULL    |                |

| discount_percent | int(2) unsigned  | YES  |     | NULL    |                |

| shipping         | decimal(10,2)    | YES  |     | 0.00    |                |

| total            | decimal(10,2)    | YES  |     | NULL    |                |

+------------------+------------------+------+-----+---------+----------------+

As records are inserted into this table, we want to automatically calculate the total, which

is derived from multiplying the sum of the items with the discount and adding in the shipping

charges. A single-statement procedure would accomplish this, as shown in Listing 13-10.

Listing 13-10. Trigger to Calculate the Total

CREATE TRIGGER before_cust_order_insert BEFORE INSERT ON cust_order

FOR EACH ROW

SET NEW.total = NEW.item_sum -

(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-10 shows the use of the NEW keyword, which sets the value of the incoming

record’s total field by performing a calculation on a few of the other fields. You’ll notice that if

you insert a record into the cust_order table with a NULL or zero value for the discount_percent,

you get some unpredictable results in the total.

This is corrected by adding a check, using an IF statement, to the trigger. The check

determines whether the discount_percent needs to be a part of the calculation, as shown in

Listing 13-11.

Listing 13-11. Trigger to Calculate the Total with a Discount Check

DELIMITER //

CREATE TRIGGER before_cust_order_insert BEFORE INSERT ON cust_order

FOR EACH ROW

BEGIN

IF NEW.discount_percent IS NULL OR NEW.discount_percent = 0 THEN

SET NEW.total = NEW.item_sum + NEW.shipping;

SET NEW.total = NEW.item_sum -

(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;

ELSE

END IF;

END

//

DELIMITER ;

Now, the trigger will only use the discount as a part of the calculation if the value is not

NULL and greater than zero.

■Note The trigger definition in Listing 13-11 shows the use of the IF . . . THEN . . . ELSE

flow control syntax that can be used in the trigger body. For more information about flow controls, see

Chapters 9 and 10.

Let’s take this example one step further and add a limit to the discount_percent. Perhaps

there’s been some abuse of this field, and the manager of the store places a maximum 15% dis-

count on any order. He asks if you can do some magic in the database to make sure the rule is

enforced. You already have the trigger in place to calculate the total, so adding a statement to

limit the value inserted into the discount_percent field is as simple as the three lines shown in

Listing 13-12.


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-12. Limiting the Discount Field to 15%

IF NEW.discount_percent > 15 THEN

SET NEW.discount_percent = 15;

END IF;

The IF statement in Listing 13-12 catches any instance where the incoming record has a

discount greater than 15%, and resets the value for the discount_percent to 15. The complete

trigger definition is shown in Listing 13-13.

Listing 13-13. Complete cust_order Insert Trigger

DELIMITER //

CREATE TRIGGER before_cust_order_insert BEFORE INSERT ON cust_order

FOR EACH ROW

BEGIN

IF NEW.discount_percent > 15 THEN

SET NEW.discount_percent = 15;

IF NEW.discount_percent IS NULL OR NEW.discount_percent = 0 THEN

SET NEW.total = NEW.item_sum + NEW.shipping;

SET NEW.total = NEW.item_sum -

(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;

END IF;

ELSE

END IF;

END

//

DELIMITER ;

Now, let’s see what happens when we try to insert a record into the cust_order table and

ask for a discount of 24%, as shown in Listing 13-14.

Listing 13-14. Inserting into the cust_order Table with an Invalid Discount

mysql> INSERT INTO cust_order SET ship_date='2005-08-12',

item_sum = 123.43,

discount_percent = 24,

shipping = 12.45;

Listing 13-15 shows that not only was the total calculated on the insertion, but also the

discount was limited to 15%, reduced from the value of 24% specified in the INSERT statement.


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-15. Output of cust_order Table After Insert

+---------------+------------+----------+------------------+----------+--------+

| cust_order_id | ship_date  | item_sum | discount_percent | shipping | total  |

+---------------+------------+----------+------------------+----------+--------+

|             1 | 2005-08-12 |   123.43 |               15 |    12.45 | 117.37 |

+---------------+------------+----------+------------------+----------+--------+

1 row in set (0.00 sec)

The trigger created in Listing 13-13 does a good job of performing the simple check and

calculation we want, but the user can invalidate the total field and exceed the discount by

updating the table. In order to ensure the same table behavior when the records are updated,

we need to create a similar trigger that activates on the UPDATE event, as shown in Listing 13-16.

Listing 13-16. Complete cust_order Update Trigger

DELIMITER //

CREATE TRIGGER before_cust_order_update BEFORE UPDATE ON cust_order

FOR EACH ROW

BEGIN

IF NEW.discount_percent > 15 THEN

SET NEW.discount_percent = 15;

IF NEW.discount_percent IS NULL OR NEW.discount_percent = 0 THEN

SET NEW.total = NEW.item_sum + NEW.shipping;

SET NEW.total = NEW.item_sum -

(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;

END IF;

ELSE

END IF;

END

//

DELIMITER  ;

Before leaving this example, let’s add one more restriction on the update, to demonstrate

the interaction between OLD and NEW rows of data. Suppose the manager now says that on any

update, the discount_percent should never increase by more than 2%. Adding this restriction

requires a check of the existing value and making sure that the new value isn’t any more than

two greater than the previous value. Comparing the OLD and NEW values, as shown in Listing 13-17,

makes it easy to create this restriction.


C H A P T E R   1 3   ■ T R I G G E R S

Listing 13-17. Limiting the Increase in discount_percent

IF OLD.discount_percent + 2 <= NEW.discount_percent THEN

SET NEW.discount_percent = OLD.discount_percent + 2;

END IF;

The entire update trigger, with the discount increase restrictions, discount limit restric-

tions, and the calculated columns, is shown in Listing 13-18. You’ll notice that before we can

create a new trigger, we need to remove the existing trigger.

Listing 13-18. Complete cust_order Update Trigger

DELIMITER //

DROP PROCEDURE cust_order.before_cust_order_update //

CREATE TRIGGER before_cust_order_update BEFORE UPDATE ON cust_order

FOR EACH ROW

BEGIN

IF OLD.discount_percent + 2 <= NEW.discount_percent THEN

SET NEW.discount_percent = OLD.discount_percent + 2;

IF NEW.discount_percent > 15 THEN

SET NEW.discount_percent = 15;

IF NEW.discount_percent IS NULL OR NEW.discount_percent = 0 THEN

SET NEW.total = NEW.item_sum + NEW.shipping;

SET NEW.total = NEW.item_sum -

(NEW.discount_percent/100 * NEW.item_sum) + NEW.shipping;

END IF;

END IF;

ELSE

END IF;

END

//

DELIMITER ;

Let’s test this on another record in our cust_order table, as shown in Listing 13-19.

Listing 13-19. Current cust_order Record

+---------------+------------+----------+------------------+----------+-------+

| cust_order_id | ship_date  | item_sum | discount_percent | shipping | total |

+---------------+------------+----------+------------------+----------+-------+

|             2 | 2005-08-27 | 40.56    |               10 | 10.34    | 46.84 |

+---------------+------------+----------+------------------+----------+-------+


C H A P T E R   1 3   ■ T R I G G E R S

This record has a discount of 10%. Let’s try to bump that up to 14%, using the statement

in Listing 13-20.

Listing 13-20. Update with discount_percent Increase Limit

mysql> UPDATE cust_order SET discount_percent = 14 WHERE cust_order_id = 2;

Without having a trigger to limit the increase of the discount to 2%, the discount should

increase to 14% with this update. With the trigger in place to limit the increase, the new

discount_percent for this cust_order record is 12, 2 greater than the previous value of 10.

The output from the table is shown in Listing 13-21.

Listing 13-21. Output from cust_order Table with a Limited Increase

+---------------+------------+----------+------------------+----------+-------+

| cust_order_id | ship_date  | item_sum | discount_percent | shipping | total |

+---------------+------------+----------+------------------+----------+-------+

|             2 | 2005-08-27 | 40.56    |               12 | 10.34    | 46.03 |

+---------------+------------+----------+------------------+----------+-------+

The example could continue, adding additional checks into the trigger until it accom-

plished every last bit of data integrity checking needed for the business logic, but we think

you probably get the general idea. Let’s move on to how to manage your database triggers.

Managing Triggers

After you’ve created a collection of triggers in the database, you’ll likely need to manage them.

As with stored procedures and functions, you can view, change, and remove stored functions.

Viewing Triggers

As we write this chapter, a recent commit to the MySQL source code indicates that there will

soon be a TRIGGERS view in the INFORMATION_SCHEMA. In order to view information about trig-

gers in your database, use the following statement:

SELECT * FROM INFORMATION_SCHEMA.TRIGGERS;

This statement will give you a set of records for the triggers in your database, including the fol-

lowing columns:

• TRIGGER_CATALOG

• TRIGGER_SCHEMA

• TRIGGER_NAME

• EVENT_MANIPULATION

• EVENT_OBJECT_CATALOG

• EVENT_OBJECT_SCHEMA


C H A P T E R   1 3   ■ T R I G G E R S

• EVENT_OBJECT_TABLE

• ACTION_ORDER

• ACTION_CONDITION

• ACTION_STATEMENT

• ACTION_ORIENTATION

• ACTION_TIMING

• ACTION_REFERENCE_OLD_TABLE

• ACTION_REFERENCE_NEW_TABLE

• ACTION_REFERENCE_OLD_ROW

• ACTION_REFERENCE_NEW_ROW

• CREATED

For more information about the INFORMATION_SCHEMA, see Chapter 21. Another option is to

look at the CREATE statement in the data directory:

<data directory>/<database name>/<table name>.TRG

As noted earlier, this is a somewhat unreadable representation of your CREATE statement, but it

will show you what is currently defined in the database.

■Note In MySQL, to get access to data dictionary information, you typically use the SHOW command. There

is currently no SHOW CREATE or SHOW STATUS for triggers, as there is for tables, views, stored procedures,

and so forth.

Modifying and Removing Triggers

If you need to modify one of your triggers, you must first issue a DROP statement, and then a

CREATE statement to redefine the trigger. The SQL:2003 standard does not provide for some-

thing like an ALTER TRIGGER or CREATE OR REPLACE TRIGGER statement to drop and create a

trigger in one statement.

The DROP TRIGGER statement is similar to the statement for dropping a table, database,

or view. In a DROP TRIGGER statement, the table name must be prepended to the name of the

trigger:

DROP TRIGGER <table name>.<trigger name>

For example, to drop the after_customer_update trigger we created for the customer table

in the shop database, first make the shop database active:

mysql> USE shop;


C H A P T E R   1 3   ■ T R I G G E R S

Once you are in the shop database, you can drop the trigger using the table and trigger name:

mysql> DROP TRIGGER customer.after_customer_update;

You may have noticed that we didn’t just prepend the database name in front of the table

name. Unlike other DROP commands, where you can prefix the database name to the table or

other item, you cannot drop a trigger unless the currently active database contains the table

associated with the trigger.

Trigger Permissions

Trigger permissions control access to creating and dropping triggers, as well as trigger activation.

To manage triggers, you’ll need the ability to create and drop triggers. Both of these com-

mands require the SUPER privilege for the database. See Chapter 15 for more information

about granting permissions to users.

To have a trigger activate, you need to have permission to run a SQL statement that matches

the event on the trigger. If you don’t have permission to INSERT into a table, you won’t be able to

make an INSERT trigger on that table activate. This is true for all of the trigger event types, includ-

ing INSERT, UPDATE, and DELETE.

When the trigger activates, if a statement in the body sets a variable equal to a field in the

NEW record, the calling user must have the ability to perform SELECT operations of the table.

This is because the user is attempting to pull a value from the record into a variable.

When attempting to set a field in the NEW record equal to a variable, the results of a calcu-

lation or function, or another field, the caller needs to have UPDATE permissions on the table.

If the user is setting a field, this changes the value of the field that will go into the table, which

requires the ability to update the table.

If you don’t have the appropriate permissions on the table when attempting to interact

with the trigger’s table, you will get an access denied error.

■Note The MySQL source code hints at future use of a trigger privilege. Look for a change in a future

release where you can differentiate between users with SUPER privileges and those who have permissions to

create and drop triggers.

Trigger Performance

For databases that need the functionality available through triggers, even significantly

degraded performance will be worth the trade-off for having event-triggered database-level

logic. Perhaps you are on the fine line, trying to decide if introducing triggers to your environ-

ment is worth the performance trade-off. In either case, it’s probably worth looking at what

kind of overhead is added to interacting with a table when a trigger is set to activate on a cer-

tain event.

For these tests, we took a series of SQL statements with randomly generated values and

ran sets of 10,000 and 50,000 statements into the database. We calculated the queries per sec-

ond for both the set of statements with no trigger defined and against the same table with


C H A P T E R   1 3   ■ T R I G G E R S

each statement passed through one of three triggers. Two of these triggers were used in exam-

ples shown earlier in this chapter, in Listings 13-13 and 13-18. The third was a simple DELETE

trigger, shown in Listing 13-22.

Listing 13-22. Delete Trigger for Performance Testing

DELIMITER //

CREATE TRIGGER after_cust_order_delete AFTER DELETE on cust_order

FOR EACH ROW

BEGIN

IF @insert_count IS NULL THEN

SET @insert_count = 0;

END IF;

SET @insert_count = @insert_count + 1;

END

//

DELIMITER ;

Our intention in testing was to determine how much overhead is involved in the inclusion

of the trigger in the statement processing. For this reason, we did not use triggers that inter-

acted with other tables, as that additional interaction would add overhead to the execution

time that is beyond the execution of the trigger.

The metrics were performed on MySQL 5.0.2 alpha, running on a single AMD64 2800+,

with 1GB of RAM and a 10,000 RPM SCSI data disk (separate from the boot disk). The database

is using the prebuilt binary for AMD64 downloaded from the MySQL web site, with all the

default options on startup (no my.cnf file used on startup). Table 13-1 shows the results.

Table 13-1. Performance Test for MySQL Triggers

SQL Statement

Queries/Sec

Without Trigger

Trigger

INSERT INTO cust_order

UPDATE cust_order

DELETE FROM cust_order

166.2

174.2

165.7

From Listing 13-13

From Listing 13-18

From Listing 13-22

Queries/Sec

with Trigger

165.8

184.8

165.8

As we ran the benchmark queries, and as you can see in the results, we found very little

difference between having a trigger handling the data and putting the data directly into the

table (and with the UPDATE and DELETE, having the trigger improves performance). There are a

few explanations for this:


C H A P T E R   1 3   ■ T R I G G E R S

• The triggers execute extremely quickly. In the case of one-statement triggers, this is

likely. In the instance where a trigger contains a significant amount of logic that must

be run for every record, it’s more likely that performance will drop.

• Because INSERT, UPDATE, and DELETE statements interact with data on the disk, we may

be seeing the I/O of the disks as the most significant piece of the performance here,

making the trigger processing time insignificant.

• The examples used in our performance tests were too simplistic to truly test the impact

that triggers have on the data going into a table. While this is possible, the second trig-

ger example is typical of the kind of processing that would be likely in a real-world

scenario.

We can’t suggest how significant these numbers are. You’ll need to decide if the additional

overhead is worth having trigger functionality in your database. As with all database function-

ality, you should spend time benchmarking your database. Before you roll out your trigger-

based implementation, take time to benchmark each trigger under real-world loads, and be

sure that you can accept whatever performance degradation your application will experience

as a result.

Summary

Triggers can provide a valuable set of functionality to complement referential integrity checks

in your data, and can provide additional functionality in adjusting and creating data as data

in the tables is changed. Before jumping into using triggers, it’s important to consider their

advantages and disadvantages, and make sensible decisions based on the needs of your data-

base and application.

MySQL has a great start on implementing the SQL:2003 standard for database triggers,

with a few key pieces missing. Triggers in MySQL are far enough along to allow database users

to start to experiment and develop with the functionality, and plan for the arrival of a stable

MySQL release with triggers.

A trigger definition requires a single CREATE statement with a few parameters and one or

more SQL statements to make up the body. The body can include declaration and flow control

statements to build decision-making mechanisms into the trigger.

Tools for managing triggers are limited. The CREATE and DROP statements are the only tools

provided for managing triggers in the database. Triggers are viewed using the INFORMATION_

SCHEMA in MySQL. Check MySQL's trigger documentation for up-to-the-minute information

about the release of more administrative tools.

Triggers offer an exciting and powerful mechanism to interact with data at the database

level. With the ability to run a series of SQL statements whenever data is changed in the data-

base, you gain much more control over what is happening as data changes stream into your

database.


P A R T   2

■ ■ ■

Administration


C H A P T E R   1 4

■ ■ ■

MySQL Installation

and Configuration

Installing and configuring MySQL can take anywhere from five minutes to five hours, or even

span multiple days, depending on your requirements. One of the long-time goals of MySQL

AB has been to keep the installation of MySQL quick and simple. By providing an easy installa-

tion process with preconfigured options, MySQL makes it possible to have a database running

with almost no effort. However, while the easy installation and default configuration work for

many, when deploying MySQL in an esoteric or somewhat more complicated environment,

you might want to take advantage of the numerous options it offers for building, installing,

configuring, and tuning MySQL to fit your needs. Depending on your specific architecture and

database requirements, you may spend a significant amount of time setting up the database

before it is ready for use.

The MySQL web site provides a wide range of precompiled binaries for numerous plat-

forms. You are encouraged to use these precompiled binaries, and benefit from the MySQL AB

team’s years of experience and wealth of knowledge about various platforms. The precompiled

binaries are well documented in the notes on the download page, and they often are faster

than a self-compiled binary. In some cases, MySQL AB uses commercial compilers for speed

improvements. However, in some situations, the existing binaries won’t meet your needs, and

you’ll want to build from the source package or even directly from the top of the source tree.

After you’ve installed MySQL, you may need to perform some other setup tasks, such as

having MySQL start up when you start your operating system. You might also need to set some

of MySQL’s myriad configuration options. And since MySQL is under constant development, it

is likely that, at some time, you will want to upgrade to the latest version.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

This chapter covers MySQL installation, configuration, upgrading, and related issues.

Specifically, we’ll discuss the following topics:

• Existing MySQL installations

• Prebuilt binary installation

• Source and development source tree builds

• MySQL startup and shutdown

• Post-installation steps

• MySQL configuration options

• Upgrading techniques

• MySQL uninstallation

• Multiple database servers on a single machine

Using an Existing Installation

The simplest way to get up and running with MySQL is to use a version of the database

included in your operating system installation. Many Linux distributions include a package

for MySQL that is installed with the operating system. If the preinstalled version meets your

needs, it may be ready to use.

However, often, a preinstalled version of MySQL lags behind the current release, because

new MySQL versions are released on a frequent basis. If, for reasons of functionality or per-

formance, you need a more recent version of MySQL, you’ll want to upgrade—if not now, then

at some point. In most cases, this will require uninstalling the package and upgrading to a

package or tarball from the MySQL web site.

Additionally, you may find that support is more readily available for the standard, MySQL-

defined installation. In some operating systems, the preinstalled MySQL’s organization is different

from the standard MySQL installation’s organization. MySQL AB and the community may not

provide assistance if your installation varies from the standard organization.

If you choose to use an existing installation, take the time to review the “Performing Post-

Installation Setup,” “Configuring MySQL,” and “Upgrading MySQL” sections in this chapter.

Installing Prebuilt Binaries

With the exception of having MySQL preinstalled with the operating system, using prebuilt

binaries from the MySQL web site is the quickest, and recommended, method for installation.

These binaries are carefully compiled, and they are based on years of experience in creating

the most stable and highest performing build. For certain architectures, MySQL uses commer-

cial compilers, which net as much as 20% performance boost over the open-source alternative.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Beyond choosing the right build for your architecture and operating system, you must

choose from a few build types. In some cases, you’ll also have a choice of installation mecha-

nisms: the command-line installed tarball or a package with an installer.

Here, we’ll describe how to use the MySQL binaries to install MySQL on Unix, Windows,

and Mac OS X systems.

MYSQL DIRECTORY STRUCTURE

MySQL installs more than a thousand files and directories on your system. The location of these files differs

depending on the installation mechanism you choose. The tarball root directory structure contains the following:

• bin: This directory contains the mysqld server program and all client programs and tools you will run

to use and administer MySQL.

the server.

ing other programs.

files and accounts.

• data: The data files, where MySQL reads and writes its data, are stored here, along with log files for

• docs: The documentation directory contains an HTML and text file with version-specific documentation.

• include: The binary tarball includes a set of header files, which may be used when writing or compil-

• lib: The lib directory contains MySQL library files.

• scripts: This directory contains the mysql_install_db script, which is used to install initial data

• share: The share directory contains SQL scripts for fixing privileges, as well as a set of language files

for using MySQL in a variety of languages.

• sql-bench: MySQL includes a set of benchmarking tools (discussed in Chapter 6).

• support-files: The MySQL installation includes a directory with several confiiguration file examples

and other support scripts.

If you aren’t using the Unix tarball, see the MySQL document at http://dev.mysql.com/doc/mysql/

en/Installation_layouts.html for information about file layouts for different operating systems.

Supported Operating Systems

MySQL AB provides prebuilt binaries for a wide range of operating systems, along with docu-

mentation on the build process for each binary. (See http://dev.mysql.com/doc/mysql/en/

MySQL_binaries.html for more details on the MySQL binaries.) You’ll find downloadable bina-

ries for Linux (for x86, S/390, IA64, Alpha, Sparc, PowerPC, AMD64, and EMT64 processors),

Solaris, FreeBSD, Windows, Mac OS X, HP-UX, IBM-AIX, QNX, Novell NetWare, SCI Irix, and

Dec OSF. Binaries are available for two or more recent operating system versions, except for

QNX, Novell NetWare, and OSF, which have a single download available.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

All platforms are not considered equal for running a MySQL server. MySQL AB is clear

that it doesn’t want to suggest, in general, that a specific operating system is better than

another, but certain platforms better meet an outlined set of requirements for running the

database server. When evaluating a platform, MySQL AB works through a list of criteria to

determine how well suited the platform is for running MySQL:

• How good are the threading libraries on the operating system? MySQL is threaded and

relies on the operating system for its threading libraries. The database server will be

reliable only if the threading on a platform is stable.

• Will the operating system use multiple CPUs? The database gets a great deal of per-

formance if threads, which are handling connections and queries, can run on more

than one processor.

• How stable and robust is the file system? MySQL relies heavily on reading and writing

data to the file system. The stability and performance of the file system will have a big

effect on the performance of the database. Also important to consider is how well the

file system handles large files.

• How much is the operating system used and how well is it understood? When consider-

ing recommendations for an operating system, MySQL AB assesses how many users

have had success running MySQL on a platform, how much MySQL-related expertise is

available for that operating system, and the amount of MySQL history and testing that

has been done.

The answers to all of these questions culminate in a few recommendations from MySQL

AB. Currently, MySQL recommends Linux on x86, Solaris on SPARC, and FreeBSD as the plat-

forms that best meet the criteria for a MySQL database server.

MySQL Build Types

For most platforms, MySQL is available in three different build types, each with a different set

of features:

• Standard: Includes MySQL server with MyISAM and InnoDB storage engines, client

tools, benchmarking suite, and MySQL libraries.

• Max: Includes the features in the standard build, plus the NDB Cluster and Berkeley DB

(BDB) storage engines (where supported), user-defined functions, and other features

not in the standard binaries. More details on the max binaries are available from http://

dev.mysql.com/doc/mysql/en/mysqld-max.html.

• Debug: Binaries compiled with debugging support, with reduced performance (not

recommended for production use).

On Windows, you can choose between a zip file for manual installation or two types of

installers. Unlike with the Unix tarballs, where you choose a build type, Windows downloads

contain all of the binary types. When you install manually or with a GUI installer, the standard,

max, and debug binaries are all installed along with two additional binaries, standard-nt and

max-nt, which are optimized for Windows NT, 2000, and XP and have support for Named

Pipes.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Manual Installation

For Unix, the manually installed tarball format is the most widely used and recommended

method for installing your database. A manual installation process is also available for

Windows, but it is not as easy or thorough as the Windows installer option.

Manually Installing Tarball on Unix

Tarred binaries unpack into a single directory, named by its build type (standard, max, or

debug), version, and platform (for example, mysql-max-5.0.6-pc-linux-i686). All binaries,

configuration files, data, libraries, and documentation are in this directory.

MySQL documentation recommends putting the untarred directory into /usr/local and

symbolically linking it to /usr/local/mysql. The tarred binaries include a range of configura-

tion files to match a range of database needs, as well as an init.d-style startup script for

starting, stopping, restarting, and checking the status of a running MySQL server. Tarballs

are available for all listed platforms.

Installing the tarball for a prebuilt binary takes relatively few steps, which include creating

a mysql group and user, untarring the file, installing the data files, changing the permissions

for the files and directories, and starting the database. Here is the procedure (all commands

run using the root user):

1. Create the mysql group, which is used with the mysql user for controlling permissions

of the files installed with MySQL, as well as the data files and logs.

2. Create the mysql user, whose primary group is the mysql group. The mysql user is used

for both file permissions and running the mysql server as a non-root user.

3. Move to the recommended location for installing the MySQL files.

# groupadd mysql

# useradd -g mysql mysql

# cd /usr/local

4. Untar the MySQL tarball.

# tar -xzvf /path/to/mysql-VERSION-OS.tar.gz

5. Create a symbolic link, for ease in accessing the database.

# ln -s /full/path/to/mysql-VERSION-OS mysql

6. Move into the install directory.

# cd mysql

7. Run the script to install the initial database files used for MySQL accounts and testing.

Specify to install the files as the mysql user.

# scripts/mysql_install_db --user=mysql

8. Change user ownership of all installed files and directories to root.

# chown -R root .


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

9. Change user ownership of the data directory to mysql.

# chown -R mysql data

# chgrp -R mysql .

the mysql user.

10. Change group ownership of all installed files and directories to mysql.

11. Start the database using mysqld_safe, specifying that the database should be run by

# bin/mysqld_safe --user=mysql &

At this point, you should have a running instance of MySQL.

■Note On Unix, the recommended method for starting a MySQL server is bin/mysqld_safe, not

bin/mysqld. mysqld_safe provides security to the database server if an error occurs, by restarting the

server and logging runtime information to your error log.

Manually Installing the Windows Binary

Using the Windows installer option, as described in the next section, is the recommended way

to install MySQL on Windows platforms. However, if you need to manually install MySQL on

Windows for some reason, you can do so. Download the noinstall.zip file, and then follow

these steps:

1. Unzip the Windows zip file.

C:\> C:\path\to\unzip.exe mysql-VERSION-win-noinstall.zip

2. Rename the Windows zip file to mysql.

C:\> rename mysql-VERSION-win mysql

3. Create a configuration file and start a mysqld group. (MySQL groups are covered in the

“Configuration Groups” section later in this chapter.)

C:\> echo [mysqld] > my.ini

4. Add the basedir option to your configuration file. (Configuration file options are cov-

ered in the “Configuring MySQL” section later in this chapter.)

C:\> echo basedir=C:\mysql >> my.ini

5. Add the data directory option to your configuration file.

C:\> echo datadir=C:\mysql\data >> my.ini

6. Start the MySQL server.

C:\> C:\mysql\bin\mysqld

You will now have a running instance of MySQL on your Windows system.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Windows Installer

The easiest and most thorough option for installing MySQL on Windows is to use the Windows

Essentials download. The Essentials download comes with a Microsoft Windows installer file

that installs server binaries, command-line utilities, and libraries.

After downloading Windows Essentials, run the installer to install the necessary files using

the MySQL Installation Wizard. If you leave the Configure option checked, after you click Fin-

ish, the MySQL Configuration Wizard starts automatically. The wizard prompts you with a

series of screens to determine how the database server will be used. At the end of the wizard,

it creates a configuration file based on your preferences. The MySQL Configuration Wizard can

also be run separately to modify an existing installation.

The MySQL Configuration Wizard steps you through the following screens:

• Machine Type: Choose developer, server, or dedicated server. This choice dynamically

sets temporary table and buffer pool sizes based on your machine’s memory.

• Storage Type: Choose whether your database will be multifunctional, transactional,

or nontransactional. Your storage type choice sets the default storage engine and

determines which engines to enable. If you need a combination of transactional and

nontransactional tables, choose multifunctional. If you choose nontransactional, the

default storage engine will be set to MyISAM, which is faster but does not include sup-

port for transactions. (See Chapter 5 for details on the MySQL storage engines.)

• Tablespace Settings: Specify the path to the folder that will contain the data files for the

database.

• Connection Load: Choose how many connections MySQL will allow. Your choice sets

the max_connections parameter in the configuration file.

• TCP Networking: Choose to enable MySQL network availability and specify a port, or

disable networking altogether.

• Default Character Set: Choose a default character set. This sets the default-character-

set option in the configuration file, which tells MySQL what set of characters to use.

• Windows Options: Indicate whether you would like a Windows service installed, includ-

ing choosing the name of the service. Also specify if you would like MySQL programs

added to your Windows PATH variable.

• Security: Secure the database by setting the root password and removing the anony-

mous account, which does not have a password.

When the wizard completes, the configuration file is created. The database will start if you

selected to run it.

RPMs

RPM package files for standard, max, and debug builds are available in generic form for x86

Linux, as well as in specific builds for the Red Hat and SUSE Linux distributions. What makes

a complete tarball is broken into several RPMs, allowing you to install the server, client, libraries,

and so on separately. As it should, the RPM spreads the installed files across various directories

(/usr/bin, /usr/libexec/, /usr/share/man, /var/lib, /etc, and others). The server package


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

creates the required mysql group and user, installs the application, creates the data files, and

starts the database. Table 14-1 provides a brief description of the RPM packages.

Table 14-1. RPM Packages

Description

Name

server

bench

client

devel

shared

Installs the server binaries, configuration, and data files

Installs all the benchmarking tools and test suites (see Chapter 6)

Installs the client RPM, for client and tool programs (mysqladmin, mysqldump,

and so on)

Includes header files and libraries needed if you are compiling other

programs to use MySQL

Includes dynamic client libraries that can be used by other applications that

want to interact with a MySQL server

embedded

shared-compat

Installs a server that can be included in other applications

Includes dynamic client libraries available in the shared package, as well as

the older, 3.23.x libraries for compatibility

Mac OS X Packages

Tarballs are available for Macintosh systems running OS X 10.2 and above, and they can be

installed using the manual install instructions for Unix. If you don’t want to go through the

manual installation, download the Mac installer for a GUI-based installation.

The Mac installer is downloaded as a disk image, which, when mounted, contains a data-

base install package and a startup install package. The database installer expects an existing

mysql user, which is already set up by default in OS X version 10.2 and greater, even if MySQL

has never been installed on your OS X machine. The database installer uses the same directory

structure as the tarball, but it is smart about not deleting existing installations, moving any

existing mysql directory to mysql.old. Use the MySQLStartupItem.pkg to create an entry in the

OS X operating system startup programs.

Once you’ve completed the OS X installer process, either using the manual Unix instruc-

tions or the OS X GUI installer, you can start the database using the following commands:

# cd /usr/local/mysql

# ./bin/mysqld_safe &

command:

# /Library/StartupItems/MySQLCOM/MySQLCOM start

If you’ve installed the MySQLStartupItem package, you can use the following startup script


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Building from Source or

the Development Source Tree

We start this section with a reminder that MySQL strongly encourages you to use the prebuilt

binaries. MySQL AB developers expend significant effort into their build process, and in many

cases, this provides the fastest and most stable build. In instances where you need support for

a problem, using the prebuilt binaries will reduce the resistance to assistance. With that said,

we realize that, in some cases, the binaries may not fit your needs. You may be considering

building from source for the following reasons:

• MySQL isn’t available for your architecture or operating system.

• You prefer to install MySQL in a different location than the one provided by the binary.

• You want extra features that are not included in a binary for your system.

• You don’t need certain features built into the binary for your system.

• You want to use different compiler options, or a different compiler altogether.

• Before MySQL is built, you need to change some of the source code. Perhaps you need

to apply a patch from MySQL AB or have customized functions to compile with the

source.

• You want the additional tests and examples, which are in the source, but left out of the

prebuilt binaries.

• You rest better when you know the exact details of how your MySQL binary was built.

If any of those reasons ring true for you, then download the tarball from mysql.com and

get started.

■Note If you need to build from source on Windows (a rare requirement), see the MySQL documentation’s

instructions for using VC++ to build the source, available from http://dev.mysql.com/doc/mysql/en/

Windows_source_build.html.

Manually Installing the Source Tarball on Unix

Building MySQL from source is fairly straightforward on Unix-like platforms, especially if

you’ve compiled other software. Installation of the source tarball on a Unix system is similar to

installing the binary tarball, with a few extra steps to configure and compile the MySQL bina-

ries. Here are the steps:

1. Create the mysql group, which is used with the mysql user for controlling permissions

of the files installed with MySQL, as well as the data files and logs.

# groupadd mysql


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

2. Create the mysql user, whose primary group is the mysql group. The mysql user is used

for both file permissions and running the MySQL server as a non-root user.

# useradd -g mysql mysql

3. Untar the source tarball.

# tar -xzvf mysql-VERSION.tar.gz

4. Move into the directory created when untarring.

# cd mysql-VERSION

5. Run the configure script, specifying options for building MySQL (see Table 14-2).

#./configure --prefix=/usr/local/mysql-VERSION (other options)

■Note When running configure to build MySQL, unless you are building as part of a packaging tool, we

highly recommend installing everything into /usr/local/mysql. Using /usr or /usr/local as a prefix will

spread files throughout several directories. Unless you have a packaging tool to help keep track of the files,

having everything installed into one directory will simplify future upgrades.

6. Compile the software.

# make

7. Test the compiled software.

# make test

8. Install the software.

# make install

If things go well, you’ll watch the build process take its time dumping status messages

onto the screen, and then end up back at your shell prompt, with an OK or success

message. At that point, you can continue with the following steps.

■Note As you run configure, make, and make test, you may run into complications—perhaps

configure will complain about missing files or make will dump a dozen screens of errors. In many cases,

the problem is misused configure options, missing libraries, incomplete paths, or incompatible options.

Look at the first lines that indicate trouble and see if you can find keywords that indicate what the compile

or make is working on at the point of failure. Verify that your options for that functionality are correct. For

help, you can use a search engine to find the error string, or scan the configure script and makefile to

see if you can gather clues on the point where the compile is failing and what’s causing problems.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

9. Move to the recommended location where you installed the MySQL files.

10. Create a symbolic link, for ease in accessing the MySQL server directory.

# cd /usr/local

# ln -s mysql-VERSION mysql

11. Move into the install directory.

# cd mysql

# scripts/mysql_install_db

12. Run the script to install the initial database files used for MySQL accounts and testing.

13. Change user ownership of all installed files and directories to root.

14. Change user ownership of the data directory to mysql.

15. Change group ownership of all installed files and directories to mysql.

# chown -R root .

# chown -R mysql data

# chgrp -R mysql .

the mysql user.

16. Start the database using mysqld_safe, specifying that the database should be run by

# bin/mysqld_safe --user=mysql &

Your main reason for tackling the source build may be to set specific configuration

options. Table 14-2 lists commonly used configuration options. For a full list, check the

MySQL documentation or run ./configure --help in your source directory.

Table 14-2. Common MySQL Configuration Options

Option

Description

--disable-largefile

--enable-local-infile

--enable-thread-safe-client

--prefix=<dir>

--with-archive-storage-engine

--with-berkeley-db=<dir>

--with-berkeley-db-includes=<dir>

--with-berkeley-db-libs=<dir>

--with-charset=<name>

Do not include large file support.

Enable LOAD DATA LOCAL INFILE. This is disabled by default.

When compiling the client, enable threads.

Install files at this location. The default is /usr/local.

Enable the ARCHIVE storage engine.

Use this directory for the BDB storage engine.

Use this directory for the BDB headers.

Use this directory for BDB libraries.

Specify the default character set. The choices are binary,

armscii8, ascii, big5, cp1250, cp1251, cp1256, cp1257,

cp850, cp852, cp866, dec8, euckr, gb2312, gbk, geostd8,

greek, hebrew, hp8, keybcs2, koi8r, koi8u, latin1,

latin2, latin5, latin7, macce, macroman, sjis, swe7,

tis620, ucs2, ujis, and utf8.

Continued


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Table 14-2. Continued

Option

Description

--with-client-ldflags

--with-comment

--with-csv-storage-engine

--with-example-storage-engine

--with-lib-ccflags

--with-libwrap=<dir>

--with-low-memory

--with-mysqld-ldflags

--with-mysqld-user=<username>

--with-mysqlfs

--with-ndb-docs

--with-ndb-port-base

--with-ndb-sci=<dir>

--with-ndb-shm

--with-ndb-test

--with-ndbcluster

--with-openssl=<dir>

--with-openssl-includes=<dir>

--with-openssl-libs=<dir>

--with-pstack

--with-pthread

--with-raid

--with-tcp-port=<number>

--with-unix-socket-path=<file>

--with-vio

--with-zlib-dir=<dir>

--without-bench

--without-debug

--without-docs

--without-innodb

--without-libedit

--without-man

--without-query-cache

--without-readline

Additional arguments for linking clients.

Add a comment about the compilation process.

Enable the CSV storage engine.

Enable the example storage engine.

Additional CC library options.

Compile in support for TCP wrappers.

Try to use less memory to compile to get around memory

limitations.

Additional ld linking arguments for mysqld.

Use this username to run the mysqld daemon.

Include the MySQL file system (CORBA-based).

Include documentation for the NDB Cluster.

Use this port for the NDB Cluster.

Give MySQL a location for the sci library. The libraries

should be in <dir>/lib and header files in <dir>/include.

Include the shared memory transporter for the NDB Cluster.

Include test programs for the NDB Cluster.

Enable the NDB Cluster storage engine.

Include support for OpenSSL.

Look in <dir> for OpenSSL.

Look for OpenSSL libraries in <dir>.

Enable the pstack backtrace library.

Use the pthread library.

Enable support for RAID.

Specify the port to use for MySQL services. The default is 3306.

Specify the file for MySQL to use for creating and using the

Unix socket.

Include support for virtual I/O.

Give MySQL a location for the compression library. The

libraries should be in <dir>/lib and header files in

<dir>/include.

Skip building the MySQL benchmark suite.

Build a production version without debugging code.

Do not include MySQL documentation.

Exclude the InnoDB storage engine.

Use system’s libedit, instead of the copy bundled with MySQL.

Do not include man pages when building.

Skip building the query cache.

Use the system’s readline, instead of the copy bundled

with MySQL.

--without-server

Do not build the server. Build only the client.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

FINDING LIBRARIES WITH LDPATH

While building MySQL, you may link to libraries that are dynamically loaded. Perhaps you want to include the

ability for SSL encryption on database connections, which will require links to the OpenSSL libraries on your

server. To ensure these libraries can be found at build and runtime, you may need to give the compiler some

help. Many folks set LD_LIBRARY_PATH to contain a list of paths, which the compiler and binaries use when

looking for needed libraries. This can cause problems if binaries are started outside your environment where

the paths aren’t included.

To better assist the compiler in finding libraries to link against at compile time, and help the binary find

these libraries at runtime, use LDFLAGS. LDFLAGS are passed to the linker, and can tell the linker to use cer-

tain paths when looking for libraries at compile time as well as runtime. Setting LDFLAGS to -L/some/path

tells the linker to look in that path during compile time. Adding -R/some/path will append that path to a list

of directories considered at runtime.

Installing from the Development Source Tree on Unix

You may consider setting up a build that uses the latest source from the MySQL AB develop-

ment source tree because building from a specific version of the source doesn’t provide what

you need. Or perhaps you want to play with some of the latest functionality in MySQL, but a

release with that functionality isn’t available. Or you may have submitted a bug that has been

committed for release in the next version, but you need that fix sooner than the next release.

These are all valid reasons for working with the very latest builds. Thankfully, the process is

well documented and not much more work than building from a source tarball.

MySQL AB uses BitKeeper, a configuration management system, for its code repository.

BitKeeper allows multiple users to keep their own repository with revision history and provides

tools for moving changes between repositories. You may not be interested in modifying the

source code, but you will need to get a copy of the source via the BitKeeper tools in order to build

from the development source tree. BitKeeper is a free download from http://www.bitkeeper.com

(you will need to register first). Once you have the client, grabbing a clone of the source code

requires one simple command.

To build from the development tree, you’ll need up-to-date versions of GNU make,

autoconf, automake, libtool, and m4. On some Unix machines, these tools are installed by

default, or the operating system has a developer tools package that includes them. If you

can’t find a package, you can always get these tools from http://www.gnu.org.

Installation from the source tree on a Unix system is similar to installing from the source

tarball, with a few extra steps to get and set up the source code. Here are the steps:

1. Create the mysql group, which is used with the mysql user for controlling permissions

of the files installed with MySQL, as well as the data files and logs.

2. Create the mysql user whose primary group is the mysql group. The mysql user is used

for both file permissions and running the MySQL server as a non-root user.

# groupadd mysql

# useradd -g mysql mysql


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

3. Get the source tree from the MySQL BitKeeper site. BRANCH is one of 4.1, 5.0, 5.1, and so on.

# bk clone bk://mysql.bkbits.net/mysql-BRANCH mysql-BRANCH

4. Move into the source directory.

# cd mysql-BRANCH

5. Tell BitKeeper you are going to work with the files.

# bk -r edit

6. Run commands to generate the configure script and makefiles.

# aclocal; autoheader; autoconf; automake

7. Run commands to generate the configure script and makefile for the InnoDB storage

engine, if you want to use this storage engine.

# (cd innobase; aclocal; autoheader; autoconf; automake)

8. Run the configure script, specifying options for building MySQL (configuration options

are summarized in Table 14-2).

#./configure --prefix=/usr/local/mysql (other options)

9. Compile the software.

# make

10. Test the compiled software.

# make test

11. Install the software.

# make install

# cd /usr/local/mysql

# bin/mysql_install_db

# chown -R root .

# chown -R mysql var

# chgrp -R mysql .

12. Move to the recommended location where you installed the MySQL files.

13. Run the script to install the initial database files used for MySQL accounts and testing.

14. Change user ownership of all installed files and directories to root.

15. Change user ownership of the data directory to mysql.

16. Change group ownership of all installed files and directories to mysql.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

17. Move a configuration file to /etc for use in starting the database.

# mv support-files/my-medium.cnf /etc/my.cnf

18. Start the database using mysqld_safe, specifying that the database should be run by

the mysql user.

# bin/mysqld_safe --user=mysql &

Starting and Stopping MySQL

Although each of the sections on installing MySQL included a step to start the database, we

want to call particular attention to the recommended method for starting your database

server. Also, inevitably there will be a point where you need to stop the database server.

■Tip If you don’t find an example that matches your server, you can use the mysqladmin tool to stop the

database: mysqladmin -u root -p shutdown.

Unix Startup and Shutdown

On Unix, the server program is contained in mysqld, but the recommended script for running

the database is mysqld_safe, which runs a process to monitor the database and keep it run-

ning. Using mysqld_safe also logs extra pre-startup steps, which may help in troubleshooting

problems with the mysqld binary.

On many Unix flavors, an rc script named mysql or mysql.server will be installed in /etc/

init.d, /etc/init.d/rc.d, or /usr/local/etc/rc.d, which can be given the start argument to

start the database. These scripts wrap around the mysqld_safe script. If it’s available, using an

rc script is recommended over running mysqld_safe manually. This script can also be given

the stop argument to shut down the database:

/etc/init.d/mysql stop

Windows Startup and Shutdown

If you are running MySQL on Windows, you should probably set up a service, as described in

the “Performing Post-Installation Setup” section of this chapter. The service allows you to use

the Services tool in the Control Panel to start the database, or run NET START MySQL at the C:\>

prompt. If you don’t have a service installed for MySQL, use C:\mysql\bin\mysqld.

If you have a service running, you can stop it through the Services tool in the Control

Panel, or use NET STOP MySQL at the C:\> prompt. If you don’t have the service installed, use

the following command to shut down the database:

C:\mysql\bin\mysqladmin -u root shutdown


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Mac OS X Startup and Shutdown

If you’ve installed the MySQLStartupItem package, you can use the shell script for automatic

startup:

# /Library/StartupItems/MySQLCOM/MySQLCOM start

Otherwise, you can use the Unix command for starting with mysqld_safe.

If you’ve installed the MySQLStartupItem package, you can use the shell script for shutting

down MySQL:

# /Library/StartupItems/MySQLCOM/MySQLCOM stop

Performing Post-Installation Setup

Depending on your installation mechanism, the following are some additional steps you may

need to perform after you’ve installed MySQL:

Add MySQL to operating system startup: If your installation mechanism didn’t create a

service or an entry in the appropriate place to have the MySQL server start automatically

when the server boots up, you may want to add it now, so the server will always be run-

ning, even if the machine is rebooted. Table 14-3 summarizes instructions for several

operating systems.

Secure the database: Secure the database using various techniques, as outlined in Chapter

16. Securing your database includes important steps like removing networking if it’s not

needed, setting the root password, and removing the no-password anonymous account.

Create accounts: You’ll need to create accounts for yourself and others to use the database.

Set up your account first, with all permissions necessary to create other accounts so you

can avoid using the root user, which is considered bad security practice. Then, for each

user who needs access to the database, create a login and a set of appropriate permissions

to control that account’s access to the data. Chapter 15 covers setting up user accounts.

Review prebuilt configuration files: Based on your intended use of MySQL, if you aren’t

planning on spending time digging into configuration details, you may want to take a

few minutes to consider using one of the prebuilt configuration files provided with the

installation. In the support-files folder of your installation are four configuration files:

my-small.cnf, my-medium.cnf, my-large.cnf, and my-huge.cnf. Depending on the size of

memory on the machine, and what other processes you plan on running on the server,

you may be able to realize some benefits by trying different prebuilt configuration files.

Move data directory: To ease in upgrading, you might consider putting your data in a

directory other than the installed MySQL directory. If you put your data files into another

directory, perhaps even on a separate disk, you ease the upgrade process because you

won’t need to move data files into the mysql install folder after a new version is installed.

You also get performance improvements by putting your data files on a disk separate from

the operating system. Use the --datadir option in your configuration file to specify the

location of your data files.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Put tools in your path: To ease use of the MySQL tools, you may want to make sure the

binaries are in your path, and perhaps in all server users’ paths. This isn’t important if

you’ve installed using an RPM where the binaries are installed in /usr/bin, which is in the

PATH environment variable by default. However, if you’ve installed into /usr/local/mysql,

adding /usr/local/mysql/bin to the PATH environment variable of users allows them to

use the tools without needing to type the full path /usr/local/mysql/bin/mysql to start

their client.

Table 14-3. Adding MySQL to Operating System Startup

Operating System

Instructions

Linux

Depending on the distribution, adding MySQL to the startup can differ. The

Red Hat or Fedora distributions use chkconfig, which allows you to move

support-files/mysql.server to /etc/init.d/mysql and run chkconfig ➥

--add mysql. Gentoo Linux uses rc-update; with support-files/mysql.server

moved to /etc/init.d/mysql, you run rc-update add mysql default. See the

documentation for your Linux distribution for specific details.

Add mysql_enable="YES" to /etc/rc.conf.

Copy support-files/mysql.server to /etc/init.d/mysql and create symbolic

links from /etc/rc1.d/K99mysql and /etc/rc2.d/S99mysql.

Create a Windows service with C:\mysql\bin\mysqld --install.

Install the MySQLStartupItem package.

FreeBSD

Solaris

Windows

Macintosh

Configuring MySQL

In many cases, the default configuration provided by the installer or included in the

support-files folder will meet your needs. Even so, you’ll want to know how MySQL uses

the configuration files, along with the options on the command line, and be aware of the

available settings. Then, if the defaults for MySQL do not perform as you expected, you’ll

be able to change the configuration.

■Note This section gives an overview of how configuration works and what options are available. Chapter 6

digs deeper into profiling your database. Use the techniques outlined in Chapter 6 when tweaking these

configuration options to determine how configuration changes affect performance.

Location of Configuration Files

MySQL uses text-based configuration files (commonly referred to as option files). By allowing

you to use multiple levels of configuration files, cascading to create a complete set of options,

MySQL offers a powerful mechanism to customize the interaction with the server and tools.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Unix Configuration Files

On Unix systems, MySQL first looks in /etc/my.cnf and loads global options, applied to all

servers and users. MySQL then loads options from a my.cnf file in MYSQL_HOME, an environment

variable that points to a directory. If MYSQL_HOME isn't set, the database first looks in the data

directory and then in the base directory for a configuration file. For a binary installation, the

data directory is typically /usr/local/mysql/data. For a source installation, the data

directory is /usr/local/var. Some packages, like RPM, are configured to store the data in

/var/lib/mysql.

After looking in the data directory, MySQL will check for the command-line --defaults-

extra-file=/some/path/my.cnf, and load those options. The last configuration MySQL loads

is your user-specific, ~/.my.cnf file, which resides in your home directory. After processing all

configuration files, MySQL processes the options given on the command line.

On Windows, MySQL first looks for my.ini in your WINDIR, and then for C:\my.cnf. To determine

the value of WINDIR, use the following command:

Windows Configuration Files

C:\> echo %WINDIR%

Configuration Groups

As if having multiple configuration file levels didn’t provide enough flexibility, the configura-

tion files for MySQL can be further delineated by using groups, which let you set configuration

options for specific tools, and even specific versions of the mysqld server. This means you can

have one buffer size for mysqldump and another one for your mysql client, or one username/

password for the program mysqladmin and another for mysqlshow.

The configuration file should start with options for all commands, before a group is specified.

After options are set for all servers and tools, a group declaration starts the move into more spe-

cific options. A group section is specified by using brackets ([group]). All options after the group

declaration will apply to servers or tools that fall into that group. A group section ends when a

new group starts or the end of the file is reached. Table 14-4 lists the common configuration groups.

Table 14-4. Common Configuration Groups

Applies to

Group

server

mysqld

client

mysql

myisamchk

myisampack

mysqladmin

The mysqld server program and mysqld_safe and mysql.server startup scripts

The mysqld server program, regardless of startup mechanism

mysqld_safe

safe_mysqld

Database process started with the mysqld_safe script

Database process started using the mysqld_safe script

mysql.server

mysql.server startup script only

mysqld-4.0

mysqld for version 4.0; use mysqld-MAJOR.MINOR for other server versions

Any client program, not mysqld

MySQL client only

myisamchk tool, which checks and repairs MyISAM tables

myisampack tool, which packs MyISAM tables into smaller, read-only format

mysqladmin tool, which is used for database administration commands


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Group

Applies to

mysqlbinlog

mysqlbinlog tool, which converts binary logs to text

mysqlcheck tool, which checks the health of tables

mysqldump tool, which creates SQL statements for rebuilding databases or tables

mysqlhotcopy

mysqlhotcopy tool, which copies data files

mysqlimport

mysqlimport, a command-line interface to LOAD DATA INFILE

mysqlshow tool, which is used for showing information about databases, tables,

columns, and so on

mysql_multi tool, which is used for managing multiple running databases on one

machine

mysql_multi with server 1 group number specified; use mysqld<group number> to

create mysql_multi groups with options for each server

mysqlcheck

mysqldump

mysqlshow

mysql_multi

mysqld1

With the wide array of configuration groups and unending list of configuration options

(covered in the next section), a configuration file can become quite complex. Listing 14-1

provides a simple configuration file with common groups and options.

Listing 14-1. Sample my.cnf File with Groups

[client]

username=michael

password=my_secret

port=3306

socket=/tmp/mysql.sock

[mysql]

prompt=mysql-prod>

[mysqld]

socket=/tmp/mysql.sock

key_buffer_size=8M

max_allowed_packet=4M

port=3306

Configuration Options

The meat of configuring MySQL is in the options—several hundred of them. The values are

typically Boolean (no value needed; if the option is present, it will be used), strings, or integers.

Options can be specified on the command line when starting the server or running a tool. How-

ever, in most instances, putting the options in a file will work better, since using a number of

options can get unwieldy on the command line. In addition, if you’re trying to ensure that the

server or tools are consistently started with the same options, it is best to have them saved in an

option file that can be loaded by the server or tool, without the risk of an option being left out.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Here, we will briefly outline commonly used options, grouped in the following functional

areas:

• Client configuration

• Server configuration

• Logging configuration

• Engine-specific configuration

• Replication configuration

• Buffer and cache allocation configuration

• Server SSL configuration

For details on why or when you might use particular configuration options, see the

chapters in this book that correspond with that functional area. Also, refer to the MySQL

documentation at http://dev.mysql.com/doc/mysql/en/Option_files.html. You'll notice we

use both underscore and dash when writing out configuration options in the following tables.

You can use either underscore (_) or dash (-) when writing configuration options.

Client Configuration Options

Table 14-5 lists the common options used by client programs, including the mysql command-

line interface and the administrative tools.

Table 14-5. Common Client Configuration Options

Option

Description

password=<password>

Password used to connect to server

port=<number>

socket=<file>

ssl

user=<name>

Port number for clients to connect to server

Socket file for client connections

Use SSL for your database connection

Username used for connecting to server

Server Configuration Options

The options outlined in Table 14-6 are directed at running the mysql server and the core func-

tionality provided by the server.

Table 14-6. Server Configuration Options

Option

ansi

console

Description

Use ANSI SQL syntax, not MySQL syntax

basedir=<dir>

Path to installation directory; most paths are relative to this

bind-address=<ip address>

IP to use when binding server to address

character_set_server=<name>

Set the default character set

chroot=<name>

During startup, chroot mysqld daemon

Use screen for error output; keep Windows console

window open


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Option

datadir=<dir>

Description

Path to the data files

default-storage-engine=<name>

Use this as the default storage engine for tables

default-time-zone=<name>

Set the default time zone

init-file=<name>

At startup, read SQL commands from this file

join_buffer_size=<number>

Size of buffers used for full joins

key_buffer_size=<number>

long_query_time=<number>

low-priority-updates

lower_case_table_names[=<number>]

Size of buffer allocated for index blocks for MyISAM tables

Query execute time which, when exceeded, triggers entry

in slow query log

Make SELECT statements take priority over INSERT, UPDATE,

or DELETE

Set to 1 when tables are created in lowercase on disk

and table names are case-insensitive; set to 2 for a case-

insensitive file system

max_allowed_packet=<number>

Maximum packet length to send/receive from/to server

max_binlog_size=<number>

Binary log will be rotated automatically when the size

exceeds this value (minimum value is 4096)

max_connections=<number>

Number of simultaneous clients allowed

max_connect_errors=<number>

max_join_size=<number>

Connections from a host will be blocked if number of

interrupted connections from the host exceeds this

number

Error returned if join statement will return more than this

number of records

max_length_for_sort_data=<number>

Maximum number of bytes in a set of sorted records

max_sort_length=<number>

Maximum number of bytes for sorting BLOB or TEXT values

max_tmp_tables=<number>

max_user_connections=<number>

memlock

old-passwords

pid-file=<file>

port=<number>

safe-user-create

read-only

skip-grant-tables

Maximum number of temporary tables a client can keep

open at a time

Maximum number of active connections for a single user;

set to 0 for no limit

Lock mysqld in memory, don’t use swap disk; must run

server as root

Use old password encryption (useful for versions 4.0 and

earlier)

PID file used by safe_mysqld

Use this port number for connections

Don’t allow new user creation by the user who has no

write privileges to the mysql.user table

Except for replication and users with SUPER privilege, make

tables read-only

Don’t load grant tables on startup; open all tables to all

users

Continued

skip-networking

Don’t allow TCP/IP connections


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Table 14-6. Continued

Option

skip-show-database

skip-stack-trace

skip-symbolic-links

skip-thread-priority

socket=<file>

sort_buffer_size=<number>

symbolic-links

sync-binlog=<number>

tmp_table_size=<number>

tmpdir=<dir>

Description

Prevent SHOW DATABASE commands

If database fails, don’t print stack

Prevent symbolic linking of tables

Give all threads identical priorities

Socket file to use for database connections

When a thread needs to sort, this size is used for allocating

the buffer for that sort

Support symbolic links

Every nth event, the binary log is synchronized to disk; set

to 0 for no synchronization

If an in-memory temporary table exceeds this size, MySQL

will automatically convert it to an on-disk MyISAM table

Location for temporary files; specify multiple paths

separated by a colon, which will be used in round-robin

order

user=<name>

Run mysqld server daemon as user

Logging Configuration Options

The options listed in Table 14-7 are geared toward the logging functions of MySQL, allowing

you to specify types of information to log, location of logs, detail level, and log sizes. These

options are discussed in more detail in Chapters 18 and 20.

Table 14-7. Common Logging Configuration Options

Option

binlog-do-db=<name>

Description

binlog-ignore-db=<name>

Do not log updates in the binary log for this database

Log updates for the specified database, and exclude all others

not explicitly mentioned

log-bin-index=<file>

File that keeps track of binary log filenames

File to log connections and queries

Log updates using binary format

Log error file

File to log all MyISAM changes

log[=<file>]

log-bin[=<file>]

log-error[=<file>]

log-isam[=<file>]

log-short-format

log-slave-updates

log-queries-not-using-indexes

Log queries that are executed without using an index

Log minimal information for updates and slow queries

Slave will log updates made to the slave database; turn on for

daisy-chain slaves

log-slow-queries[=<file>]

Log slow queries to this log file; default name is

hostname-slow.log

log-warnings[=<number>]

Send noncritical warnings to the log file


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Engine-Specific Configuration Options

Engine-specific configuration options are outlined in Table 14-8. Storage engines are discussed

in more detail in Chapters 5 and 19.

Table 14-8. Common Engine-Specific Configuration Options

Option

bdb

bdb-home=<path>

bdb-logdir=<path>

bdb_max_lock=<number>

bdb-tempdir=<path>

innodb

innodb_buffer_pool_size=<number>

innodb_data_file_path=<path>

innodb_data_home_dir=<path>

innodb_fast_shutdown

innodb_file_per_table

Description

Enable BDB (if this version of MySQL supports it);

disable with skip-bdb (to save memory)

Location for BDB data files; should be same as

datadir

Location for BDB log files

Maximum locks on a BDB table

Location for BDB temporary files

If MySQL binary allows, enable InnoDB

Size of memory used by InnoDB to cache data and

indexes

Path to individual files and their sizes (combines

with innodb_data_home_dir)

The common part for path to InnoDB tablespaces

Faster server shutdown

Breaks InnoDB tables into separate .ibd file in data

directory

innodb_flush_log_at_trx_commit[=<number>] Value of 0 will write and flush every second; value

of 1 (recommended and the default) will write and

flush at each commit; value of 2 writes at commit,

flushes every second

innodb_log_arch_dir=<path>

innodb_log_archive[=<number>]

innodb_log_buffer_size=<number>

innodb_log_file_size=<number>

innodb_log_group_home_dir=<path>

innodb_max_dirty_pages_pct=<number>

innodb_open_files=<number>

innodb_safe_binlog

isam

max_heap_table_size=<number>

myisam-recover[=<name>]

myisam_sort_buffer_size=<number>

ndbcluster

skip-bdb

Location for log archives

If you want archived logs, set to 1

Buffer size for InnoDB when writing logs to disk

Size of each InnoDB log file in group, specified in

megabytes; once size is reached, MySQL creates

new log file

Path to InnoDB log files

Percentage of dirty pages allowed in buffer pool

Maximum number of files InnoDB keeps open

simultaneously

InnoDB truncates the binary log after the last not-

rolled-back transaction after a recovery from a crash

Enable ISAM (if this version of MySQL supports it)

Don’t allow creation of heap tables bigger than this

Syntax is myisam-recover[=option[,option...]],

where option can be DEFAULT, BACKUP, FORCE, or QUICK

Size of buffer for sorting when recovering tables or

creating indexes

Enable NDB Cluster (if this version of MySQL

supports it).

Disable BDB table type


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Replication Configuration Options

MySQL replication enables you to create near-real-time duplication of your data onto another

database server. Table 14-9 lists the configuration options for controlling replication. Replica-

tion is covered in Chapter 18.

Table 14-9. Common Replication Configuration Options

Option

Description

master-connect-retry=<number>

master-port=<number>

Port on master for slave connections

master-host=<name>

master-password=<password>

master-retry-count=<number>

master-ssl

master-user=<name>

max_relay_log_size=<number>

relay-log=<file>

replicate-do-db=<name>

replicate-do-table=<name>

replicate-ignore-db=<name>

replicate-ignore-table=<name>

relay-log-info-file=<file>

replicate-wild-do-table=<name>

replicate-wild-ignore-table=<name>

server-id=<number>

slave-load-tmpdir=<dir>

slave-skip-errors

Number of seconds the slave thread will sleep before

retrying to connect to the master in case the master goes

down or the connection is lost

Master hostname or IP address for replication (required for

slave to run); can also exist in master.info file

Slave thread will use this password when connecting to the

master

Number of tries the slave will make to connect to the

master before giving up

Enable the slave to connect to the master using SSL

Slave thread will use this name when connecting to the

master

Size at which relay log is rotated (minimum is 4096); set to

0 to have relay log rotated with max_binlog_size

File location and name where relay logs are stored

Tells slave to replicate a specific database; use directive

multiple times to specify multiple databases

Tells slave to replicate only the named table; use directive

multiple times to specify more than one table

Tells slave to ignore this database; use directive multiple

times to specify multiple databases

Tells slave to ignore this table; use directive multiple times

to specify multiple tables

File that maintains the position of the replication thread in

the relay logs; default is in data directory

Slave replicates tables matching the wildcard pattern; use

directive multiple times to specify multiple databases

Slave ignores tables matching the wildcard pattern; use

directive multiple times to specify multiple wildcard

patterns

Unique identifier for server when a part of replication

system

Location for slave to store temporary files when replicating

a LOAD DATA INFILE command

Slave continues replication when an error is returned from

processing a query

skip-slave-start

Don’t automatically start slave


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Buffer and Cache Allocation Configuration Options

Table 14-10 lists the buffer and cache allocation options. These are tightly aligned with

server performance. Details on the buffer and cache subsystems are covered in more depth

in Chapter 4.

Table 14-10. Common Buffer and Cache Allocation Configuration Options

Option

Description

binlog_cache_size=<number>

Cache size for holding SQL statements headed to the binary log

flush_time=<number>

Flush all tables at the given interval (in seconds); handled by at

dedicated thread

query_cache_limit=<number>

Queries with results larger than this are not cached

query_cache_size=<number>

Memory allocated for storing results from queries

Server SSL Configuration Options

Table 14-11 shows the configuration options for using SSL with MySQL. These are an integral

part of securing remote connections to the database, as discussed in Chapter 16.

Table 14-11. Server SSL Configuration Options

Option

skip-ssl

ssl

Description

Do not allow SSL connections

Allow secure connections (ssl-ca, ssl-cert, and ssl-key must be present)

ssl-ca=<file>

File that contains a list of trusted Certificate Authorities

ssl-capath=<dir>

Directory with trusted Certificate Authority .pem files

ssl-cert=<file>

SSL certificate used in creating secure connections

ssl-key=<file>

SSL key used in creating secure connections

Upgrading MySQL

Upgrading MySQL is fairly straightforward. For the most part, you can remove the existing

installation and put a new one in its place. In cases where the MySQL-provided instructions

indicate, you’ll need to upgrade the permissions tables using the mysql_fix_privilege_tables

script, depending on the version of your existing installation and the upgrade version. See

the MySQL documentation at http://dev.mysql.com/doc/mysql/en/Upgrade.html for version-

specific upgrade requirements.

Before you start an upgrade, you want be sure to preserve two pieces of the existing instal-

lation: your configuration files and your data files. It is wise to make copies of both before an

upgrade.


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

Upgrade your version of MySQL as follows:

Manually installed tarball on Unix: After copying the configuration files and data files,

shut down your database. Unpack the new tarball to /usr/local and move the mysql

symbolic link to the new version. If you keep your data and configuration files in

/usr/local, copy your data and configuration file into the data directory within the new

mysql install directory. Start the server and run mysql_fix_privilege_tables if necessary.

Manually installed on Windows: After copying the configuration files and data files,

shut down your database. Unpack the zip file at C:\ and rename the directory to mysql.

If necessary, copy the backup configuration files and data files into the new installation

directory. Start the database and run the mysql_fix_privilege_tables script if necessary.

Installed with the Windows installer: The Windows installer is designed to handle upgrades.

After downloading the new installer, stop your server. If you’re upgrading from a version

prior to 4.1.5, remove the MySQL service with C:\mysql\bin\mysqld --remove. After the

database is stopped and service removed, double-click the installer and go through the

installation.

Installed with an RPM: Upgrading an RPM is fairly simple. The RPM upgrade process

respects added data files and changed configuration files, but it’s always a good idea to

back up your files before beginning the installation. Get the latest set of RPM files and

use the rpm tool to upgrade your packages.

Installed with the Mac installer: Upgrading on a server where the Mac installer has been

used for install is similar to upgrading a tarball. Make a copy of your configuration and

data files, shut down the server, and then run the installer program for the new version.

This will install the new version in /usr/local and create a symbolic link for the new

install to /usr/local/mysql. Copy the configuration files and data into the new install

folder, if necessary, and start the database. Run the mysql_fix_privilege_tables script

if required.

Uninstalling MySQL

While we hope you aren’t uninstalling MySQL because you don’t want to use it anymore, it is

important to know just how to get a MySQL installation off a machine. For example, you may

want to cleanly install a new instance of the database or move your database server to a new

machine.

■Caution Before starting the process of uninstalling MySQL, make sure you have a copy of your data and

configuration files if you plan to use them again. Also, be sure to shut down the database before starting to

remove the database.

The ease of uninstalling MySQL depends on which mechanism you used to install it. If

you installed with an RPM or the Windows Installer, you can run an uninstall program that will

remove the previously installed files. If you installed from a binary tarball or source into the


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

recommended /usr/local/mysql location, you can delete that directory. If you’ve installed

from source into /usr/local, you are faced with manually determining all the files installed

with your MySQL and removing them individually.

Once you’ve removed the binaries and main mysql directory, you might want to check in

the data directory and in common locations for configuration files to verify that all files have

been removed.

Last, if the machine shouldn’t be running a MySQL server, you should verify that the

server isn’t in the startup or Windows service. Table 14-3 indicates how to add MySQL to the

startup of a machine. Reverse those instructions to disable automatic startup, using a com-

mand or editing a particular file to change the start option.

Running Multiple Database Servers

on a Single Machine

Running multiple instances of a MySQL database is fairly simple. The recommended method

is to use the mysql_multi script, which will let you set options for the different server numbers

in one configuration file, organized by groups. The mysql_multi script can start and stop any

number of servers based on mysqld group numbers defined in the configuration file and

passed to mysql_multi on the command line. If using mysql_multi doesn’t work for you, you

can also run a separate, simultaneous instance of mysqld by starting up with the command-

line option --defaults-file pointed at files with different settings to allow for multiple server

instances.

The key parameters that can’t overlap on multiple instances of the server are the port,

Unix socket (Unix only), process ID file (Unix only), and shared memory base name (Windows

only). By changing these options, you can run any number of servers. If you have logging

options turned on, you must specify different locations for each server. These include log,

log-bin, log-update, log-error, log-isam, and bdb-logdir.

You most likely want to change the data directory for each server instance. Running mul-

tiple servers against one set of data files is not recommended, as it can cause problems if the

system locking isn’t perfect.

Except for the port and socket, all of the options can be more automatically set for each

server instance by changing the basedir option. Using basedir tells the MySQL server to put

the data, process ID file, and log files in a location relative to the basedir. Listing 14-2 shows a

sample configuration file using the basedir option.

Listing 14-2. Sample my.cnf File for mysql_multi

# my.cnf

[mysqld1]

basedir=/usr/local/mysql/server1

port=3306

socket=/tmp/mysql.sock1

[mysqld2]

basedir=/usr/local/mysql/server2

port=3307

socket=/tmp/mysql.sock2


C H A P T E R   1 4   ■ M Y S Q L   I N S TA L L AT I O N  A N D   C O N F I G U R AT I O N

When using client tools on a multiple-instance server, it’s important to be clear about

which server you intend to use. You can use your local ~/.my.cnf file to specify the port or

socket to use when connecting, or specify the port or socket file on the command line when

running the client or tool. Another option is to create ~/.my.cnf1 and ~/.my.cnf2, and use the

--defaults-extra-file=~/.my.cnf2 command to load the options for connecting to the cor-

rect instance.

Summary

In this chapter, we’ve covered the wide spectrum of installation options for MySQL. These vary

from simple, no-configure binary package installations to the complexity of building from

source and digging into varying levels of configuration files and option details. MySQL AB

places a great deal of emphasis on creating what the users of the database need, and attempts

to provide an installation process for the novice or small-scale user, all the way to the expert,

large-scale-deployment user.

Once you’ve installed MySQL, there are a number of post-installation steps to consider

in making sure the database is set up to run smoothly. Part of this may include switching to

another prebuilt configuration file, and possibly editing your configuration to make the data-

base behave and perform to your needs. Becoming familiar with all the configuration options

for MySQL is a daunting task, but as you learn how to tweak the settings, you can create a set

of options that make your server and tools hum along in perfect harmony with the needs of

your organization.

As you watch development move forward and new releases become available, you’ll want

to review the steps for upgrading your MySQL installation.


C H A P T E R   1 5

■ ■ ■

User Administration

In this chapter, we will look at the methods you, as a database administrator, have to control

the access and permissions of users within the database server. To effectively and securely

manage multiple user accounts on one or more database servers, it’s helpful to understand

how MySQL determines if a user has the rights to perform a specific action, or whether the

user account even has access to the system at all.

Because seemingly small user administration mistakes can lead to users gaining access

to information that should not be available to them, it is important for you to understand the

subtle differences between MySQL’s many privileges. Additionally, you may be surprised to

learn the order in which MySQL determines if privileges are granted. We’ll step you through

these topics in this chapter, as well as demonstrate how to accomplish user administration

tasks in both a console and a graphical environment.

Specifically, we will cover the following topics:

• The MySQL privileges

• How MySQL authenticates users and verifies user privileges

• User account management from the command line

• User account management with the MySQL Administrator GUI tool

• Role-based management considerations

• Guidelines for administering users

MySQL Privileges

MySQL uses a set of tables in the mysql database called the grant tables to check incoming

connections and requests. These grant tables are loaded into memory when the database

server starts. Depending on the commands used to grant access or change permissions, this

in-memory table data is reloaded immediately or after a FLUSH PRIVILEGES command is exe-

cuted. When the grant tables are manually changed (using an INSERT, UPDATE, or DELETE

command on the actual grant table), changes are not reflected in the in-memory table data

(which is the data on which the server operates) until a FLUSH PRIVILEGES command is exe-

cuted. On the other hand, changes made to the grant tables through the GRANT, REVOKE, and

CREATE USER (which, in MySQL 5.0.2 and later, adds users with no privileges) commands are

reflected in the in-memory data immediately. It is for this reason that we recommend using

the GRANT and REVOKE commands over direct manipulation of the grant tables.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Granting and Revoking Privileges

The list of actions that the current user can perform is called the user’s set of privileges.

MySQL’s privileges (or permissions) are either granted or not granted—the user has the ability

to execute the needed request or the user does not have this ability.

■Note In other database servers, permissions are often kept in a three-state format: granted, not granted

(revoked), or default. The default permission works with the server’s role-based security, where a user can

belong to multiple groups of users, with each group having a set of permissions. If the user’s permission

for an action is set to default, the user inherits the permissions of the groups to which they belong. Since

MySQL does not implement group-, or role-, based security, it does not use a third logic state to handle

security inheritance. We will discuss role-based user organization in the “Thinking in Terms of User Roles”

section later in this chapter.

To grant a user account privileges on the system, use the GRANT command, which follows

this basic syntax:

GRANT priv_type ON {*.* | * | db_name.* | table_name} TO username;

To remove a privilege for a user account, use the REVOKE command:

REVOKE priv_type ON {*.* | * | db_name.* | table_name} FROM username;

Both the GRANT and REVOKE commands can alter privileges for multiple users in a single

command. To do so, simply provide a delimited list of usernames after the TO or FROM clauses.

You’ll see many examples of GRANT and REVOKE commands in this chapter.

Understanding Privilege Scope Levels

The MySQL privileges are organized into various scope levels. The scope of the privilege is the

level at which the permission to do something is applied. While some privileges pertain to

actions that are performed at the server level—such as the PROCESS or SHUTDOWN privilege—

other permissions may apply to actions performed inside a specific database, table, or even a

specific column of a table. MySQL arranges privileges in this way so that database administra-

tors can allow users to execute various requests against one database object but not another.

MySQL 5.0.3 and later versions include five scope levels for privileges, with a corresponding

table in the mysql database for each:

• Global scope, corresponding with the user grant table

• Database scope, corresponding with the db grant table

• Table scope, corresponding with the tables_priv grant table

• Column scope, corresponding with the columns_priv grant table

• Routine scope, corresponding with the procs_priv grant table


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

To determine if a user may perform a given request, MySQL looks for privileges at the

highest scope level (global) first. If the needed privilege is not granted at that level, MySQL

looks for the permission at the next scope level down. If the privilege is found at any level, the

request is granted. Some privileges exist only at certain levels; others exist at more than one

level. As we cover each of the privilege scope levels, you will see the logical overlap of certain

privileges, such as the SELECT privilege, which may be granted for various levels of database

objects, from an entire database to a single column.

In the following sections, we’ll review the privileges available at each scope level. The

exact list of privileges that are used to evaluate the incoming request depends on the version

of MySQL you are using, as new features added in later versions have required additional priv-

ilege sets. In this chapter, we present the privileges in the MySQL 5.0.4-beta.

■Note When upgrading MySQL versions, always check to make sure that you have upgraded the grant

tables appropriately. In your upgrade installation, under the /scripts directory, you will find a file named

mysql_fix_privilege_tables.sql. Executing this script (using the MySQL client SOURCE command) will

add new privilege fields and tables to the mysql system database. Ensure changes to the grant tables are

reflected by issuing a FLUSH PRIVILEGES command after running this script.

Global Privilege Scope

All privileges contained in the mysql.user table pertain to privileges available to the user on a

global level. These privileges apply to all databases on the server. If a privilege is granted at the

global level, it will override all other scope levels. Therefore, it is imperative to verify that users

receiving global privileges should indeed be allowed such access.

To grant a user globally scoped privileges, follow the ON keyword of the GRANT statement

by *.*. Here is an example of granting the PROCESS privilege (which allows the user to use the

SHOW PROCESSLIST command) to a user:

mysql> GRANT PROCESS ON *.* TO 'root'@'localhost';

Query OK, 0 rows affected (0.00 sec)

■Note The results output of GRANT statements will always show Query OK, 0 rows affected. This does

not mean the query had no effect. If anything was wrong with the GRANT statement, an error will be returned.

Table 15-1 lists all the privileges available under the global scope, along with which version

of MySQL the privilege became active and a brief explanation regarding what function the privi-

lege enables the user account to perform. In addition to the privileges listed in Table 15-1, the

GRANT OPTION and ALL privileges are available.1 We’ll cover these special cases later in

the chapter.

1. Additionally, there is a REFERENCES privilege available at the global, database, table, and column scope

MySQL.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Table 15-1. Global Scope Privileges

Privilege Name

Versions

Access Allowed

CREATE TEMPORARY TABLES

4.0.2+

ALTER

ALTER ROUTINE

CREATE

CREATE ROUTINE

CREATE USER

CREATE VIEW

DELETE

DROP

EXECUTE

FILE

INDEX

INSERT

PROCESS

RELOAD

LOCK TABLES

4.0.2+

REPLICATION CLIENT

4.0.2+

All

5.0.3+

All

5.0.3+

5.0.3+

5.0.1+

All

All

All

5.0.3+

All

All

All

All

Change table structures for any database.

Change or drop any stored procedures, triggers, and

functions (routines) in any database.

Create databases, and create tables and indexes in all

databases.

Create stored procedures, triggers, and functions in

any database.

Use the TEMPORARY keyword when creating tables in

the connection.

Create other users in the system.

Create views in any database.

Remove rows from any table in any database. The

REPLACE command requires both this and the INSERT

permission.

Remove any database object, including the database

itself using the DROP DATABASE statement.

Run stored procedures, triggers, and functions in any

database.

Issue LOAD DATA INFILE and SELECT . . . INTO FILE

commands. Note that the only files that can be read

using this command are files that are globally

readable (world-readable) or readable by the MySQL

server daemon. Generally, anything in the data_dir

will be readable. The user can also write files in those

same directories (using the SELECT . . . INTO FILE

command), but cannot overwrite existing files. Also

note that the FILE privilege is not needed if the user

uses the LOCAL keyword in the LOAD DATA INFILE

command.

Create and remove (DROP) indexes on existing tables in

all databases. Note that the CREATE privilege allows for

creation of indexes in the CREATE TABLE statement as

well.

Insert rows into a table in any database. The REPLACE

command requires both this and DELETE permission.

Used in conjunction with the SELECT privilege to

determine if the current user can explicitly execute a

LOCK TABLES command.

Execute the SHOW PROCESSLIST commands, enabling

the user to view the contents of currently executing

queries.

Various refresh tasks, including the ability to flush

(refresh) various database objects like privileges and

tables.

Issue the SHOW MASTER STATUS and SHOW SLAVE STATUS

commands.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Privilege Name

Versions

Access Allowed

REPLICATION SLAVE

SELECT

SHOW DATABASES

SHOW VIEW

SHUTDOWN

SUPER

UPDATE

USAGE

4.0.2+

All

4.0.2+

5.0.1+

All

4.0.2+

Must be given to the connecting slave’s client user to

enable subscription to the master server.

Retrieve the information in a table in any database.

Execute the SHOW DATABASES command and obtain a

list of the server’s databases.

Execute the SHOW CREATE VIEW command.

Shut down the database server via mysqladmin. There

is no ability to shut down the server from any mysql

client, for obvious reasons.

Kill a process. Of course, this privilege would be fairly

useless unless the user was also granted the PROCESS

permission. Additionally, this privilege enables the

CHANGE MASTER, PURGE MASTER LOGS, and SET GLOBAL

commands.

All

All

Update rows in a table in any database.

Used to create a user with no privileges.

In order to specify more than one privilege at a time, simply separate privilege names

using a comma in the GRANT statement, as in this example:

mysql> GRANT SELECT, INSERT, DELETE, UPDATE ON *.*

-> TO 'jpipes'@'localhost';

Query OK, 0 rows affected (0.01 sec)

■Note To change a table with an ALTER TABLE statement, the user must actually have the CREATE,

ALTER, and INSERT permissions. Additionally, the ALTER permission allows a user to rename a table, and

so is a security risk, since the current user might rename system tables (grant tables) used by MySQL in its

access control.

Database Privilege Scope

Privileges applied at the database scope level pertain to the specified database and all objects

contained within it, including tables and routines. To specify database-level privileges, you

can use either one of two conventions:

• If you follow the ON keyword of the GRANT statement with a single asterisk (*), the privi-

leges will be applied to the currently selected database. However, be aware that if no

database is currently selected, and you follow the ON keyword with a single asterisk,

the privileges will be applied on a global scope!

• You may follow the ON keyword with db_name.*, where db_name is the name of the

database for which you are granting privileges. This is the recommended way to grant

database-level privileges, as it provides more specificity and avoids the risk of acciden-

tally granting global privileges.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Here is an example of granting multiple user accounts SELECT rights on the ToyStore

schema by chaining usernames together after the TO clause:

mysql> GRANT SELECT ON ToyStore.*

-> TO 'mkruck'@'localhost', 'jpipes'@'localhost';

Query OK, 0 rows affected (0.01 sec)

Table 15-2 lists all of the privileges available at a database level.

Table 15-2. Database Scope Privileges

Privilege Name

Versions

Access Allowed

CREATE TEMPORARY TABLES

4.0.2+

Use the TEMPORARY keyword when creating tables in the

specified database within the user session.

ALTER

ALTER ROUTINE

CREATE

CREATE ROUTINE

CREATE VIEW

DELETE

DROP

EXECUTE

INDEX

INSERT

SELECT

SHOW VIEW

UPDATE

All

5.0.3+

All

5.0.3+

Change table structures for the specified database.

Change or drop any stored procedures, triggers, and

functions in the specified database.

Create databases, and create tables and indexes in

the specified databases.

Create stored procedures, triggers, and functions in

the specified database.

5.0.1+

Create views in the specified database.

Remove rows from any table in the specified database.

Remove all objects within the specified database,

including the database itself using the DROP DATABASE

statement.

5.0.3+

Run stored procedures, triggers, and functions in the

specified database.

Create and remove (DROP) indexes on existing tables in

the specified database.

Insert rows into a table in the specified database.

Used in conjunction with the SELECT privilege to

determine if the current user can explicitly execute a

LOCK TABLES command for tables within the specified

database.

Retrieve the information in a table in the specified

database.

5.0.1+

Execute the SHOW CREATE VIEW command.

Update rows in a table in the specified database.

All

All

All

All

All

All

LOCK TABLES

4.0.2+


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

PERMISSIONS FOR TEMPORARY TABLES

You can’t give users separate sets of permissions to regular tables and to temporary tables. If you’re in a

situation where you need to allow users to create and work with temporary tables, but not regular database

tables, consider implementing a solution described by Dietrich Feist on the MySQL web site. He recommends

creating a separate database strictly for working with temporary tables, which would allow you to grant dif-

ferent permissions to temporary tables than you grant to regular tables. You can grant users all the needed

permissions in this database, but restrict certain permissions (like CREATE, ALTER, and so on) on your regu-

lar databases. To create temporary tables, users would need to explicitly reference the temporary database

name before all table names.

The following are the steps to set up a separate database for temporary tables (using the company

database and an imaginary user some_restricted_user):

1. Set up a database for temporary table usage:

mysql> CREATE DATABASE tmp;

2. Grant the restricted user the ability to do needed work in the new tmp database:

mysql> GRANT SELECT, INSERT, UPDATE, DELETE,

->DROP, ALTER, CREATE TEMPORARY TABLES

-> ON tmp.*

-> TO 'some_restricted_user'@'localhost';

3. Grant restricted permissions on the regular company database:

mysql> GRANT SELECT, INSERT, UPDATE, DELETE

-> ON company.*

-> TO 'some_restricted_user'@'localhost';

Keep in mind that some_restricted_user would need to prefix CREATE TEMPORARY TABLE

statements with the tmp. database prefix if the table were created using data from another database and

some_restricted_user had already selected another database:

mysql> USE company;

mysql> CREATE TEMPORARY TABLE tmp.Employee SELECT * FROM Employee;

This approach is similar to how other database servers allow you to manage different permission

sets for temporary and regular tables. See http://dev.mysql.com/doc/mysql/en/Privileges_

provided.html for more details on the strategy.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Table Privilege Scope

Privileges applied at the table scope level pertain to a specific table only. To specify table-level

privileges, you follow the ON keyword with the full name of the database table for which you

are granting privileges, in the form db_name.table_name.

Suppose you have a user account responsible for some automated mailers running from

cron job on a remote server. The script needs to access and change only the information in

the ToyStore.Customer table. Here’s how you might grant this limited access to such a user:

mysql> GRANT SELECT, INSERT, UPDATE, DELETE

-> ON ToyStore.Customer TO 'responder'@'mail.example.com';

Query OK, 0 rows affected (0.33 sec)

The GRANT command will create a new user if no existing user account is found for the

one used in the statement. Therefore, executing the preceding statement will create the user

account for responder@mail.example.com, if such a user did not already exist on the server.

Table 15-3 lists all privileges available at the table scope level.

Table 15-3. Table Scope Privileges

Privilege Name

Versions

Access Allowed

ALTER

CREATE

DELETE

DROP

INDEX

INSERT

SELECT

UPDATE

All

All

All

All

All

All

All

All

Change the structure of the specified table.

Create the specified table. The CREATE privilege is needed

for the ALTER TABLE command to succeed.

Remove rows from the specified table.

Remove the specified table and any indexes attached to it.

Create and remove (DROP) indexes on the specified table.

Insert rows into the specified table.

Retrieve the information in the specified table.

Update rows in a table in the specified database.

Column Privilege Scope

Privileges applied at the column scope level pertain to one or more columns within a specific

table. To specify column-level privileges, you must follow the ON keyword with the full name of

the database table for which you are granting privileges, in the form db_name.table_name, just

as you do with table-level privileges. In addition, you must specify the columns you are chang-

ing privileges for in parentheses after the privilege list.

To continue our example in the previous section, suppose that after some consideration,

you decide that the responder@mail.example.com user account should not be able to retrieve

the contents of the password column of ToyStore.Customer. You may be tempted to simply use

the REVOKE command to remove the SELECT privilege from the user account for this column.

Doing so, however, will result in an error:

mysql> REVOKE SELECT (password) ON ToyStore.Customer

-> FROM 'responder'@'mail.example.com';

ERROR 1147 (42000): There is no such grant defined for user 'responder' \

on host 'mail.example.com' on table 'Customer'


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

MySQL is helpfully informing you that you have not specifically granted any column

privileges. Remember that you have already granted responder@mail.example.com table-level

rights to the Customer table. To remove rights to a specific column of the table, you must first

revoke the table-level rights you have granted, and then grant column-specific privileges to

those fields you wish the user to see. Listing 15-1 illustrates this process.

Listing 15-1. Revoking Table-Level Privileges and Granting Column-Level Privileges

mysql> REVOKE SELECT, INSERT, UPDATE, DELETE ON ToyStore.Customer

-> FROM 'responder'@'mail.example.com';

Query OK, 0 rows affected (0.00 sec)

mysql> GRANT SELECT (customer_id, login, created_on, first_name

-> , last_name, shipping_address, shipping_city, shipping_province

-> , shipping_postcode, shipping_country)

-> ON ToyStore.Customer TO 'responder'@'mail.example.com';

Query OK, 0 rows affected (0.32 sec)

Notice that each column you wish to assign rights to must be included in the column list

after the SELECT privilege keyword in the GRANT statement.

Table 15-4 lists the privileges available at the column scope level.

Table 15-4. Column Scope Privileges

Privilege Name

Versions

Access Allowed

INSERT

SELECT

UPDATE

All

All

All

Insert data into the specified column(s) of the table.

Retrieve the data from the specified column(s) of the table.

Update data in the specified column(s) of the table.

■Note If a user who does not have rights to insert data into a column attempts to do so, the default value

for the column is inserted and the INSERT request proceeds as normal. This is a deviation from the SQL

standard, which dictates that the user must have the INSERT privilege on all columns in the table in order

to insert a row of data.

Routine Privilege Scope

The routine privilege scope level applies to individual stored procedures and functions. You

must specify the database name and the routine name when granting rights at the routine

level, as in this example:

mysql> GRANT EXECUTE ON test.ShowIndexSelectivity TO 'jpipes'@'localhost';

Query OK, 0 rows affected (0.32 sec)

Table 15-5 lists the two privileges available at the routine scope level.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Table 15-5. Routine Scope Privileges

Privilege Name

Versions

Access Allowed

ALTER ROUTINE

EXECUTE

5.0.3+

5.0.3+

Modify the definition of the stored procedure or function.

Run the stored procedure or function.

■Note For the routine, column, and table-level privileges, the referenced object must be present in the

database before privileges can be granted to a user for the object. This is not the case for database-level

privileges. You may assign database-level privileges to a user account for a database that has not yet been

created.

The GRANT OPTION Privilege

A special privilege provides users with the ability to grant privileges to other users. This is an

extremely critical privilege to understand, as not knowing its impact can seriously undermine

the security of your database server.

Essentially, when the GRANT statement is issued with the WITH GRANT OPTION clause, it means

that the user being granted privileges has the ability to grant other users the same privileges they

have. While this may seem like a fairly harmless ability, there are some serious drawbacks to

using WITH GRANT OPTION frivolously.

Imagine you have set up one user with only the SELECT, LOCK TABLES, and RELOAD privileges

(for doing backups), and you have another user set up with SELECT, CREATE, ALTER, DROP, INSERT,

DELETE, and INDEX privileges (for database design work). You have wisely created separate

users for doing separate tasks, and as the database administrator, you would like to keep it

that way. However, a sticky situation could develop if you created the accounts with the

WITH GRANT OPTION clause: the two users could grant each other their own privileges, thereby

negating all your hard work to try to prevent the database designer from having the LOCK ➥

TABLES privilege. Even more problematic, you now have two more users who can create new

user accounts. As we mentioned earlier, issuing a GRANT statement for a user that does not yet

exist prompts MySQL to create a new user account for that user. So, as always with the GRANT

statement, be careful what privileges you are bestowing.

■Caution Unless you are working on a large database system with a number of database administrators,

there are very few reasons to use the WITH GRANT OPTION clause. It is a security headache and produces,

in our opinion, very little benefit. User privileges should be granted by very few individuals, preferably only

one. This ensures consistency and conformity to company security policies.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Granting All Privileges

When you want to grant or revoke all available privileges for a user (except for the GRANT ➥

OPTION privilege) at a specific privilege scope level, you can substitute the keyword ALL for

the (much longer and cumbersome) list of privileges. For instance, if you wanted to provide

mkruck@localhost all privileges on the ToyStore.Customer table, you could issue the following:

GRANT ALL ON ToyStore.Customer TO 'mkruck'@'localhost';

This would affect all table-level privileges: SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX,

and ALTER.

Issuing GRANT ALL requests at other scope levels yields similar results. Consider this example:

GRANT ALL ON ToyStore.* TO 'mkruck'@'admin.example.com';

This would grant the user account mkruck@admin.example.com the database-level privileges of

ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE,

DROP, EXECUTE, INSERT, UPDATE, INDEX, SELECT, SHOW VIEW, and LOCK TABLES. By using the *.*

modifier, you grant the user every privilege except the GRANT OPTION privilege, so take care

when using the ALL keyword to use the correct scope modifier after the ON keyword!

To revoke all privileges issued to a user account, use the REVOKE ALL command:

REVOKE ALL ON *.* FROM 'mkruck'@'localhost';

This would remove all global privileges from mkruck@localhost except for the GRANT OPTION

privilege.

To include the GRANT OPTION privilege in the REVOKE command, issue the following version:

REVOKE ALL, GRANT OPTION ON *.* FROM 'mkruck'@'localhost';

This syntax is available from MySQL 4.1.2. Prior to this version, two statements are neces-

sary to remove all privileges for a user:

REVOKE ALL ON *.* FROM 'mkruck'@'localhost';

REVOKE GRANT OPTION ON *.* FROM 'mkruck'@'localhost';

Viewing User Privileges

You can use a number of methods to obtain information regarding a user’s granted or revoked

privileges. Which method you choose is a really just a matter of formatting preference. Here,

we’ll cover using the SHOW GRANTS command and querying the grant tables directly. Another

method of viewing user privileges is to use the new support for the INFORMATION_SCHEMA virtual

database, which we’ll cover in Chapter 21.

One way to check a user’s grants is to use the SHOW GRANTS statement:

Using SHOW GRANTS

SHOW GRANTS FOR username;


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

This will show, in reproducible GRANT statements, the privileges available to the user

(helpful in reminding you of the syntax for the GRANT statement). Listing 15-2 shows the output

of SHOW GRANTS.

Listing 15-2. SHOWS GRANTS Output

mysql> SHOW GRANTS FOR 'jpipes'@'localhost';

+------------------------------------------------------------------------+

| Grants for jpipes@localhost                                            |

+------------------------------------------------------------------------+

| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'jpipes'@'localhost'    |

| GRANT SELECT ON `ToyStore`.* TO 'jpipes'@'localhost'                   |

| GRANT EXECUTE ON `test`.`ShowIndexSelectivity` TO 'jpipes'@'localhost' |

+------------------------------------------------------------------------+

3 rows in set (0.00 sec)

You may notice a peculiarity in the results in Listing 15-2. The privileges for

jpipes@localhost on a global level completely negate the need for the SELECT privilege on

the ToyStore database. So, why do both lines appear? This is because MySQL does not remove

grant table entries just because a more encompassing privilege level has been granted to the

user. Keep this in mind when changing user privileges. If at some point, you loosen a user’s

restrictions by granting global privileges, and later revoke the global privileges, the database-

specific privileges will still exist.

Querying the Grant Tables

Another option for determining a user’s privileges involves querying the actual grant tables

(which are described in the next section). To see global permissions for jpipes@localhost,

query the user grant table, as Listing 15-3 demonstrates.

Listing 15-3. Querying the user Grant Table Directly

mysql> SELECT * FROM mysql.user

-> WHERE User = 'jpipes' AND Host = 'localhost' \G

*************************** 1. row ***************************

Host: localhost

User: jpipes

Password:

Select_priv: Y

Insert_priv: Y

Update_priv: Y

Delete_priv: Y

Create_priv: N

Drop_priv: N

Reload_priv: N

Shutdown_priv: N

Process_priv: N

File_priv: N


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Grant_priv: N

References_priv: N

Index_priv: N

Alter_priv: N

Show_db_priv: N

Super_priv: N

Create_tmp_table_priv: N

Lock_tables_priv: N

Execute_priv: N

Repl_slave_priv: N

Repl_client_priv: N

Create_view_priv: N

Show_view_priv: N

Create_routine_priv: N

Alter_routine_priv: N

Create_user_priv: N

ssl_type:

ssl_cipher:

x509_issuer:

x509_subject:

max_questions: 0

max_updates: 0

max_connections: 0

max_user_connections: 0

1 row in set (0.31 sec)

Here, you can see all privileges except the SELECT, INSERT, UPDATE, and DELETE privileges

are set to N, which makes sense; the first line from the previous output of Listing 15-2 shows

the global GRANT statement having these privileges enabled.

Querying each of the grant tables as in Listing 15-3 will produce similar output for each of

the privilege scope levels. The user and db tables store privilege information in separate fields

of type ENUM('Y','N'). The tables_priv, columns_priv, and procs_priv grant tables store privi-

lege information in a single SET() field containing a list of the available privileges. Listing 15-4

shows the output of a SELECT on the tables_priv table to illustrate this difference.

Listing 15-4. Querying the columns_priv Grant Table Directly

mysql> SELECT Db, Table_name, Table_priv FROM mysql.tables_priv

-> WHERE User = 'mkruck' AND Host = 'localhost';

+----------+------------+---------------+

| Db       | Table_name | Table_priv    |

+----------+------------+---------------+

| ToyStore | Customer   | Select,Insert |

+----------+------------+---------------+

1 row in set (0.00 sec)

Now that you’ve seen how to grant and revoke privileges, it’s important to understand

how MySQL actually applies and verifies those privileges.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

How MySQL Controls Access and Verifies Privileges

MySQL controls access to the database server through a two-step process. In the first step of

the process, MySQL identifies and authenticates the user connecting through a MySQL client.

The second part of the process entails determining what the authenticated user can do once

inside the system, based on that user’s privileges.

Figure 15-1 illustrates the flow of events in the MySQL access control and privilege verifi-

cation system. You can see how the different steps of the process are designed to ensure that

the requests issued by the client, including the actual connection request, are allowed. When

requests or connections do not meet all access criteria, MySQL returns an error code corre-

sponding to the reason for request refusal.

Step 1:

Access

Authentication

Step 2:

Permission

Verfiication

Client requests

connection

MySQL verifies

supplied

credentials

Credentials

valid

Client issues

statement

MySQL determines

permissions needed

for requested

statement

MySQL looks for

needed permission to

objects in grant tables

matching  the user/

host

All privileges

found

MySQL sends request

along to parser

Supplies:

[host]

[username]

[password]

MySQL validates the host,

user, and password by

querying the user grant

table

Credentials

not valid

MySQL refuses

connection

e.g., SELECT, INSERT,

ALTER TABLE, etc.

Some requests need multiple

permissions; for example, an ALTER TABLE

request requires permission for ALTER,

INSERT, and CREATE privileges for

the table

MySQL queries the db, tables_priv,

and columns_priv grant tables for

appropriate permissions

Privileges

not matched

MySQL refuses

request

w of events


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

■Note See http://dev.mysql.com/doc/mysql/en/Access_denied.html for an explanation of com-

mon reasons for access denied messages.

How MySQL Authenticates Users

MySQL uses a two-part label to identify the user issuing a connection request. This label is

composed of the username and the host values. The host value represents the machine from

which the connection originates. The username part of the label is the specific user connect-

ing from the host.

The user grant table stores information needed to authenticate incoming connections,

along with a set of global privileges tied to each entry in the table (discussed earlier in the chap-

ter). The three columns of the user grant table that are used in the connection authentication

decision are Host, User, and Password. The User column value can be either an actual username

(for example, joe_smith) or a blank string (' '). Wildcard matches can be used in the Host col-

umn. An underscore (_) character represents a single character, and a percent (%) represents any

number of characters. The Host column value can be in any of the following formats:

• Host (or domain) name: www.mycompany.com, %.mycompany.com

• Host IP address: 123.124.125.255, 123.124.125.%

• Local machine client: localhost, and on some Linux systems, localhost.localdomain

MySQL compares the username and host values of the connection with entries in the

user grant table in a special way. When the mysql.user table data is loaded into memory, it is

first sorted based on how specific the User and Host column values are. Because the Host col-

umn values can contain wildcard characters, and the User column can be blank (meaning any

user at the specified Host), some table entries will be more specific than others.

For example, Listing 15-5 shows some sample rows from the user grant table on a test

database server we’ve set up for the examples in this chapter.

Listing 15-5. The user Grant Table

mysql> SELECT User, Host FROM mysql.user;

+-----------+-------------------+

| User      | Host              |

+-----------+-------------------+

|           | %                 |

| mkruck    | %                 |

| jpipes    | %.example.com     |

| mkruck    | admin.example.com |

|           | localhost         |

| jpipes    | localhost         |

| mkruck    | localhost         |

| root      | localhost         |

| responder | mail.example.com  |

+-----------+-------------------+


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

When MySQL sorts this list according to specificity, it will be ordered by the most specific

Host value to the least specific. Since IP addresses or domain names are more specific than a

host specification that contains a wildcard, the actual order in which MySQL would see the

entries in Listing 15-5 would be as listed in Table 15-6.

Table 15-6. The user Table Results Ordered by Specificity of Username and Host Label

User

jpipes

jpipes

mkruck

mkruck

mkruck

responder

root

Host

localhost

%.example.com

localhost

admin.example.com

mail.example.com

localhost

localhost

%

%

%

If the label jpipes@groups.example.com were passed to the identification system, MySQL

would first search for all entries matching the supplied username or having a blank entry in

the User column. Then it would go down the returned list of entries, looking first for a Host

column value that matches the incoming tag. Four entries in the sample user grant table

match this username part of the identification label, as shown in Table 15-7.

Table 15-7. Possible Entries That Could Match Label jpipes@groups.example.com

User

jpipes

jpipes

Host

localhost

%.example.com

localhost

Of these four, the top row contains the most specific username and host combination.

However, the groups.example.com domain clearly does not match the Host column value

localhost. The next row, with the Host value of %.example.com matches our supplied domain,

and so this row is used in order to determine access and privileges to the system. If the Host

value did not match, the next row would be checked, and so on down the line.

We cover this sorting logic here because of the confusion some MySQL users experience

regarding why certain privileges have not been granted to them when executing queries. This

confusion can be tracked to a misunderstanding of which entry in the user grant table has

been loaded for their current connection. Often, if a number of entries have been made to the

user grant table with similar Host and User column values, it may not be clear which entry has

been loaded. If you are unsure about which entry has been loaded for a connection, use the

CURRENT_USER() function, as shown in Listing 15-6.


Listing 15-6. Using the CURRENT_USER() Function to Determine Active Entry

C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

mysql> SELECT CURRENT_USER();

+----------------+

| CURRENT_USER() |

+----------------+

| root@localhost |

+----------------+

1 row in set (0.00 sec)

DEFAULT CONNECTION PARAMETERS

Clients can connect to a MySQL server in numerous ways. Regardless of the client or API used to connect,

MySQL executes the same authentication procedures to authorize the incoming requests. Even so, it is possi-

ble through the use of option files, to configure clients to send a default host, username, and password along

with each connection. This is done by altering the MySQL configuration file (described in Chapter 14) and

inserting one or more of the following entries under the [client] configuration section:

• host=hostname

• user=username

• password=your_pass

Setting a default password for the MySQL client is not a secure practice, and should not be done on

anything but test or development servers that do not have any sensitive data.

Also be aware that, by default, MySQL accepts connections from anonymous users; that is, MySQL

allows connections that do not supply a username. Though the default access of this anonymous user is lim-

ited, and only the test database can be accessed, it is still a security threat, as discussed in Chapter 16.

How MySQL Verifies User Privileges

After MySQL has verified that the user connecting has access to the database server, the next

step in the access control process is to determine what, if anything, that user may do while

connected to the server. In order to determine if a user can issue a command, the privileges

at the different scope levels are checked from the broadest scope (global) to the finest scope

(column level). An additional grant table, mysql.host, is consulted in special circumstances.

Logically, MySQL follows this equation to determine if a user has appropriate privileges

to a database-specific object:

• Global privileges

• Or table privileges

• Or column privileges

• Or (database privileges and host privileges)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Take a look at Figure 15-2 to get a feel for how this logic is processed by the privilege veri-

fication system for a simple request. In Figure 15-2, let’s assume that the connection was

authenticated as jpipes@localhost, and sent the following request:

SELECT login, password FROM ToyStore.Customer WHERE ID=1;

MySQL would first look to see if an entry existed in the user grant table matching the supplied

user and host and having the SELECT privilege enabled (found in the select_priv column). If

the value of the SELECT privilege were 'Y', MySQL would stop the privilege verification process

and continue with the request’s execution. If the value of the SELECT privilege were 'N', MySQL

would continue down the grant table chain to the db table.

Client request received and

connection authorized

(see Figure 15-1)

MySQL determines

which privilege(s) and

scope are required

Required privilege: SELECT

Database: ToyStore

Table: Customer

Columns: login, password

Rows exists in user table for:

user.User='jpipes' AND

user.Host='localhost' AND

user.Select_priv='Y' ?

Yes

MySQL accepts

request

Assume query:

SELECT login, password

FROM ToyStore.Customer

WHERE customer_id=1

MySQL denies

request

No

MySQL accepts

request

Yes

'Y' ?

db.Select_priv =

Yes

Row exists for:

db.User='jpipes' AND

(db.Host='localhost' OR

db.Host=") AND

db.Db='ToyStore'?

No

No

No

Row exists in db table for:

db.User='jpipes' AND

db.Host='localhost' AND

db.Db='ToyStore' ?

No

Row exists in host table for:

host.Db='ToyStore' AND

host.Host='localhost' ?

MySQL accepts

request

Yes

Row exists in tables_priv table for:

tables_priv.User='jpipes' AND

tables_priv.Host='localhost' AND

tables_priv.Db='ToyStore' AND

FIND_IN_SET('SELECT',

tables_priv.table_priv)>0 ?

No

db.Select_priv = 'Y'

host.Select_priv = 'Y' ?

MySQL denies

request

No

Yes

AND

Yes

MySQL accepts

request

Two rows exists in columns_priv table for:

columns_priv.User='jpipes' AND

columns_priv.Host='localhost' AND

columns_priv.Db='ToyStore' AND

columns_priv.Table_name='Customer' AND

columns_priv.Column_name IN ('login','password')

AND

FIND_IN_SET('SELECT',

columns_priv.column_priv)>0

Yes

No

MySQL accepts

request

MySQL denies

request

Figure 15-2. Privilege verification detailed flow of events


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

MySQL looks for an entry in the db table matching db.User='jpipes' AND ➥

db.Host='localhost' AND db.Database_name='ToyStore'. If a row exists in mysql.db for

this combination, the db.Select_priv column is checked. If it found a 'Y' value for the

db.Select_priv column, MySQL would accept the request. If a row did not exist in mysql.db

matching db.User='jpipes' AND db.Host='localhost' AND db.Database_name='ToyStore'

but a row that matched db.User='jpipes' AND db.Host='' AND db.Database_name='ToyStore'

did exist, then the mysql.host grant table is queried.

If no rows in mysql.host match host.Host='localhost' AND host.Db='ToyStore',

MySQL denies the request. If a row in mysql.host does match host.Host='localhost' AND ➥

host.Db='ToyStore', then the Select_priv column in both rows in mysql.db and mysql.host

are checked for a 'Y' value. If this is the case, MySQL accepts the request. (We’ll discuss the

relationship between the db and host grant tables in just a moment.) If not, MySQL continues

to the tables_priv grant table.

If MySQL has reached the tables_priv grant table, it determines if there is a row in

the table that matches the condition WHERE User='jpipes' AND Host='localhost' AND

Db='ToyStore' AND Table_name='Customer' AND FIND_IN_SET('SELECT', Table_priv)>0.2

If such a row exists, MySQL accepts the request. If not, it repeats a similar process in the

columns_priv grant table. If MySQL does not find rows in the columns_priv table for the

requested columns of the SELECT statement, MySQL denies the request.

The Purpose of the host Grant Table

The host grant table stores entries that are used when the db grant table does not have ade-

quate information to process the privilege verification request (see Figure 15-2). Neither the

GRANT nor REVOKE statements affect entries in mysql.host. Entries must be added and removed

manually.

The host grant table has an almost identical schema to the db grant table, except it does

not have a User column. When a statement request is evaluated by the access control system,

and it comes to the database grant level (meaning the user’s global privileges were insufficient

to grant the request and the object requiring privileges is of a database scope level or below),

the access control system checks to see if there is an entry in mysql.db for the supplied user. If

one is found, and the Host column value is blank (not '%', which means any database) then

mysql.host is consulted for further information. If an entry is found in mysql.host for the sup-

plied Host value in the identification label, then the privileges contained in both mysql.db and

mysql.host are combined (with a logical AND expression) to determine if the request should be

granted.

So, why would you even bother using the host table? That’s a good question. Most data-

base administrators never even touch it. Many don’t even know it exists, and if they do, they

don’t know why it’s there. The primary reason that mysql.host was added to the grant table

mix was to provide database administrators the ability to grant or deny access requests com-

ing from certain hosts or domains, regardless of the username. Remember that the MySQL

access control system is not denial-based. It uses an OR-based system to search for any granted

level of needed privilege, instead of searching first for the explicit denial of that privilege.

2. MySQL doesn’t actually use the FIND_IN_SET() function, but rather does a bitwise & operation on the

privileges loaded into memory for the queried user. We use the FIND_IN_SET() function here to

demonstrate the concept.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

However, there are times when it is necessary to create what are known as stop lists, or lists

of items to which access specifically is denied. mysql.host can be used to create just such lists

for domains, regardless of the user part of the identification label. Let’s say we have three server

hosts in our network: sales.example.com, intranet.example.com, and public.example.com. Of

these, the only server that we don’t want to have access to any databases is public.example.com,

as it poses a security risk. So, we run the following code:

mysql> INSERT INTO mysql.host SET Host='public.example.com', Db='%';

mysql> INSERT INTO mysql.host SET Host='%.example.com', Db='%'

-> , Select_priv='Y', Insert_priv='Y', Update_priv='Y', Delete_priv='Y'

-> , Create_priv='Y', Drop_priv='Y',  Index_priv='Y',Alter_priv='Y'

-> , Create_tmp_table_priv='Y';

This allows us to put a stop list together (currently containing only one entry for the

public.example.com host) and deny access to connections originating from that server. Using

the % wildcard this way in the Db column and in the Host column means that the access control

system will always find a match in the host table for any internal example.com server, regard-

less of the request. Since any privilege columns we leave out in the INSERT statement will

default to 'N', we can rest assured that no unintended privileges have been granted.

Remember, however, that the MySQL access control system will use privileges in the

global mysql.user entry first in the privilege verification process. Therefore, if the account

some_user@public.example.com had privileges set to 'Y' at the global level, that entry would

override the host table entries.

Managing User Accounts from the Command Line

You can use SQL commands to add and remove user accounts, including several GRANT clauses

to place restrictions on accounts. Here, we’ll look at those commands. In the next section, we’ll

cover using the MySQL Administrator GUI tool to manage user accounts.

Adding User Accounts

As mentioned earlier, you can use the GRANT command to create new user accounts. Any time

you issue a GRANT statement for a username and host combination that does not currently

exist in the mysql.user table, a new user account is created. A row is inserted in the mysql.user

table for the username and host specified in your GRANT statement. If the scope of the privi-

leges granted in the statement is global, the user account’s global permissions will be set in

this new row and no other tables will receive an entry. If the scope of privileges was below the

global scope, a new entry will be inserted in the grant table corresponding to the privilege

level.

The IDENTIFIED BY clause of the GRANT statement allows you to specify a password for the

user account, like so:

GRANT SELECT ON ToyStore.*

TO 'some_user'@'localhost' IDENTIFIED BY 'my_password';


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Another way to add new user accounts is to insert rows directly into the mysql.user table.

This is a convenient way to add multiple users at once, however we don’t recommend this

method for just the odd user or two. To add only a few users, stick to the GRANT command. If

you do insert directly into mysql.user, note the password supplied in the IDENTIFIED BY clause

is actually encrypted in the mysql.user grant table. If you add the row to the user table directly,

you must use the PASSWORD() function to encrypt the password:

INSERT INTO mysql.user  SET Host='localhost', User='some_user',

Password=PASSWORD('my_password'), Select_priv='Y';

Otherwise, the connecting user would not be able to access the server, as the supplied pass-

word would be encrypted and compared to the (plain-text) Password column value in the user

table.

Starting in MySQL 5.0.2, you can also add users with no privileges by using the CREATE ➥

USER command. The following two statements are identical in function:

CREATE USER 'some_user'@'localhost' IDENTIFIED BY 'my_password';

GRANT USAGE ON *.* TO 'some_user'@'localhost' IDENTIFIED BY 'my_password';

Restricting User Accounts

In addition to the user account’s global privileges, the mysql.user grant table also houses

a number of additional fields that can aid you as a database administrator in restricting

the account’s use of the database server. Starting with version 4.0.2, MySQL provides three

fields—max_questions, max_updates, and max_connections—which allow you to limit the

interaction a particular account has with the server. Before 4.0.2, all you could do was set

the max_connections configuration variable to limit the number of connections made by a

single user account, meaning you couldn’t vary the setting per user. Now, you have much

more flexibility in how you handle resource usage.

You can use the following to restrict user accounts:

• WITH MAX_QUERIES_PER_HOUR n, where n is the number of queries the user may issue,

limits the number of queries a user may issue against the server in one hour.

• WITH MAX_UPDATES_PER_HOUR n changes the number of update requests the user may

issue.

• WITH MAX_CONNECTIONS_PER_HOUR n changes the number of times a user may log in to

the database server in a single hour.

• MAX_USER_CONNECTIONS, available in MySQL 5.0.3 and later, differs from the

MAX_CONNECTIONS_PER_HOUR setting in that it is not time limited and refers to the

total amount of connections simultaneously made by the user account. Use this option

if you have a user that consistently opens too many user connections to the server,

leaving many of them idle or sleeping.

One good use of the USAGE privilege is in changing these variables without affecting any

other privileges. Listing 15-7 demonstrates changing all three of these variables, as well as a

direct query on mysql.user to show the change.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Listing 15-7. Using the USAGE Privilege to Change Global User Restriction Variables

mysql> GRANT USAGE ON *.* TO 'jpipes'@'localhost'

-> WITH MAX_QUERIES_PER_HOUR 1000

-> MAX_UPDATES_PER_HOUR 1000

-> MAX_CONNECTIONS_PER_HOUR 50;

Query OK, 0 rows affected (0.00 sec)

mysql> SELECT max_questions, max_updates, max_connections

-> FROM mysql.user

-> WHERE User='jpipes' AND Host='localhost';

+---------------+-------------+-----------------+

| max_questions | max_updates | max_connections |

+---------------+-------------+-----------------+

|          1000 |        1000 |              50 |

+---------------+-------------+-----------------+

1 row in set (0.01 sec)

Using a combination of these resource limiters, you can achieve a fine level of control

over the resource usage of user accounts. They are useful when you have a high-traffic, multi-

user database server, as is typical in shared hosting environments, and you want to ensure

that the database server shares its available resources fairly.

Removing Accounts

If you are using a MySQL version 4.1.1 or later, you can remove a user account with the

DROP USER command:

DROP USER 'some_user'@'%';

remove an account:

In versions prior to MySQL 4.1.1, you need to issue the following two statements to

DELETE FROM mysql.user WHERE user='some_user' AND Host='%';

FLUSH PRIVILEGES;

Here, we’re manually deleting the entry, and issuing FLUSH PRIVILEGES to ensure that changes

are reflected in the in-memory copy of the grant tables, as discussed in the next section.

Effecting Account Changes

As stated earlier, MySQL keeps privilege information in-memory from when the server is started.

When making changes to privileges, you should be aware of when the in-memory copy of the

grant tables contains the most up-to-date privilege information and when it does not.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

When In-Memory Tables Are Updated

In all of the following situations, the in-memory grant tables contain the most up-to-date

privilege and access information:

• After issuing a GRANT, REVOKE, CREATE USER, or DROP USER statement

• After issuing the FLUSH PRIVILEGES statement

• Immediately after the server starts and before any requests are made to the mysql

database

If, however, you alter the mysql grant tables directly, as is necessary when altering

mysql.host or deleting a user account before version 4.1.1 of MySQL, the in-memory copies

of the privilege tables will not contain the most current information, and you should immedi-

ately issue a FLUSH PRIVILEGES statement to make the changes current.

When Current Connection Requests Use the New Privileges

If you make high-priority changes to the privilege system—for instance, because a security

violation was detected and you want to take immediate action—you will want to know exactly

when MySQL will use the privileges you have changed.

When you change a user’s database-level access and privileges (those stored in mysql.db),

the new privileges will take effect after the next issue of a USE db_name statement. While this is

okay for most web-based systems, where a new USE statement is issued on each HTTP request,

this can be more problematic if the offending user is logged in to a persistent session (a con-

sole or client/server application session). If the security risk is high, you may be forced to KILL

the offending user’s process (identified using the SHOW FULL PROCESSLIST command) in order

to ensure a new USE db_name request is generated.

When you make changes to the user’s global privileges, as well as passwords, the next

time the correct privileges will be read is when a new connection request is received with the

same identification tag. Again, it may be necessary in some situations to identify the offending

process IDs and KILL the processes to effectively “log out” the offending user.

When you change a user’s table or column-level privileges, the new privileges will take

effect on the very next request to the server, so, in general, you do not need to worry about

enforcing privilege changes at that level.

Using the MySQL Administrator GUI Tool

MySQL AB released the GUI tools MySQL Administrator and MySQL Query Browser in different

stages over 2004. New database administrators will find the GUI tools more intuitive than their

command-line counterparts. In some cases, particularly for user management tasks, the GUI

can reduce a number of fairly repetitive SQL statements down to a few clicks of the mouse.

Here, we’ll discuss how to use the MySQL Administrator tool to manage user accounts.

Your first step is to set up your connection to the server. Then you can navigate to the User

Administration section and use those tools to add and remove accounts, as well as specify

user privileges.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

■Note To administer the user accounts, you must first connect to the server as a user with GRANT OPTION

privileges (database administrator). Otherwise, all the options detailed here are unavailable (grayed-out) to you.

Connecting to the Server

When you start up the MySQL Administrator program, you are greeted with the dialog box

shown in Figure 15-3.

■Note The figures in this section come from a computer running Fedora Core 3 Linux using the KDE

desktop environment. Although you may notice slight variations in the MySQL Administrator functionality,

depending on the operating system you use, the interface runs in a very similar fashion on Windows and

Macintosh operating systems. See http://dev.mysql.com/downloads/ for the version for your system.

Figure 15-3. The MySQL Administrator common connection dialog box

You can enter your information in to the text boxes provided for server hostname, user-

name, and password. However, since you’ll presumably be using this tool more than once, you

can set up a stored connection so you don’t need to repeatedly enter this information. To do so,

select Open Connection Editor in the Stored Connection drop-down box. This will bring up the

Preferences dialog box, shown in Figure 15-4.


![R2859](images/R2859)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-4. The MySQL Administrator Connection Preferences dialog box

Click the Add Connection button in the lower-left corner, and then fill in the appropriate

information to the space in the right of the dialog box. When you’re finished, click Apply

Changes, then Close. You will be taken back to the Connection dialog box, where you can

now select the new stored connection you just saved. Enter your password and click Connect.

Navigating User Administration

After you connect to the server, you will find yourself in the MySQL Administrator interface,

with a number of options in the left pane, as shown in Figure 15-5.

■Tip If you’re a Linux user, you can avoid needing to retype your passwords every time you enter MySQL

Administrator or MySQL Query Browser. In either application, select File ➤ Preferences, and then click Gen-

eral Options tab and select Store Connection Passwords. Optionally, you can obscure the password storage

by selecting Obscured in the Storage Method drop-down list.


![R2866](images/R2866)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-5. The MySQL Administrator console

Click the User Administration option to go to the User Administration section of MySQL

Administrator, as shown in Figure 15-6.

As you can see, in the bottom-left pane of the window is a tree-view-like User Accounts

list. The server’s user accounts are listed by username. Clicking the username will display zero,

one, or more hostnames preceded by an @ sign, depending on how many entries in mysql.user

have a User column value matching the username. If no hosts are listed, it means that the only

entry in mysql.user with that username is one where the Host column value is '%'.

In Figure 15-6, notice that while we have selected jpipes@% (the top-level of the node for

jpipes), the Schema Privileges and Resource Limits tabs in the main window area are grayed-out.

This is because there actually is no record in mysql.user for jpipes@%. There is, however, a record

in mysql.user for jpipes@localhost, which is why, as demonstrated in Figure 15-7, the Schema

Privileges and Resource Limits tabs are active and available when we select that part of the tree.


![R2873](images/R2873)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-6. The User Administration section of MySQL Administrator

Figure 15-7. Selecting a user account with a matching entry in mysql.user


![R2881](images/R2881)


![R2880](images/R2880)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Adding a New User Account

To add a new user account, right-click in the User Accounts section and select New User

(Add New User in the Windows version) from the context menu, or optionally, click the New

User button at the bottom of the window. This adds a new_user entry in the User Accounts list.

In the right pane, fill in the fields in the Login Information section, as shown in Figure 15-8.

Filling in the Additional Information area is strictly optional.3

Figure 15-8. Filling in new user information

When you are finished filling in the basic information, select the Schema Privileges tab. In

this tab, any privileges that you move from the rightmost Available Privileges list to the middle

Assigned Privileges list will be granted for the schema (database) that you have selected in the

leftmost list, entitled Schema. In Figure 15-9, you can see that for this new user, we have

granted the SELECT, INSERT, UPDATE, and DELETE privileges for the ToyStore schema.

If you click the Resource Limits tab, you can set the maximum connections, queries, and

updates values for this user, as shown in Figure 15-10.

3.

Information you enter in the Additional Information is stored in the mysql.user_info system table.


![R2888](images/R2888)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-9. Granting the new user privileges on the ToyStore schema

Figure 15-10. Setting the new user’s resource limitations


![R2896](images/R2896)


![R2895](images/R2895)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

When you have finished making your changes, click the Apply Changes button. Your user

will be added to the user grant table with the Host column value of '%'. Usually, this is not

what you really want, since it is better to have a more specific entry for the Host column. To

create an entry in mysql.user with a more specific Host value, right-click the username in the

User Accounts area and select Add Host. In the Add Host dialog box, shown in Figure 15-11,

select the Hostname or IP option and type in your desired domain or host address. Click OK,

and you will see an additional node under the new username in the User Accounts area.

Figure 15-11. The Add Host dialog box

Selecting the new node will change the right content area to display the entry for the

node.

Viewing and Editing User Privileges

Have you noticed that you haven’t seen a way to change global or table-level privileges? The

default behavior of MySQL Administrator is to not show these privilege levels. To turn them

on, select File ➤ Preferences, and then click the Administrator icon. Under User Administra-

tion, check the “Show global privilege editor” and “Show table/column privilege editor”

options, as shown in Figure 15-12. Click the Apply Changes button, and then click Close.

You’ll now notice two additional tabs when you click a user account. Selecting the Global

Privileges tab, shown in Figure 15-13, gives you the ability to assign permissions on a global

level.

■Caution Remember that global privileges override all others. Be careful what you assign through MySQL

Administrator.


![R2903](images/R2903)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-12. Turning on the global privilege editor

Figure 15-13. The Global Privileges editor in MySQL Administrator


![R2911](images/R2911)


![R2910](images/R2910)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Similarly, you can change table and column privileges by selecting the Table/Column

Privileges tab, as shown in Figure 15-14. You can select a table or column by clicking the

appropriate schema in the left pane and drilling down to the object of interest. The Available

Privileges list displays the privileges available for each object you click.

Figure 15-14. The Table/Column Privileges editor in MySQL Administrator

Removing an Account

MySQL Administrator makes it (a bit too) easy to remove users (and all related user/host

mysql.user records). Simply right-click the user account you wish to remove and select one of

the following options:

• Remove Host: Removing the host removes that user/host entry and all associated privi-

leges. If there is only one user/host entry, MySQL Administrator will warn you that you

will essentially be removing the user account entirely, since no remaining mysql.user

entries will be available.

• Remove User: Removing the user will delete all record of the user and any host combi-

nations it might have. Obviously, you should use this option with caution.

MySQL Administrator asks you to confirm your impending action, as shown in Figure 15-15.


![R2918](images/R2918)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Figure 15-15. The Remove Account confirmation dialog box

For more information about using MySQL Administrator, see http://dev.mysql.com/doc/

administrator/en/mysql-administrator-introduction.html.

Thinking in Terms of User Roles

Up until now, we’ve been speaking about the access control and privilege verification systems

strictly in terms of user accounts. However, many other database vendors have implemented

an alternate, more complex, account management subsystem. The primary difference

between MySQL and other popular vendors is that MySQL does not have a role-based

implementation.4

Sticking to their original goals for ease of use and simplicity, the MySQL developers have

chosen not to overcomplicate the access control process by adding new layers of complexity

to the grant system. It is unlikely that you will see a role-based implementation in the near

future. However, that does not mean you should disregard the notion of account management

by roles. The concept is just as important, whether MySQL implements the roles systemati-

cally or leaves the implementation to your own devices.

Many of you who are systems administrators are already intimate with group-based

account management. All major server operating systems provide a mechanism to place user

accounts into one or more usually function-oriented groups. By function-oriented, we mean

that the group’s members generally share similar work goals: server administrators, power

users, regular users, server daemons, and so on. It is often helpful to think of the user accounts

you manage for a MySQL database server in similar terms. Users of the database server almost

always can be categorized into groups based on the roles they play in the overall scheme of the

database server’s daily activity.

More than likely, if you already manage a MySQL database server, you, perhaps unknow-

ingly, think in terms of role-based management. When you add a new user account, you find

out what the user will need to accomplish on a daily basis and which databases the account

will need to access. In doing so, you are effectively determining the role that the user will play

in the system.

The primary advantage to role-based account management is that user accounts and

privileges are controlled in a consistent manner. If you administer database servers with more

than just a few users, it is important to have a written policy detailing the roles having access

to the system. This written policy provides a reference for administrators to use when adding,

removing, or changing user accounts.

4. MySQL’s MaxDB product already has a role-based account management system. If you feel MySQL’s

normal user access and privilege verification system will not meet the needs of your organization,

head over to http://dev.mysql.com/doc/maxdb/en/default.htm to check out how MaxDB implements

its role-based system through an extended SQL variant.


![R2925](images/R2925)


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

As you start down the road to role-based management, begin with a list of the roles that

can be played by database users in your system. For this section, we will return to our toy store

sample schema. After a few minutes of thinking about the different types of users that will

have access to the database server, we come up with the following list:

• Database Administrators

• Database Users

The Database Administrators group (role) is fairly self-explanatory. For our Database

Users role, we can further break down the list to the following:

• Super Users: Users who have access to all databases and can do all simple table-related

tasks, as well as have full rights on a database named tmp.

• Regular Users: Users who have access to specified databases and may do simple table-

related tasks.

bases (schema).

• Designers: Users who have all database-related access and privileges on some data-

We want to ensure that users belonging to each role (and sub-role) have only the privi-

leges that they need to do their activities, and no more. Also, we’re assuming here that Super

Users have some general database knowledge and know how to use MySQL, so we’ve given

them a database (tmp) to use for their own measures. Thus, we put together a matrix to show

which global and database level privileges member users should be granted as defaults, as

shown in Table 15-8. This kind of table serves as an important written policy to guide database

administrators for large projects. This document should be maintained as changes to the

account management system are implemented.

Table 15-8. Role-Privilege Matrix for the Toy Store Database Server

Global Privileges

Database-Level Privileges

N/A5

NONE

Role

DB Admins

DB Users

DB Users: Super Users

DB Users: Regular Users

DB Users: Designers

ALL

NONE

NONE

NONE

NONE

SELECT, INSERT, UPDATE, DELETE on all schema;

ALL on schema called tmp

SELECT, INSERT, UPDATE, DELETE on select schema

ALL on select schema

Now, we have a working strategy for setting defaults for our system’s users based on their

roles. You would use a list like the one in Table 15-8 as a reference when making account man-

agement changes. Instead of remembering the exact privileges a specific user account should

be granted, you need to know only which role a new user will play.

Finally, you might streamline the process of account management further, by encapsulat-

ing the account management into stored procedures or shell scripts that add appropriate

permissions based on these well-defined roles.

5. Remember that global privileges override database-level privileges.


C H A P T E R   1 5   ■ U S E R  A D M I N I S T R AT I O N

Practical Guidelines for User Administration

In this chapter, we’ve covered a number of topics related to user account management. Here,

is a simple list of strategies we consider to be best practices:

• Grant as few privileges as is absolutely necessary for users to accomplish their daily

activities.

• Avoid using WITH GRANT OPTION.

• Avoid issuing any global privileges to anyone but the topmost database administrator.6

• Keep privileges as simple as possible. If you don’t need table or column-level privileges,

don’t use them. This only slows down the access control system and overcomplicates

your setup.

• Think in terms of role-based management. This will allow you to more effectively

manage large groups of users by grouping them by like activities.

• Use scripts to consolidate role-based management into a secure, well-organized

environment.

Summary

In this chapter, we’ve covered some essentials of MySQL user administration, as well as some

advanced aspects. To review, we started by explaining MySQL privileges and their scopes.

Then we took an in-depth look at how the two-step access control and privilege verification

system works. You learned how the decision to allow or deny a certain request is made, and

stepped through some common misunderstandings regarding that decision-making process.

Next, we reviewed how to add users into the system, modify permissions for those users,

and eventually remove them. Along the way, we pointed out some occasional “gotchas,” and

walked you through the more unique, but nonetheless important, scenarios of limiting a

user’s resources and setting up a host stop list using the mysql.host grant table.

We then looked at how to manage users using the MySQL Administrator GUI, walking

through setting up a connection, and working in the User Administrator section.

Finally, we switched gears a bit and talked about the major difference between MySQL’s

user administration implementation and other database vendors: MySQL’s lack of role-based

account management. We demonstrated some techniques for thinking in terms of role-based

management and finished up with some guidelines to follow as you administer users in your

databases.

6. An exception to this would be specific roles such as a backup job user account that requires global

RELOAD, LOCK TABLES, and SELECT privileges.


C H A P T E R   1 6

■ ■ ■

Security

You recently released a new piece of functionality to your users and are starting to see the data

moving in and out of the database with speed and efficiency. You’re happily watching the quick

response of your system and thinking that your work is done. Yet, while you enjoy the compli-

ments of management and co-workers, you have this nagging feeling about the data. It’s nothing

major, just a twinge of uneasiness about the new functionality and the sensitive nature of some

of the data. Then you’re reminded of a conversation you had a month back with a customer who

needed to get some summary information from many tables in the database. Because you didn’t

have time to grant SELECT at the table levels for all 18 tables he needed to access, you granted him

the privilege to SELECT at the database level. This gave him the ability to select from any table in

the database. Now, you’ve added another 5 tables with more sensitive data that shouldn’t be avail-

able to this customer. You rush back to your desk and quickly revoke his SELECT privileges and

grant SELECT on the original 18 tables, hoping that the sensitive data hasn’t been exposed.

End users—whether employees, customers, students, clients, or any other number of

users—rely on their data being available when they need it, accurate in that it has been stored

correctly and hasn’t been tampered with, and protected in the sense that only the right people

will be able to see their data. A compromise of data in any of these ways leads to lack of trust

from those who store and use data in your system. In addition, a flaw in the protection of data

can lead to long interruptions in business processes, and wasted employee time and company

funds while data integrity issues are resolved.

In writing a chapter on database security, we don’t want to just provide a seemingly end-

less list of random thoughts on how to secure your system. We don’t want to shake our finger

at you, delivering yet another security lecture. Unfortunately, the list of things to consider

when securing your database is hard to avoid, and we’ll end up there eventually. But we want

to spend some time focusing on the reasons behind the emphasis on using secure practices.

Therefore, we’ll begin by addressing some broad questions about security. Then we’ll look at

some critical items related to MySQL security, followed by a scenario with specifics on how

you might implement a security plan. Finally, we’ll address the different parts of a system that

affect the database and offer suggestions for securing those parts.

In this chapter, we’ll cover the following topics:

• Common reasons for security problems

• Biggest security threats

• Security policy and plan implementation

• A MySQL security quick list

• An example of implementing a security plan

• Security for each part of a system


C H A P T E R   1 6   ■ S E C U R I T Y

Understanding Security Requirements

Why are we so interested in security practices? To answer that question, we need to address

three other questions.

Why Aren’t We Secure?

These days, we are constantly warned about computer exploits and ways to protect against

them. Despite this barrage of information, we still learn of, or experience firsthand, security

breaches of various types. Why does this continue to happen?

In relation to databases and database applications, we think the following are some of the

common reasons for security problems:

Time constraints: Time is a major factor in the attention given to security. Many managers

will be pushing for the next piece of functionality before the current one is complete,

leaving developers and administrators no time to give attention to making sure things

are locked down.

Lack of security knowledge: Developers and administrators might not know enough about

security in general or lack awareness of the specifics of database access controls. Perhaps

in giving someone access based on an IP address range, the wildcard matching wasn’t

quite right, and access was granted to a much wider range of machines.

Lack of information about data: It might not be a lack of understanding of security

practices that leaves data exposed, but lack of knowledge about the data itself. Suppose

your database server is managed by a third party in an off-site data center. If the system

administrator of the server isn’t aware of the sensitive nature of your data, he may make

a decision about security that puts your data at risk. This may be as simple as copying a

database backup to a remote machine over a publicly available network.

Communication issues: Lack of communication between application developers, data-

base administrators, and data owners can lead to poor security practices. The database

may be heavily guarded, but in most cases, a privileged account will be used by the appli-

cation to view and change data. If the application programmer doesn’t understand the

sensitive nature of the data, it may be exposed to unauthorized access, regardless of good

security at the database level.

Habits are hard to break: If you’ve done something a certain way for years, it can be hard

to change that behavior. If your team has always granted SELECT privileges at the database

level because it’s simpler than figuring out which specific tables are required, it may be

difficult to change the process. Even if you get team members together and explain a new

policy and its significance, you may find that people subconsciously revert to the mecha-

nism they know best. This also applies to a habit of not giving security proper attention.

Acceptance of risk: Willingness to take risks can also be another reason for lack of good

security. If a database administrator thinks there is little chance someone will find and

gain access to the database, or be interested in toying with the data, she may not bother

expending any effort on security. After all, what are the chances that someone will find

the machine on the network?


C H A P T E R   1 6   ■ S E C U R I T Y

■Caution Don’t be fooled by a statement like, “Our site is completely public, so there’s no need to protect

the database.” Securing a database isn’t just about hiding data. It’s about preventing unauthorized changes

in the data, as well as keeping the data available. It’s also about protecting the server from compromise

through the database. In the end, there aren’t many operators of databases-driven systems that don’t

care if their system is down.

It is important not only to acknowledge the fact that you might not be practicing good

security, but also to determine how to resolve the deficiency. If lack of knowledge or under-

standing about security is one reason you have holes in your database, then do some more

reading (starting with the rest of this chapter), join appropriate mailing lists, and/or attend

a security conference (or a database conference with a security track). If the major barrier is

time, tell your manager that there may be some security issues with the database that could

lead to disaster and you would like a few days to research and resolve them.

Security incidents are never pleasant and can lead to drastic things like termination of

employment. Whatever the issue, find a way to get through it so you can move forward with a

clear conscience about your system, and keep your job, too.

Where’s the Security Threat?

In planning your security, you want to have an idea of where the threat is coming from. In

most cases, the biggest security threat to your organization is not the hacker outside your

organization mounting a brute-force attack on your database. More often, the threat is the

person sitting two offices down, or someone who already has an account in your database.

Consider the opening example of this chapter, where an existing customer had permissions

that were inadvertently granted.

Of course, you want to protect your system against outside intruders, but employees,

clients, consultants, and others who already have access to your data pose the biggest threat.

This is because the chance of them having misconfigured permissions and getting access to

unauthorized data is more likely than a stranger getting all the way through the human and

technological barriers around your system. In addition, people who understand the organiza-

tion and technology are more likely to be able to circumvent barriers to get access to the data.

Consider the case of a consultant who has been working with the database administrator

on a number of projects. The database administrator probably wouldn’t question a request

from that consultant to get access to a particular table. Database administrators are likely

to be less rigorous about verifying a request for access if it comes from someone who is in

the office and working with other parts of the system. If each request for access must go up

against a formal security policy and plan, there is less chance that inappropriate access will

be granted, even if it’s an internal request.

What Does It Mean to Be Secure?

With all that’s being written and said about security, you might think that securing your data-

base is just a matter of going through a list of predefined steps to lock down your database.

Yes, you can find a lot of information about securing database systems, but all systems are not

the same. Your system presents a unique set of variables. What does it mean to be secure?


C H A P T E R   1 6   ■ S E C U R I T Y

That’s not an easy question to answer, and one that has created an industry of security profes-

sionals who are passionately working to determine what and how to secure systems and the

data that lives within them.

To be clear, when we say that we want to secure a database, we’re generally referring to

controlling access to data. This applies to the ability to see, change, and remove the system’s

data. We might also lump into that the requirement that the database be available; that is, we

would like to prevent the intentional or accidental shutdown of the database or the server

where it runs.

Building a Security Plan

As we’ve hinted, protecting your system isn’t about just following a set of prescribed steps from a

security how-to guide. You need to develop security policies to define why different pieces of data

need to be protected and what parts of the system should be available to users. This can be a

time-consuming and challenging process. Sometimes, just making sure you have all the right

people involved in the conversation to define the security requirements can be a challenge.

Defining security policies warrants a thorough process of identifying all the stakeholders

of the data and bringing them together to define the rules of viewing, changing, and removing

data from the system. Ideally, this process is well documented and results in readily available

documentation, a mapping between user roles and database permissions, and a set of tools

for managing the defined roles and permissions. You should also include access beyond the

database access rules, such as who can have a shell account on the machine and access the

data and log files.

The policy definition will likely require several iterations, allowing stakeholders to review

the policy and provide feedback over a period of time. It’s important to at least have the decision

makers provide input into how you implement access control to the data in your database.

Don’t plan on creating a timeless masterpiece; the policy document should be revisited

regularly, particularly when a security breach has occurred, changes have been made in the

data structure, or a new piece of functionality has been added.

Not only can it be difficult to get everyone together to define all your data and the meaning

of its relationships, you may have the responsibility of educating policy makers, developers, and

users of the data about the importance of knowing the data and the rules of how it should be

protected. That can be difficult, because new issues involving data access and restriction arise

every day, and the rules are changing as data and data aggregation continue to move our society

in new directions.

The implementation of a security policy is your security plan. The security plan contains

the action to support the policy. The complexity of your security plan will have a lot to do with

the complexity of your security policy, database, data, application, and system. While there

are security issues to consider with all databases, you will find that the requirements of one

system are more demanding and require more planning and attention than you devote to

another. Some of this is tied to the sensitive nature of the data. The security implementation

for a database that stores credit card information or student grades requires more scrutiny

than a database filled with a list of recommended novels.

Implementing and enforcing a security policy can be a daunting task. Going through the

work to define who should have access to what and how data should be protected significantly

eases the task. With a policy, the implementation is about understanding how your database

access control lists work and creating the appropriate access rules.


C H A P T E R   1 6   ■ S E C U R I T Y

■Note A big part of securing the data is being able to properly manage the access control lists for users

who are looking at the data. Refer to Chapter 15 for details on managing user permissions to control user

access.

To help you develop a security plan for your particular requirement, Table 16-1 provides a

list of potential sections in a security document, with explanations of what might go into the

section.

Table 16-1. Potential Security Policy Sections

Section

Index

Description

Overview of sections in your document. Provides readers with a

summary of the sections addressed in the policy and easy access for

referencing sections.

Organizational Policy

Summary of your organization’s security policy, specifically how it

relates to the database.

Physical Security

Operating System

MySQL Installation

Applications

Account Management

Security Audit

Information about where database machines are stored, how access is

controlled, and what groups have access to the servers. Also describes

who is responsible for granting access for specific parts of the database.

Overview of operating system procedures as they relate to the database.

Includes information about who has access to the server.

Details about how MySQL is installed and configured. Defines where

data files are stored, what configuration options are specified, and

whether networking is enabled.

Information about how applications interact with the database. Details

who authorizes accounts and what permissions are associated with

different applications. Also provides information about communication

protocols.

Definition of permission groups (based on roles, departments, or other

groupings). Includes information about what permission groups exist,

who grants access to accounts and assigns user IDs, what types of

permissions are granted for different groups, who determines the

access level, and how and when permissions are revoked.

Details about how often a security audit is suggested for security,

including physical, operating system, database configuration, and

accounts.

■Tip The SANS Institute has a Security Policy Project geared toward helping organizations and individuals

quickly develop security policies. Sample policies can be downloaded from http://www.sans.org/

resources/policies/. Additionally, numerous organizations offer prebuilt security policies, and even

a selection of books to help you work through the process.


C H A P T E R   1 6   ■ S E C U R I T Y

Using Security Incidents

While we don’t wish security problems on anyone, an event that usually triggers a careful look

and improved commitment to security is a security incident. This can be anything from suspi-

cious activity on the server to unexplained data changes. Even if the problem is resolved with

a logical explanation that doesn’t end up being related to a security issue, security awareness

is heightened.

Use the security breach as a time to create or update your security policy and plan, and to

reinforce with employees the importance of following the plan. Make it clear that if the plan is

followed, the recently experienced security incident will not happen again.

As a part of your security plan, create a set of steps to go through when a security breach

is suspected or detected. Determine how the issue should be escalated and who should be

involved in clearing up the issue. Here is an example of a set of steps to take when a security

breach is suspected or detected:

1. Alert team members.

2. Conduct technical research to explain or support suspicions.

3. Alert management. Provide technical support to claims.

4. Get management input on action.

5. Take action(s):

• Security tightened

• Permissions revoked

• Compromised database restored from backup

• Appropriate action taken against violating person

• Alert data stakeholders and users

Obviously, the reaction and response should be adjusted accordingly, depending on the

sensitivity of the data.

Keeping Good Documentation

Maintaining good documentation on your security policy and plan is key to keeping users’

access in check. This documentation should be actively updated as changes are made in your

database or application.

If you’re just getting started, a core piece of your security plan should be the development

of a table with mapping between user roles and permissions in the database. Table 16-2

includes a few sample records from a permissions mapping document from an online store.


C H A P T E R   1 6   ■ S E C U R I T Y

Table 16-2. Sample Permissions Mapping Document

User/Group

Database

Table

Permission

Customer Reps

Notes: Customer representatives use and maintain the customer table.

customer

shop

SELECT, UPDATE, INSERT, DELETE

web_user

Notes: The web_user is an anonymous account used in the web application to display product

information.

product

SELECT

shop

web_administrator

shop

customer, product

SELECT

web_administrator

Notes: The web_administrator is a user in the web application that is used specifically for creating

and displaying customer orders.

SELECT, INSERT, UPDATE

customer_order

shop

DB Admins

Notes: Database administrators have full access to the database.

All

All

All

Maintaining a table such as the one shown in Table 16-2 is helpful to technical and man-

agement folks, because it centralizes details about who can do what in the database.

IMPROVING SECURITY EFFORTS

Don’t try to completely overhaul your security practices in one shot. Such an attempt will most likely end in

frustration and lead to no security policy or plan at all. Start by selecting one or two of the most important

things and commit to always following good practice in those one or two things. Once those few critical

things are taken care of, identify the next few items and work toward them.

Identify existing pieces of your system that could be more secure and take time to go back and give

them the attention they need. If you’ve created a number of accounts with too widespread permissions, go

back and clean up the accounts.

When you start a new project, spend some time on implementing security rules for the new functional-

ity, completing the database administration work before any code is written.

A key to improving your security practices is to be knowledgeable about security. Increase your aware-

ness and understanding of security topics by reading one of the hundreds of books on security, or by

subscribing to a magazine or mailing list focused on the topic.

If you don't have the time, but can justify the expense, hire an outside security professional to perform a

security audit. This can provide a significant boost to your security policy and plan. Having someone from the

outside assess the situation provides an added measure of authority if you are given the task of convincing

management that security is worth the time and energy.


C H A P T E R   1 6   ■ S E C U R I T Y

Getting Started: A MySQL Security Quick List

We hope that your security policy development and implementation is a slow, careful, and

deliberate process. But we also understand that, in many cases, security is something that

must be wrapped into numerous other responsibilities and doesn’t always get the attention

it deserves. Here, we’ve provided a list of things that are imperative when running a MySQL

database. These are the most serious of all the recommendations:

Set the root user password: By default, MySQL includes a database account for a root user

that has no password. This means that until the root user password is changed, anyone

can connect with full database privileges, without needing to enter a password. If you

haven’t changed the MySQL root account password, do so immediately:

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpwd');

SET PASSWORD FOR 'root' = PASSWORD('newpwd');

Remove the anonymous account: By default, MySQL includes an anonymous account that,

like the default root user account, has no password. The anonymous account makes it

easy to immediately be able to use the database, because you can connect without need-

ing to set up credentials. Unless the password is set, or the account is removed, anyone

can connect to the MySQL database. The anonymous user has limited permissions, but

still should be removed, unless it is used as a part of your security plan.1 Remove the

anonymous user account by revoking any accounts that do not have a name (specified

with empty single quotation marks, '').

Run MySQL as a non-root user: Do not use the root Unix account to run the database.

For database users who have the FILE privilege (described in Chapter 15), running as

root means that interactions with files are doing so with root privilege, which could allow

access like reading otherwise-protected files from the operating system into a database

table for viewing. Typically, you will create a mysql user account and use it for running the

database. Then, if the MySQL server has a security vulnerability, the potential for damage

to the rest of the operating system is limited to what the mysql user is allowed to do.

Use the mysql group: Create a mysql group, and use that group to control access to the log

files. Depending on how much logging you do, having exposed log files in MySQL can be

just as bad as having exposed data files.

Check data file permissions: Make sure your data files are available only to the mysql user

(and maybe mysql group, if circumstances require). Even if users don’t have an account

to connect to the database, if they have the ability to read the data and log files on the

server's filesystem, they can copy them elsewhere to use.

Disable networking: If you use MySQL only on the local machine (you are physically at the

machine, are using a secure connection to run a shell, or are using an application running

on the same machine), turn off networking. You can do this by setting --skip-networking

in your server startup configuration (see Chapter 14 for details on configuring MySQL).

1. You may use the anonymous account to make certain pieces of information available. Perhaps you

have tables that many people need to see, so you keep the anonymous account for access to that

data. That way, people can connect and view the data without needing to remember a username or

password.


C H A P T E R   1 6   ■ S E C U R I T Y

Secure network traffic: If MySQL must be used across a network, use a private network or

SSL encryption for the traffic that flows between the database and client. If you’re just

looking at data, this prevents snooping, but if you’re resetting passwords, granting permis-

sions, or looking at the process lists (where you can see executing queries), having privacy

for your data means you are not exposing the sensitive data as it comes across the wire.

This list gives you a starting point by stressing the most critical items, but it does not pro-

vide a complete picture. Once you’ve implemented the items on this list, we encourage you

to continue reading to get a more thorough idea of the steps for securing your database.

Setting Up Database Security: An Example

To highlight some of the ways a database can be secured, let’s consider a real-world scenario.

Suppose you have an office for an online shopping store (to stick with a familiar example). For

your ordering system, you have a web site for the public to shop, place orders, and check order

status, backed by a database. You also have a web-based application used for order processing

and order fulfillment, pointed at the same database. You have a team of ten order processing

and eight order fulfillment employees. Besides yourself, three other members of the IT staff

work on the applications and maintain the database. Figure 16-1 shows the different players

in this scenario, depicting the customers and employees, and a server that handles the

requests from your public web site and your employee interface to the data.

Customers

Employees

Web Site

Database

Order

Processing

Site

Figure 16-1. Users and servers in a single-server online shopping configuration

Locking Up the Server

Regardless of how many servers are required to run the site, the first thing to consider is the

physical location and accessibility between the pieces of the system in Figure 16-1. You should

have the machines in a secure location, with no access allowed by the public (not in a closet in


C H A P T E R   1 6   ■ S E C U R I T Y

the office lobby), and limited physical access by all employees, even your IT staff. To physically

get access to the machines should require obtaining a key to unlock the server rack.

Locking Down Network Access

Next, consider how your server is available via the network. You need to make sure the operat-

ing system is updated. You also must deny access to services on the machine via a firewall or

by disabling unnecessary programs and processes.

The public web site will obviously need to be accessed by anyone coming in from the

Internet. The order-processing and order-fulfillment pieces of the system are needed only by

users within your office. You might control access by using an internal network and binding an

internal domain name or IP address to the those pieces of the site or service.2

Because MySQL is running on the same machine as the sites, and the interaction with the

database happens through tools built into the site, you should be able to disable the network-

ing capabilities of MySQL. This involves adding the skip-networking option to your startup.

Adding this option means that MySQL will not listen for data requests via the network, which

can be a security risk.

■Note If you are using SSH to connect to a machine, and then using the MySQL client to interact with the

database, you are not using MySQL’s networking capabilities. The network connection is handled by SSH,

and the database connection is made using the Unix socket.

Controlling Access to Data

With the networking locked down, you should next consider how to control access to data

in the system. Presumably, you have a database with a set of tables used to store information

about categories, products, users, and user orders. These tables drive the site. In addition, you

may have data for internal use in processing, packaging, and shipping the orders. If you don’t

already, it’s not a bad idea to separate those functional areas into two separate databases,

which will give you more options for controlling access down the road.

Of course, you’ve removed the anonymous account from the database and have set the

root user’s password, as noted in the quick list earlier in this chapter. Now, you need to figure

out how to give access to the applications. For the public web site, you will create one user

specifically designed to interact with the database on behalf of the user of the site. This data-

base account should have the bare minimum access to allow the web user to browse products,

put them in a shopping basket (and remove them), and process the order. This account will be

programmed into the web application to get a database handle.

The employees’ interaction can be managed in a variety of ways. You might maintain

MySQL accounts for each employee and require employees to type their username and pass-

word into the application and use their credentials to get a database handle from the database.

2. We’re thinking of Apache’s VirtualHost directive, which allows you to bind different domain names or

IP addresses to a particular directory with a set of pages or scripts letting you create multiple sites on a

single machine. For more information about configuring virtual hosts, see http://httpd.apache.org/

docs/mod/core.html#virtualhost.


C H A P T E R   1 6   ■ S E C U R I T Y

This provides a great deal of granularity in controlling access to the data, but can be difficult to

maintain if you have a lot of employees. Another approach is to create a special user to obtain a

database handle and interact with the database on behalf of the user.

Besides having an account for the database administrator, you should need only two

accounts for access to MySQL (or one plus the number of employees if you’re granting

accounts to employees).

Making sure the rules for each user are correct is a matter of reviewing the security plan

access documentation and running GRANT statements for each permission needed. In addition,

for both the public and internal site, MySQL connections can be limited to those coming from

localhost, because the only connections made to the database are coming from processes on

the same machine. When granting permissions, everything should be done with @localhost

appended to the user. When looking at the mysql.user table, you should not see any entries with

host set to something other than localhost.

This simple scenario provides a very rudimentary review of the process of securing a sys-

tem and database. By no means does this cover the details necessary to call your security work

complete, but it does give you a sense of the process. Before we leave our example, let’s con-

sider a few more elements that add some complexity to the plan.

Adding Remote Access

Suppose that one of the order-processing employees has arranged to work some hours from

home and needs access to the database from a remote location. You have several options,

which may vary in acceptability, depending on what kind of work the employee will be doing

from home:

Shell account over SSH: You could grant remote access to the command-line tools by cre-

ating a shell account on the server, with access to the mysql client program. This model

would require creating and maintaining shell accounts for users requiring remote access,

but you would not need to open the database to network requests you previously disabled

with the skip-networking option.

MySQL Administrator over SSH: If the user needs a GUI to interact with the database, but

SSH is still your preferred connection method, you could install the MySQL Administrator

tool on the server and have it run remotely in an X window on the user’s remote desktop.

You wouldn’t need to open up mysql to network connections, but you would still need

to maintain shell accounts. You also would need a decent pipe between the server and

the user’s home to get acceptable response from MySQL Administrator running via the

X Windowing System. (MySQL Administrator is introduced in Chapter 15; also visit

http://www.mysql.com/products/administrator/ for more information.)

SSL client connection: If creating, maintaining, or allowing a user to have a shell account on

the server is out of the question, another option is to run MySQL in a mode that will listen

(on port 3306) for requests to the database. The risk here is that you open the database to

network-based attacks. Also, unless the network connections are on a private network, you

would want to require use of SSL encryption in the account privileges. This is accomplished

by adding REQUIRE SSL or REQUIRE X509 in the GRANT statement for the user’s MySQL account.

You would also limit the host to the employee’s remote IP address (or at least an IP range) by

specifying <user>@<ip> in the GRANT statement. Then, if an attempt were made to connect

from another IP address, or without SSL enabled, the connection attempt would be refused.


C H A P T E R   1 6   ■ S E C U R I T Y

Note that MySQL doesn’t have SSL enabled by default. This means that it’s unlikely that a

version provided with your operating system will have SSL support. In addition, the MySQL

binaries available from the MySQL web site do not have SSL enabled. To use SSL connec-

tions, you need to build MySQL yourself. The OpenSSL libraries must be installed on your

system to rebuild MySQL and enable SSL support. See Chapter 14 for more information

about compiling MySQL and using configuration options during the process.

MySQL Administrator via SSL: If network connections are allowed (and, in this case, SSL

encryption should be required), the user could also connect to the database using tools

like MySQL Administrator instead of a command-line client on their remote machine.

As you can see, each piece of the security puzzle brings more options to consider, and

these also require reconsideration of the original assumptions made when developing the

security policy for your data and database.

Adding Servers

Having a single server responsible for handling the online customers as well as the employees

and database is not always the case. Another likely scenario is to have one or more classes or

groupings of servers, responsible for functional areas of the site. Figure 16-2 shows our origi-

nal scenario with servers broken into three classes: public web site, order processing site, and

database.

Customers

Web Site

Database

Employees

Order

Processing

Site

Figure 16-2. Users and servers in a multiple-server online shopping configuration

The primary difference between this and the system shown in Figure 16-1 is that with mul-

tiple servers, you can further segregate the functions and get better control over access to the

servers. In this scenario, you can put just the server needed for the customer web site on the

public network, and protect the order-processing site on a private network available only to

employees in the office. The database server doesn’t need to reside in either of these networks;


it could be connected to the web servers via a separate network. Figure 16-3 shows a revamped

diagram of the servers, illustrating where each piece of the site fits into this model for securing

the systems.

C H A P T E R   1 6   ■ S E C U R I T Y

Public Network

Private Network

Customers

Web Site

Database

Employees

Order

Processing

Site

Figure 16-3. Users and servers segregated from network segments

Having the machines separated like this means you’ll be required to turn on networking

on the MySQL server and change the access rules to allow traffic from the IP addresses or

domain names of your web site and the order-processing site.

Implementing this configuration will also put you at odds with the employees who are using

the database remotely. Before you implement this plan, you’ll want to think about how you’re

going to get them from the public Internet to the database server living on a private network.

Perhaps you’ll put an old desktop up on the public Internet to serve as a gateway into the private

network. Or maybe you’ll create a secure tunnel through the public web server. In either case,

you have some homework to do before proposing this security improvement.

Now that we’ve looked at an example of setting up security, we’ll move on to a collection

of suggestions for ensuring your system is secure.

Securing Your Whole System: Seven Major Areas

Because your system is built with various parts, deciding how to secure a database involves a

lot more than just protecting the database itself. When deciding how to protect your data, you

should be thinking about methods to secure physical access to the server, operating system,

files and processes, network, database configuration, users and application access, and the

data itself.


![R3006](images/R3006)


![R3008](images/R3008)


C H A P T E R   1 6   ■ S E C U R I T Y

Physical Access to the Server

Even if your account permissions are locked down to the most granular details, if people have

physical access to a server, they could power down the machine, pull network cables, or take

drives out of the database machine. If users can power cycle the server and boot from a CD in

the drive, they can easily mount up drives and have full root access to the data on those drives.

While tales of social engineering to convince a data center operator to grant unauthorized

physical access to a server seem far-fetched, consider how long it takes your organization to

communicate word that an employee has lost access rights. Will security personnel at your

data center know in time that an employee has lost rights to the server room if that employee

immediately drives (or takes the elevator) to where your servers are housed and attempts to

gain access?

Here are a few suggestions to secure physical access:

Lock the server: Do you have a database running on a machine under a desk in an office

that gets cleaned during the night? Do the employees on the cleaning crew know not to

unplug cords or dust near the power switch of your servers? If your database machines

are in a location that is traveled by other people (strangers or employees), consider get-

ting a locking rack, or at least machines with keyed power or a lockable front bezel. In

larger organizations, considering using an access card and physical log for the name,

time, and purpose for physical access. Even if you trust your employees, logging the entry

to the server area sends a message about the importance of caution during physical inter-

action with the machines. In some cases, it may deter an employee from being at the

machine when not necessary.

Protect the cords: Are your machines locked up tight, but receiving power or network con-

nectivity via a publicly accessible area? You may want to move your machines or rack to a

place where intentional or accidental removing of cables is not a risk to your server.

Protect remote hardware: The physical security of your machines might extend to physical

protection of external hardware. Do you have a laptop or desktop somewhere that has

passwords stored or public-key authentication to the database servers? Even if you don’t

store passwords in a file on your system, if your SSH or database tools have the Remem-

ber Password box checked, you should treat your desktop or laptop computer as if it were

part of the set of machines necessary to physically protect.

Consider off-site hosting: If you have your servers in-house (or in-office), but use them

over a network, you might look into co-location or dedicated server services to provide a

secure environment for your machines. In most cases, a data center will provide better

physical protection on your machine than you can at an office.

Protect backups: If you have a backup of your system written to tape or onto another

server, that physical storage should be protected as rigorously as the servers themselves

are guarded.

These are just a few ideas about how you might protect your servers. Since there are so

many variables in controlling physical access to your servers, we recommend that you look

closely at your particular situation and implement any measures that would improve the

physical security of your machines.


C H A P T E R   1 6   ■ S E C U R I T Y

Operating System

Taking the time to properly configure and secure your database accounts will be pointless if

your operating system remains open to intruders. A user could get access to the root account

on your server via a security hole in the operating system (or an application or library on the

server) and be able to do a lot of damage—copy, remove, or change database files; reset the

root MySQL password (or any other password on the system); and more. Even without root

access, if a user can execute commands with the privileges of an existing user on the system,

he may be able to copy the data files onto another system.

To ensure a machine is secure, be diligent about keeping the applications and libraries on

your machines up-to-date, especially when a known exploit is announced for a piece of code

on your server. Be sure, in cases like SSL libraries, that any dependent applications are rebuilt

with the newest libraries.

■Tip Many books are dedicated to operating system security. For example, Hardening Windows, by

Jonathan Hassell (Apress, 2004), and Hardening Linux, by James Turnbull (Apress, 2005) provide thorough

coverage of securing your operating system.

Files, Directories, and Processes

An extension of the operating system, the files, directories, and processes on your server also

need to be protected to secure your database. If a user has read access to the directory and

files of your database, she can easily copy them to another server and have MySQL load them.

With access to the MySQL binary logs, a user can view any insert, update, or delete statements

in the database. Having this information exposed is almost as bad as having the data files

themselves open.

Here are a few suggestions to secure access to files, directories, and processes:

Run MySQL as a non-root user: This is one of the critical items on the MySQL security

quick list presented earlier in the chapter. We want to stress that it’s important to make

sure your database is running as a non-root user, to protect the resources on your server.

Protect the socket file: Make sure your mysql.sock file, used for database interactions

on the local machine, is protected. This file is typically stored in the /tmp directory

(/tmp/mysql.sock). On some operating systems, any user can remove files from the /tmp

directory. Removing mysql.sock will prevent any interaction with the database. To protect

against this, you can either set permissions on /tmp files or move mysql.sock to another

location using the socket=/path/to/socket option in your database and client configura-

tion. Refer to http://dev.mysql.com/doc/mysql/en/problems-with-mysql-sock.html for

more information about protecting the mysql.sock file.

Secure log files: If you are logging database activity, include your log files in the list of files

to secure. Give log files read and write permissions to only the mysql user (and perhaps

the mysql group).


C H A P T E R   1 6   ■ S E C U R I T Y

Consider an encrypted file system: If protecting your data files is critical, you might con-

sider using an encrypted file system, which will store data on the disks in an encrypted

format. An encrypted file system means that even if your disk is removed from the

machine and mounted elsewhere, your data is still protected (provided the key hasn’t

been discovered). Using an encrypted file system adds overhead in retrieving and saving

data. Also, you’ll need to account for encrypted files when backing up and restoring data.

Prevent symbolic links: If you don’t need to use symbolic links, disable this feature by

specifying the skip-symbolic-links option in the database configuration (see Chapter

14). This will prevent users from creating symbolic links within MySQL to files they don’t

have permission to view but can get to through the server (running MySQL as root makes

this problem even more serious). However, in some cases, using a symbolic link for tables

is necessary to spread the data across several different disks for space and performance.

Just as when you’re protecting access to data and database management functions from

within MySQL, it is important to look at all the user accounts on your server and determine

how to make sure the data and log files are available to only those who have authorization to

access the files. Some pieces of this will be implemented with the security plan; others are just

a part of being diligent about locking down your system.

Network

The network is another point of entry to your database, and it should be a part of your security

audit on your database servers. As we’ve suggested earlier in this chapter, if you don’t need

network access on your MySQL server, turn it off. There’s no reason to leave it up and listening

if it’s not being used. It poses an unnecessary security threat.

Here are a few other ideas for securing your network:

Restrict host connections: Use the HOST field restrictively in your GRANT statements, making

sure that you are granting access only to connection requests from a set of specific DNS or

IP addresses.

Secure traffic: If network connectivity is required for your database server, use a private

network or SSL encryption for the data. If funds allow, obtain an extra network interface

for each server and a switch to run the traffic through. For instances where the private

network isn’t an option, use MySQL’s SSL encryption, or set up a secure tunnel using SSH

or an SSL tunnel. If the only reason you need networking is for users to query the data

from their desktop, you might consider creating a shell account that provides the ability

to log in to the database or run administrative tools.

Use a firewall: Adding a firewall to your machine not only blocks unwanted MySQL traffic,

but it is also good practice for keeping your operating system secure.

Use IP addresses if your DNS is unreliable: If you don’t have a trusted DNS source, use IP

addresses for connection control. An untrusted DNS means that you can’t be sure that some-

one won’t change the entry for trustedhost.promysql.com to untrusted.badhacker.net. In

this case, your database, thinking connections are allowed from trustedhost.promysql.com,

would let the connection through, even though the request was really coming from an

untrusted machine.


C H A P T E R   1 6   ■ S E C U R I T Y

These are a few things to think about when looking at access to your data over a network.

Your server configuration might call for additional considerations, which should be carefully

weighed when choosing the right protection for your database networking.

User Access

User access is where most of the action happens when securing the data in your database.

This involves creating accounts, granting access to databases and tables, restricting users to

connections from certain hosts, and so on. Refer to Chapter 15 for specifics on how to set up

and modify user accounts.

As we noted in the MySQL security quick list earlier in the chapter, when you first get

MySQL up and running, be sure to set the root password. By default, this password is blank,

which allows anyone on the server to connect as root. Then don’t use the root account to

manage your database. Set up another account for that purpose. We also said that you should

remove the anonymous user account, which is part of the default table setup in MySQL. For

more information on securing initial MySQL accounts, see http://dev.mysql.com/doc/mysql/

en/default-privileges.html.

Other areas related to user access include passwords, account privileges, and connections,

as discussed in the following sections.

Requiring Passwords

You should require passwords, and make sure that they are good ones. MySQL doesn’t enforce

periodic password changes; in fact, it doesn’t enforce having passwords at all. When you create

a user account, make sure the user is assigned a password or creates a good password. You

may choose to manually force a password change periodically, but it’s a social, not technical

process. Users can reset their passwords by using this command:

SET PASSWORD FOR '<user>'@'localhost' = PASSWORD('newpwd');

Controlling Account Privileges

The following are a few ideas for controlling account privileges:

• Grant the minimal amount of access necessary for users to do their work. Do not fall

into the trap of thinking that you don’t have time now, so you will just grant everything

and then come back and fix the permissions later. This is dangerous, because you’re

probably not thinking of the entire set of data (if you’re in a rush), and the chances

you’ll come back later and make changes are slim (based on personal experience).

• Don’t grant access at all, if it can be avoided. The user who runs a report once a year

probably doesn’t need access if you can have another user or administrator store the

query and run it for him. The best security for an account is to not have the account

at all.

• Never grant access, or permission to directly change, the MySQL privilege tables. If a

user has INSERT, UPDATE, or DELETE privileges on the mysql.user table, she can make all

kinds of trouble. We recommend using the GRANT syntax for controlling all accounts and

permissions.


C H A P T E R   1 6   ■ S E C U R I T Y

• Grant the PROCESS and SUPER privileges only to database administrators, and with cau-

tion. With these permissions, a user can issue a SHOW PROCESSLIST command, which

allows the user to see all queries issued against the database, including password resets.

• Grant the FILE privilege only to administrative users. This privilege allows a user to cre-

ate files on the file system as the user running MySQL (underscoring why you shouldn’t

be running mysqld as the root user).

• Rather than giving a user direct access to a table or set of tables, create a stored proce-

dure that contains the statements he needs to run and give him only the ability to

connect to the database and execute that procedure.

• If the user only needs to view certain pieces of data, create a view that is not updatable

that contains only the data she requires.

Controlling Connections

A major part of securing your database is controlling the connections to the database. Deny-

ing connections is your first defense in keeping unauthorized people and actions out of your

database. Here are some ways that you can control connections:

• Revoke the ability for the root to connect from anywhere except from the localhost.

This assumes you have a shell account on the database server. If you do not, you may

want to change the host of the root to a specific domain name or IP address to ensure

that there is only one place to connect as root.

• Restrict the number of connections that can be made by a user.

• Restrict the number of bad connection attempts that can come from a host before con-

nections are blocked, using the max_connect_errors setting (see Chapter 14). By default,

this is limited to 10, which usually works well.

• Force SSL connections from remote hosts, unless you know the hostname is coming

from a private network. This is done by adding REQUIRE SSL or REQUIRE X509 in the

GRANT statement.

■Note As mentioned earlier in the chapter, MySQL doesn’t have SSL enabled by default. In order to use

SSL connections, you must install the OpenSSL libraries on your system and build MySQL yourself to

enable SSL support. See Chapter 14 for details on compiling and configuring MySQL.

Securing user accounts is an ongoing process. You should periodically look through your

user (and other permission tables) and verify that the policies you have defined are still intact. As

time passes, different users touch the system, new functionality in the database and application

are added, and your security policy changes. Doing an audit of the user accounts in MySQL is a

good way to pinpoint potential security holes and get them closed before an incident.


C H A P T E R   1 6   ■ S E C U R I T Y

Application Access

Building a secure application is important to protecting your database. The security of the

data is closely tied to how well the application protects the data from attacks.

When the data is extremely sensitive, you may choose to not create a general-use applica-

tion account. You may do this if you want to be sure you have authentication credentials

presented via the application for any change in the data. This can be a headache to maintain,

especially if you don’t create scripts or procedures to manage the accounts. However, having

accounts specifically assigned to users means you control the ability to change data from the

MySQL permissions structure and don’t need to rely on the application to manage permis-

sions. Also, when a change is made with the binary log enabled, you have a trail of changes

that can be tied to specific user connections.

In most instances with a web application, a general-use account for connections from

the application will be easier to deal with and more appropriate. Be careful when creating

accounts used by the application to read and manipulate records in your database. If your

system is heavy on reads, you may want to create an account with SELECT-only permissions

to be used in most places in the application. Create a more privileged user to perform data-

manipulation tasks.

Data Storage and Encryption

Up to this point, we’ve looked at only how to protect access to or prevent unauthorized

changes of data, not the data itself. As we’ve said before, because the contents of databases

vary wildly—from grocery lists to banking transactions—you should assess how secure your

data must be. For most applications, protection against getting into the database is enough.

However, in some cases, the data in the database requires an extra layer of protection.

For instances where data is extremely sensitive and damaging to individuals if tampered

with, you might want to consider using one-way encryption, two-way encryption, or no

encryption at all (by not storing the data in your system). We’ll take a brief look at each of

these approaches here. For details on encryption functions in MySQL, refer to http://

dev.mysql.com/doc/mysql/en/encryption-functions.html.

One-Way Encryption

Use one-way encryption for information that doesn’t need to be reversed. This technique is

used for passwords. The password is encrypted once with a nonreversible algorithm, and then

on future attempts to verify the password, the data is run through the algorithm again and

compared to the previously computed result.

Functions in MySQL for one-way encryption are password(), old_password(), md5(),

encrypt(), and sha1(). These functions are easy to use, and like all functions, are embedded

directly into your SQL statements, as in this example:

mysql> SELECT sha1("a horrible secret") AS sha1;


C H A P T E R   1 6   ■ S E C U R I T Y

The following is the result from this SELECT statement:

+------------------------------------------+

| sha1                                     |

+------------------------------------------+

| 06bc43a7c4c03fb37553c3f42bad928c9a8d1aa1 |

+------------------------------------------+

1 row in set (0.00 sec)

■Caution Do not invent your own encryption algorithm. Many well-tested and widely used algorithms are

available in MySQL to produce cryptographically secure results.

Two-Way Encryption

Two-way encryption functions allow you to encrypt data using a value and a key. With the

encrypted value and the key, you can get back to the original value.

MySQL functions that support two-way encryption are aes_encrypt(), aes_decrypt(),

encode(), decode(), des_encrypt(), and des_decrypt(). The Advanced Encryption Standard

(AES) is currently regarded as the most sound encryption routines currently available in

MySQL. The encoding is performed with a 128-bit key, which is significantly secure and

still speedy.

■Note The Data Encryption Standard (DES) functions work only if MySQL has been compiled with SSL

support, and uses DES key files from the file system.

As with other MySQL functions, you use the two-way encryption functions directly in

your SQL statements, as in this example:

mysql> SELECT aes_decrypt(aes_encrypt("a horrible secret","SecRet"),

"SecRet") AS AES;

Because the AES functions generate binary information, an attempt to show the output

from the function in text is futile. In this example, we are encrypting a string with the key

"SecRet", and then immediately decrypting the result of that encryption using the same key.

This use wouldn’t be that useful in your application, but it demonstrates using two-way

encryption. Here is the output of the statement:

+-------------------+

| AES               |

+-------------------+

| a horrible secret |

+-------------------+

1 row in set (0.00 sec)


C H A P T E R   1 6   ■ S E C U R I T Y

Attempting to use the incorrect key for decryption will result in a NULL response from the

decryption function:

mysql> SELECT aes_decrypt(aes_encrypt("a horrible secret","SecRet"),

"PubLic") AS AES;

+-----+

| AES |

+-----+

| NULL|

+-----+

1 row in set (0.00 sec)

Two-way encryption functions in MySQL provide a powerful tool for encrypting data so

its value in the database is meaningless unless coupled with the key for decryption.

No Encryption

The most reassuring way of keeping data secured in your system is to not have the data stored

anywhere in your system. Yes, that sounds obvious, but it is an important option to think

about.

When you accept a credit card in your application, is it really necessary to keep the credit

card information in your database? If part of your application fires off a request to a third party

to charge the card and credit your account, you may not need to keep the credit card informa-

tion around after that point. If your payment-processing vendor creates an entry in its system

and passes back a token that can be used for future reference, storing that key in your data-

base and using it, instead of the credit card number, makes more sense. As the processing of

the order moves through your system, you don’t need to worry about the sensitive nature of

that credit card number, because it is not housed anywhere in your system as the processing

of the order moves along.

Summary

We’ve been through a lot of information regarding security. We started by discussing the

importance of understanding security requirements and making a security policy and imple-

mentation plan before undertaking the actual work of making changes in your database. You

saw that security involves much more than just looking at what tables a user can access. It

starts early on when decisions are made about what and how data will be stored and who will

have access to that data. Once decisions have been made (please document those, it will save

you a lot of time), you can put together a road map for implementing the plan, including

building tools to manage the security policy.

Next, we considered a real-world scenario and the steps a database administrator might

take to make sure the database was properly secured from unauthorized access. Then we dove

into seven major areas to consider when reviewing and attempting to improve the security of

your database: physical access, operating system, files and directories, network, user access,

application access, and data storage. Each of these sections offered suggestions for improving

the security of your system.


C H A P T E R   1 6   ■ S E C U R I T Y

Remember that, in many cases, the biggest security threat is internal to your organization.

Yes, you do want to protect against the bad hacker who is running a port scan across your sys-

tem. However, you also need to have measures in place to secure against intentional and

accidental attacks from within. You don’t want the experience of having an innocent developer

accidentally delete everything in a table in the production database, where he had no reason

being, just because he got mixed up and issued the command intended for the development

database.

The important goal is to get your system to a state where you are relatively comfortable

with the security you have in place. It’s not easy to get to this state, because it seems you can

always find room for improvement. Just moving in this direction will help your system and

make you feel better about your security. Oh, and it will also help you sleep better at night.


C H A P T E R   1 7

■ ■ ■

Backup and Restoration

Data continues to become more important to the functioning of organizations and the serv-

ices they provide to customers. Along with this trend, the value of the organization becomes

more centered on the availability of the data. This reinforces the importance of having backups

of data readily available to reduce interruptions in service should the data become unavailable

or compromised. Even though the consequences of not having a backup can be detrimental to

the organization (and employee), commitment to backing up data varies.

Backups are often left until the last minute, which means they are done in a hurry and

without proper consideration to the requirements of the backup. The method to restore data

gets even less attention.

This chapter begins by reviewing the reasons, requirements, and principles of backing

up and restoring data. Then it covers the specific backup and restore methods available in

MySQL. We will cover the following topics related to backing up and restoring data in MySQL:

• Reasons for creating backups

• Backup and restoration planning

InnoDB backups, and MySQL Administrator

• Binary logs for up-to-date tables

• Methods for backing up and restoring MySQL data, including mysqldump, mysqlhotcopy,

Why Do We Create Backups?

Perhaps this seems the question of a novice, but have you ever asked yourself why you are (or

should be) backing up your data? If you asked that question of several people in your organi-

zation, you might be surprised that you get a variety of answers. There are many reasons for

having backups of data, and those reasons affect how you should implement both your

backup strategy and your recovery strategy.

Here are some of the reasons why you might create a backup of your database:

• Computer hardware is not 100% reliable. You back up your data so that if your database

server or disks have a hardware failure, you have a snapshot that can be used to bring

back the data.

• Human interactions with the database aren’t reliable. Whether accidental or inten-

tional, people working in the database can cause unwanted changes in the data,

requiring a restore from a backup.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

• Programs have bugs, or unexpected interactions with the database, and you may find

that your application is making unwanted changes in your data. With a backup, you can

return to a previous version of the data.

• A backup of a database can sometimes be used to preserve a snapshot of the data for

historical reasons. These backups might be kept around for years.

• Servers can be compromised and need to be rebuilt. If you have a snapshot of your data

from before the breach, you’ll be able to go back to that point once the server is rebuilt.

• Viruses, SQL-injection, and other web-based scripting attacks can bring down your

database server or play tricks with the data in your database, requiring a restoration.

• Having a backup allows you to run tests against data, and then quickly restore the data

to a previous state. Most testing of a system backed with data relies on data being in a

certain state. Having a backup of that state allows you to easily return to that state to

rerun the tests.

• In some instances, you might want a periodic backup with just the database structure,

without any data. This can be useful if you need to share your schema with other peo-

ple or systems, or for version control of the structure.

• You may need to export data to other systems. Perhaps you have a local copy of the

database running on a desktop for running statistics queries, or you have a testing

server for releasing new code that requires a production database refresh. The database

snapshot from a backup is also helpful in setting up a replicated database.

■Tip Jeremy Zawodny created a tool, called mysqlsnapshot, for creating snapshots of your database,

intended for use when creating a point-in-time view of the data to transfer to another machine to be the

base data for starting a replicated server. You can download mysqlsnapshot from the project page he

maintains (http://jeremy.zawodny.com/mysql/mysqlsnapshot/).

You may back up your data for one or many of these reasons, or other reasons. Your backup

needs are the basis for your backup and restore plan, as described next.

Creating a Backup and Restore Plan

If you’ve held any responsibility for data backups and restorations, you’ve probably had the

experience of a user requesting something from the backup that wasn’t available. You then

needed to clarify exactly what could and couldn’t be done with a backup. Maybe the user was

looking for a few hundred records that were deleted from a table three weeks ago, and you

explained that backups are kept for only one week.

If you’ve had a conversation like this, you may have been asked to clarify precisely what

is and isn’t available through the backups of the system. This kind of interaction with users of

your data points to the need for a backup plan, which includes both how the data is backed up

and how it is restored.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

If you need motivation to take the time to properly develop a backup plan, imagine that

tomorrow when you get to work (or you were woken up by the phone), every one of your data-

bases, on all of your live database servers, had been dropped. Where does that leave you? Do

you have the data somewhere, and how easy is it to get to for a restoration?

If you’re wondering why you need a restore plan, imagine you have a backup of every

table in your database, allowing you to restore a single table. After you restore a single table

(that had 100 rows accidentally deleted), you realize that there are problems with dependen-

cies from other tables. You now have orphaned records after the restoration, all because you

didn’t have time to think through all the relationships and restore the referencing tables.

Without a practiced plan and set of methods in place to restore the data, you may find that

restoring the files from the backup does not bring the data back to the correct state.

Developing Your Backup Plan

The backup plan should be a document that outlines the requirements for your backup strat-

egy and implementation. Owners and users of the data should be a significant part of creating

this document. Stakeholders are ultimately the people who must deal with the loss of data,

and they should be at the table helping define what the backup plan should look like. The data

owners and users will be able to provide a lot of detail on when and how the data is used, and

what types of situations might arise that would require data restoration. Getting a sense for

what the users prioritize as reasons to keep a backup of the data will help in determining the

implementation details for your backup. Having the stakeholders and technical folks at the

same table allows technical folks to give input on what is technically possible (outside of

uncommitted transactions, there is no “undo” button in MySQL).

Once you have been refreshed on how the other stakeholders use the data, and have a

sense of why and how stakeholders would use a backup, you should discuss the implementa-

tion details. The following are some questions to pose:

• How often should the backups run? Depending on the application, this might be

weekly, nightly, or even every hour.

• Does all the data require the same backup interval? Some data might never change, and

some data may change constantly. Should you back up everything once a week and cer-

tain other databases or tables every night?

• How long should backups be preserved? Is two days’ worth of history enough, or do you

need to provide a month’s worth of backup?

• Where should the backup be stored? Is it necessary to have it on the database server for

faster restoration, or should it be moved to a remote server for protection against theft

or disaster? Should it be on disks or on a tape? Should a copy be kept off-site?

• Is it acceptable to lose any data? It’s possible that your backup plan will leave gaps in

the data. For example, suppose you have a nightly backup, and you plan to use the

binary logs to bring any of your tables up-to-date. If the database server goes down,

and the data is not available, you’ve lost access to the binary logs. A restore from the

backup brings you up-to-date with last night’s backup, but without the binary logs,

you have no way to bring the database up to what was last available on your now-

unavailable database. Replication, discussed in Chapter 18, can help solve this problem.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

All of these questions will lead to the technical details for implementing the backup plan.

The answers to these questions will also be directly tied to how the data is restored.

■Note In some cases, the requirements for a backup are better met by database replication. With a repli-

cated database, a current, live copy of the data is maintained on a separate server and can be brought into

service without the trouble of restoring data from another disk or tape. A replicated server doesn’t solve data

integrity or deletion issues, as it mirrors the primary database, but it can be available when the primary

database or database server becomes unavailable. See Chapter 18 for more information about replication.

Developing Your Restore Plan

The conversation and document outlining the backup plan is incomplete if it does not address

the process of restoring data. While you have the stakeholders and technical people in the room,

be sure to get their input on how the data is restored to the database server.

The following are some questions to address to help define the restore policy:

• Who, of the data owners, is authorized to request that a table be restored to a previous

state? Maybe you can agree on a list of people or positions that are authorized to make

the request.

• What is the process of identifying a needed restoration, communicating the restoration

request, and having the data restored? In most cases, data restorations are critical, and

the natural process is for the data owner to make a frantic call or visit to the database

administrator, who drops everything and processes the request for restored data. Docu-

menting that process, with office locations, phone numbers, and e-mail addresses, will

help during those frantic moments.

• Who, of the technical staff, is authorized to have access to the backup files and the nec-

essary permission to restore data? If you have a large staff of database folks, only some

of them might have access to the server and data. Does that need to be expanded so

someone is always available to help in a data emergency?

• How does the data owner or user specify what to restore? Depending on what happened

with the data to require a restoration from backup, it might be difficult to specify what

needs to be restored. If there is a single table that was dropped, the administrator will

most likely need to restore the data from the most recent backup, and then bring the

table current with statements from the binary log. If the problem was with an update

that went awry, the administrator will need to restore the table, and then run the binary

logs up until the statement immediately before the UPDATE statement. This requires

some detailed communication, and might prompt you to write a clause in the backup

plan requiring the database administrator and data owner to sit together and restore

the data.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

• What are the restrictions on how data can be restored, based on the database con-

straints? You might have rules that say if one table gets restored to a previous state, the

five tables that rely on it will also be restored. It’s easy to create a mess in your database

if you restore tables that leave orphaned records in other tables.

• What kind of downtime is acceptable while the restoration is happening? When restor-

ing data to the database, the data will not be available for a period of time. Depending

on the type of restoration, you might need to take the database server offline com-

pletely while the files are copied back. The downtime is exacerbated by larger tables,

which require more time to restore.

• If there’s a chance some data will be lost during a restore from backup, is that accept-

able? Suppose you had a backup of the data from last night, but your database server

went down today and lost all the data from this morning.

The process of deciding and defining how the backup and restoration will work will likely

go through many iterations as the needs for your database are discovered and ironed out. This

policy will be refined by application in real-world situations within your organization. The

finalized plan should be available to all stakeholders for reference and reviewed regularly.

Each time a situation arises where a restore from a backup is needed, the plan should be

consulted to ensure that the backup and restoration met the outlined plan.

Backing Up a Database: A Quick Example

If you aren’t interested in wading through the details of the various types of backup, this sec-

tion is for you. Ideally, you should be aware of all your options and thoughtfully consider the

different methods for backing up your data. However, we’re aware that you don’t always have

time to consider all the options. In this case, mysqldump is a quick way to create a backup of an

entire database or tables in a database.

The mysqldump program generates a set of SQL statements that you can send into MySQL

to re-create the table and data using DROP TABLE, CREATE TABLE, and INSERT statements.

For this simple example, we’ll use mysqldump in a way that accepts a database and table

name, in this form:

statement:

shell> mysqldump <database> <table> > backup_file.sql

For example, to create a backup of the customer table in the shop database, use this

shell> mysqldump -u backup_user -p shop customer > customer_backup.sql

The -u (username) and -p (password) options are used for the database connection. Details

on using command-line arguments with mysqldump are covered in the next section of this chap-

ter. The output, which was put into the customer_backup.sql file, is shown in Listing 17-1 (some

comments and optional SET statements have been removed for clarity).


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Listing 17-1. Output of mysqldump for the customer Table

-- Host: localhost    Database: shop

-- ------------------------------------------------------

-- Table structure for table `customer`

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (

`customer_id` int(11) NOT NULL auto_increment,

`name` varchar(10) default NULL,

PRIMARY KEY  (`customer_id`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table `customer`

LOCK TABLES `customer` WRITE;

INSERT INTO `customer` VALUES (1,'Mike'),(2,'Jay'),(3,'Johanna'),

(4,'Michael'),(5,'Heidi'),(6,'Ezra');

UNLOCK TABLES;

To restore the customer table to the same state that it was in when you created the backup,

you simply send that file to the mysql client with the database where MySQL should re-create

the table:

shell> mysql -u restore_user -p shop < customer_backup.sql

This is a very simplistic view of backing up and restoring MySQL data, but it does work.

Read on for more details on mysqldump and other backup utilities available for MySQL.

Using MySQL Tools to Make and Restore Backups

After you’ve discovered your backup requirements and created a policy for your backup and

restore practices, you are ready to dig into the technical details of creating a backup and

restoring from it. We’ve whetted your appetite in the previous section with a quick overview

of one of the tools, and will now go through a complete set of options, including mysqldump,

mysqlhotcopy, InnoDB Hot Backup, innobackup, and the MySQL Administrator tools.

■Note This discussion does not cover the methods for backing up a MySQL cluster or data in tables using

the NDB Cluster storage engine. You can use mysqldump, which works with all storage engines, or the clus-

ter tools built specifically for backing up the data across the cluster nodes. The cluster management console

provides a command to initiate a backup of the data and another command to restore data. These commands

are covered in Chapter 19.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

FILE SYSTEM BACKUPS

You may already have a backup process for your file system. Many hosting services, data centers, and server

rooms have a network-based backup system in place that you can subscribe to. In that case, using a file sys-

tem backup might make it more convenient to create backups. It’s also a way to ensure that everything about

your database gets backed up, including configuration and log files.

However, unless you are stopping your database or read-locking all tables when the backup happens,

the actual data files aren’t well suited for the typical file system backup. Your database files may be actively

changing during the backup, and you can’t be sure how consistent your data will be if you’ve simply had

those files copied to another location. In addition, if you are using in-memory (heap) tables, a file system

backup of those tables will not capture that data, because the data stored in heap tables does not get

written to disk (for efficiency and speed purposes).

A possible solution is to use one of the other MySQL backup tools in conjunction with the file system

backups. You might do a mysqldump of your database into a specific directory, and then have the backup

of the files taken care of by the file system backup. The dump gives you a consistent snapshot, and the file

system backup provides the remote storage and history of the dump.

If you do need to restore some data, and a file system backup of the native data files is all you have to

work with, have the files or directory restored to your server, and then shut down the database to move the

previous files into the correct location on the server. Even though it is not the recommended method for

backing up and restoring a database, we have seen it work in a pinch.

Using mysqldump

A utility called mysqldump is installed along with MySQL client programs. mysqldump takes the

current structure and data in your database and converts them into sets of SQL statements

that can be used to re-create the table structures and data. mysqldump is an excellent option for

smaller databases, if you’re running backups remotely, or if you aren’t using the MyISAM table

type. This tool works with all storage engines, and it can output SQL formatted to match a

number of different standards and database systems.

■Caution Currently (as of MySQL version 5.0.6), the mysqlbackup program does not capture all meta

information about a database or table. Triggers are not a part of any dump, and stored procedures and func-

tions are dumped with only a mysqldump of the mysql.proc table. View creation statements are included in

the output of the database.

Backing Up with mysqldump

mysqldump gives you numerous options to control the output of the SQL statements. Depending

on what you’re attempting to back up, you can run the utility in three ways:

• To back up a single table, or a few tables from a single database, use a statement like this:

mysqldump [<options>] <database> [<table> <table>. . .]


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

• To back up multiple databases, but not all of them, use the command arrangement

shown here:

mysqldump [<options>] --databases [<options>] <database

[database database. . .]>

• To back up all the databases in the MySQL server, use this form:

mysqldump [<options>] --all-databases [<options>]

For any of the three ways, using options will let you control the specifics of what and how

the output is created. Table 17-1 describes common mysqldump options. Understanding these

options will be helpful when you are working on the policy for backing up and restoring data,

and will enable you to guide the policy based on technical feasibility. Additionally, knowing

which options are available will help you implement the backup and restore policy.

■Tip The options for mysqldump can be included in your configuration files, as well as specified on the

command line. mysqldump reads options from the [client] and [mysqldump] configuration groups.

For more information about using configuration files, refer to Chapter 14.

Table 17-1. Common mysqldump Options

--character-sets-dir=<dir>

Location of directory with character sets.

Option

-A, --all-databases

--add-drop-table

--add-locks

--allow-keywords

-i, --comments

--compatible=<name>

--compact

Description

Include all databases in output.

Put a DROP TABLE statement before each CREATE ➥

TABLE. This is useful if you are importing the

dump file into a database to replace existing

tables.

Surround each INSERT statement with a LOCK

statement.

Allow column names to be created using keywords.

Add comments to the dump file. This is useful for

making notes about the dump.

Specify a mode for the dump. The default is a

dump optimized for MySQL. Modes can be ansi,

mysql323, mysql40, postgresql, oracle, mssql,

db2, maxdb, no_key_options, no_table_options,

or no_field_options. You can use several modes,

using a comma to separate them.

mysqldump output is less verbose. Removes

header, footer, and structure comments. Using

this option also enables --skip-add-drop-table,

--no-set-names, --skip-disable-keys, and

--skip-lock-tables.


--default-character-set=<value>

Specify the default character set to be used.

Option

-c, --complete-insert

--create-options

-B, --databases

--delayed-insert

--delete-master-logs

-K, --disable-keys

-e, --extended-insert

--fields-terminated-by=<value>

--fields-enclosed-by=<value>

--fields-optionally-enclosed-by=<value>

--fields-escaped-by=<value>

C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Description

When building INSERT statements, include field

names in INSERT statements. This is helpful if

you’re dumping data to put into another table

that has additional columns.

Use MySQL-specific options in CREATE

statements.

Use to dump one or more databases, specified as

arguments after this option. A USE <database>

statement is added to the output.

All INSERT statements generated will be INSERT ➥

DELAYED.

After the backup is complete, delete the master

logs. --master-data is also enabled with this

option.

Two statements will be wrapped around the

sets of INSERT statements for a table, /*!40000

ALTER TABLE tb_name DISABLE KEYS */; and

/*!40000 ALTER TABLE tb_name ENABLE KEYS ➥

*/;. Having keys disabled improves performance

of the restore operation.

Use the multirecord INSERT syntax, where a

single INSERT statement contains multiple value

sets and is significantly faster. Starting with

MySQL version 5.0, this option is on by default.

Used with the --tab option, allows you to specify

a character or set of characters to insert after

each field when the records are saved into the

tab-delimited file.

Used with the --tab option, allows you to specify

a character or set of characters to enclose each

field with when the records are saved into the

tab-delimited file.

Used with the --tab option, allows you to specify

a character or set of characters to optionally

enclose each field with when the records are

saved into the tab-delimited file. Optionally

means that the field won’t be enclosed if it’s not

necessary according to the SQL rules. String

fields (CHAR, VARCHAR, and so on) are enclosed,

and numeric fields (INTEGER, FLOAT, and so on)

are not.

Used with the --tab option, allows you to specify

a character to place in front of any tab, newline,

or \ character that appear within fields.

Continued


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Table 17-1. Continued

Option

-F, --flush-logs

-f, --force

-?, --help

--hex-blob

-h, --host=<name>

--lines-terminated-by=<value>

-x, --lock-all-tables

-l, --lock-tables

--master-data[=<number>]

--max_allowed_packet=<number>

--net_buffer_length=<number>

--no-autocommit

Description

Before the dump is started, flush the server log

files. Each database mysqldump encounters will

cause mysqldump to flush the log files. If you are

dumping multiple databases with --databases

or --all-databases, and don’t want the logs

flushed every time, use the --lock-all-tables

or --master-data option. If either of those

options is specified, mysqldump will flush the logs

once, at the time the lock is obtained on all the

tables.

Report errors as they occur but keep processing

statements.

Show the help information.

Fields that are binary strings (BLOB, BINARY, and

VARBINARY) are put into the output file in

hexadecimal format.

The server to connect to when running the

dump. This can be an IP address or DNS name.

In conjunction with the --tab option, allows you

to specify a character or set of characters to end

the lines in the tab-delimited file.

Get a read lock for all tables, across all data-

bases while the dump occurs. With this option,

--lock-tables and --single-transaction are

disabled.

Before the dump starts, lock all the tables that

are going to be dumped.

Put the filename and binary log position in the

dump file. Specifying a value of 1 adds a CHANGE ➥

MASTER statement with the master log position

and filename, which causes the slave to start

from that file and position. A value of 2 (the

default) writes the same CHANGE MASTER

statement, but puts it in a comment for reader

reference. Specifying this option requires the

RELOAD privilege.

Set the maximum allowed buffer size, which is

used for communication between the client and

server. This can be set as high as 1GB.

Set the initial buffer size for communication

between client and server. Be sure the

--net_buffer_length of the server is at least

as large as what you’re setting for mysqldump.

Before each set of INSERT statements that create

a table’s worth of data, add an autocommit=0;

statement. After each table, commit the INSERTs.

This is applicable only if you are restoring data

into tables that use a storage engine that

supports transactions.


Option

-n, --no-create-db

-t, --no-create-info

-d, --no-data

--opt

-p, --password[=password]

-P, --port=<number>

--protocol=<name>

-q, --quick

-Q, --quote-names

-r, --result-file=<name>

--set-charset

C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Description

Don’t put any database CREATE statements in

the dump. This option applies only to instances

where you are dumping entire databases with

--database or --all-databases. This is useful

if you are backing up and restoring tables within

a database or the entire database, but aren’t

dropping the database as a part of your

restoration.

Don’t put table creation statements into the

dump. As with --no-create-db, this option is

useful if you are planning on restoring a single

table by doing a TRUNCATE <table>; or DELETE ➥

FROM <table>; and then importing the records.

In either case, you leave the table intact and want

only the INSERT statements for the restoration,

not the CREATE TABLE statement.

Do not put any INSERT statements used to re-

create the records in the table or database. For

example, use this if you need a snapshot of the

database structure, but not any of the data.

A shortcut option to turning on several common

options. Using --opt has the same effect as using

--quick, --disable-keys, --lock-tables,

--add-drop-table, --add-locks, --create-

options, --extended-insert, and --set-charset.

This option is enabled by default. It can be

turned off by using --skip-opt.

Use the password provided on the command line

to connect to the database, or prompt for one on

the terminal if the password isn’t specified.

Use this port to connect to the database server.

Specify the protocol used to connect to the

MySQL server. Valid values are tcp, socket, pipe,

and memory.

Send the dump directly to standard output,

without buffering the query.

Use backticks to quote column and table names.

This reduces problems with spacing and

reserved words.

Put the output from the dump into the specified

file, rather than to standard output. On Windows,

this option prevents newlines (\n) from

becoming a carriage return and line feed (\r\n),

which is typically not desired on Windows.

Insert a SET NAMES default_character_set

statement into the dump file. This option is

enabled by default, but can be turned off with

--skip-set-charset.

Continued


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Table 17-1. Continued

Option

--single-transaction

--skip-opt

-S, --socket=<file>

-T, --tab=<dir>

--tables

-u, --user=name

-v, --verbose

-V, --version

-w, --where=<WHERE clause>

-X, --xml

Description

Create a snapshot of tables that is multiversion-

capable (as of version 5.0.6, this applies to only

InnoDB). If this option is enabled, a BEGIN

statement is issued before the dump starts,

which gives mysqldump access to the tables as

they appeared at the time the BEGIN statement

was issued, regardless of how long the dump

takes. With this option specified, --lock-tables

is disabled.

Turn off the options that are enabled with the

--opt command alias. This disables --quick,

--disable-keys, --lock-tables, --add-drop-

table, --add-locks, --create-options,

--extended-insert, and --set-charset.

Connect to the MySQL server using this socket

file.

Create two files for each table being dumped:

a file with SQL statements and a tab-separated

text file with data. For each table, a <table

name>.sql file and <table name>.txt file are

generated in the specified directory. The .sql file

contains the table DROP and CREATE statements,

and the .txt file contains all the data in tab-

delimited format. The --tab option is comple-

mented by the --fields-terminated-by,

--fields-enclosed-by, --fields-optionally-

enclosed-by, --fields-escaped-by, and

--lines-terminated-by options.

All values after this option are names of tables.

This allows you to override the --databases

option.

Connect to the database using this username. By

default, MySQL uses the account name of the

current user.

Generate a helpful printout of statements

indicating the steps mysqldump is going through.

Print the version information for mysqldump.

Use the specified WHERE clause when selecting

data from the database. If you want to dump

only certain records from a table, this is the

way to do it. A properly formatted where option

looks like --where="customer_id > 1 AND ➥

customer_id < 4". The fields specified in the

WHERE clause must match fields in the table. The

quotation marks around the clause are required.

Output the table in well-formed XML. XML

support in MySQL is limited. For more infor-

mation about XML and MySQL, see http://

solutions.mysql.com/software/?item=292

and http://www.kitebird.com/articles/

mysql-xml.html.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

As you can see, there is no lack of options when running mysqldump. By putting the right

combination of options together, you can adjust the output to what you need. See http://

dev.mysql.com/doc/mysql/en/mysqldump.html for more information about mysqldump.

Restoring with mysqldump

Restoring from files created with mysqldump should be fairly straightforward. The restore

process doesn’t require you to shut down the database, but the default dump locks the tables

while they are restored. This can be disabled, but you probably don’t want someone making

an INSERT into that table during the restoration anyway.

Since the file contains a set of SQL statements, you can usually just send the contents of

the file into the MySQL client, like this:

shell> mysql <database> < database_backup.sql

And the table magically gets restored to its former state.

When you are creating the dump, if you do not specify any options, the file will contain a

DROP, CREATE, and set of INSERT statements for each table. If you send that file into the client, it

will re-create every table in the dump file with its state at the time of the dump.

However, maybe you don’t want to restore the entire database, but just need one table

restored. In this instance, you either need to create an individual dump file for that table or

parse through the database_backup.sql backup file and pull out the DROP, CREATE, and INSERT

statements for the table you need to restore. If you have a large database and your dump files

are many gigabytes, this process can take a lot of time. If you have some extremely large tables,

you may consider creating a few dump files as a part of your backup to ease the work needed

to restore the data. Typically, when a restoration is needed, you are under pressure and time is

constrained. It’s worth the extra work to create restore-ready files when the backup runs. As

we noted earlier, an important consideration when deciding what is right for your backup

implementation is looking at how the backup will be restored.

mysqldump Backup and Restore Example

Before we move on to the next option for backing up your MySQL database, let's look quickly

at an example. Suppose that your backup and restore plan, in its simplest form, was to create a

dump of the tables every morning at 6 a.m., and that you would create a dump of just your

orders table every hour, on the hour. It is important to have a recent copy of the cust_order

table, as your customer support folks are busy entering orders and hate having to reenter orders.

On your Unix box, you would create two entries in your crontab,1 as shown in Listing 17-2.

Listing 17-2. crontab Entries to Automate Backup

0 6 * * * mysqldump -A > /backup/full_backup-`date +%F`.sql

0 * * * * mysqldump shop cust_order > /backup/cust_order_backup-`date +%F_%R`.sql

1. A more secure solution is to create a Unix account for backups, with a matching, limited-privileges

(just enough to make a backup) MySQL account.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

■Tip If space is an issue, and your data dump files are large, you may want to add compression to your

backup process. To add bzip2 compression to the first crontab entry in Listing 17-2, use this statement:

mysqldump -A | bzip2 -c > /backup/full_backup-`date +%F`.sql.bz2.

If you put those crontab entries from Listing 17-2 in just before 6 a.m. and wait for a few

hours, an ls -1 /backup will show something like Listing 17-3.

Listing 17-3. Output of Backup Directory

full_backup-2005-08-05.sql

cust_order_backup-2005-08-05_06:00.sql

cust_order_backup-2005-08-05_07:00.sql

cust_order_backup-2005-08-05_08:00.sql

Now, your restore plan indicates that in the case where just the orders table has a problem,

you will restore it to the data from the most recent top of the hour. You don’t want to take the

entire database offline, but just want to replace all the data in that table.

The data in the cust_order backup file will look something like Listing 17-4 (we cleaned

out some statements for clarity). Note that because we haven’t specified to not include them,

the DROP TABLE and CREATE TABLE statements are in the file.

Listing 17-4. Output of mysqldump for the cust_order Table

-- MySQL dump 10.9

-- Host: localhost    Database: shop

-- ------------------------------------------------------

-- Table structure for table `cust_order`

DROP TABLE IF EXISTS `cust_order`;

CREATE TABLE `cust_order` (

`cust_order_id` int(10) unsigned NOT NULL auto_increment,

`ship_date` date default NULL,

`item_sum` decimal(10,2) default NULL,

`discount_percent` int(2) unsigned default NULL,

`shipping` decimal(10,2) default '0.00',

`total` decimal(10,2) default NULL,

PRIMARY KEY  (`cust_order_id`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table `cust_order

LOCK TABLES `cust_order` WRITE;

INSERT INTO `cust_order` VALUES (1,'2005-08-31','30.95',14,'3.25','29.87'),…

UNLOCK TABLES;

The command in Listing 17-5 shows that to restore the cust_order table to the way it was

at 8 a.m. is pretty simple.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Listing 17-5. Restoring a Single Table

shell> mysql shop < orders_backup-2005-08-05_08:00.sql

This runs all of the statements in the backup file into the MySQL database. The table is

dropped, created, locked, filled with data from the INSERT statement, and then unlocked.

■Note For those of you who are thinking that a backup and recovery plan that allows restored data to be

anywhere up to an hour old is a joke, hang on. We understand, and will get to ways to make sure your data

is brought up to the last second or statement before the destructive change. Information about restoring

using the binary logs is covered in the “Using Binary Logs for Up-to-Date Tables” section later in this

chapter.

Using mysqlhotcopy

If you are using the MyISAM storage engine, mysqlhotcopy may be the right choice for your

backup implementation. mysqlhotcopy takes advantage of the fact that MyISAM tables are

stored in separate files in the data directory on the file system, organized into a directory for

each database. mysqlhotcopy is a Perl script that locks tables through a Perl client connection

to the database and makes file system copies of the data while the tables are locked, which

prevents the tables from changing. After the files are copied, the locks are released.

The primary reason to use mysqlhotcopy over mysqldump is for performance. Using the

operating system to copy the data files to a backup location is significantly faster than creating

a set of INSERT statements for a table or database of tables. mysqlhotcopy is also pretty easy

to use.

However, mysqlhotcopy runs only on Unix and NetWare machines, and requires that the

database be stopped to restore a file from the backup. You must run the program on the

machine where the MySQL data files are located, which rules out being able to call it from a

remote server and place the files on that remote backup machine.

■Note mysqlhotcopy is a Perl script. It requires the Perl DBI module and DBD::mysql drivers to be

installed on your system.

Backing Up with mysqlhotcopy

To back up with mysqlhotcopy, you issue a command in the following form:

mysqlhotcopy <options> <db_name>[<./table regular expression/>] [<new database> |

<directory>]

The directory for saving the data files must exist before you run the program, or you will

get an error. Listing 17-6 shows the command in its simplest form, using two arguments to

create a copy of the shop tables in /backup/shop.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Listing 17-6. Simple Backup with mysqlhotcopy

shell> mysqlhotcopy shop /backup

The regular expression for table matching allows you to be more specific about which

tables to copy; for example, you could back up all of your tables having to do with your cus-

tomers. Listing 17-7 demonstrates the use of regular expressions in the command arguments.

Listing 17-7. Using a Regular Expression with mysqlhotcopy

shell> mysqlhotcopy shop./cust/ /backup

The output from mysqlhotcopy steps through what it’s doing, as shown in Listing 17-8.

Listing 17-8. Output from mysqlhotcopy

Locked 2 tables in 0 seconds.

Flushed tables (`shop`.`cust_order`, `shop`.`customer`) in 0 seconds.

Copying 6 files...

Copying indices for 0 files...

Unlocked tables.

mysqlhotcopy copied 2 tables (6 files) in 0 seconds (0 seconds overall).

Here, you see that the tables were locked, flushed, copied, and then unlocked. Looking at

the backup directory, you will find copies of the two tables, with the data, index, and data dic-

tionary files. Listing 17-9 shows the contents of the /backup/shop directory.

Listing 17-9. Listing of the /backup/shop Directory

cust_order.MYD

cust_order.MYI

cust_order.frm

customer.MYD

customer.MYI

customer.frm

■Note If you’ve ever used the SQL command BACKUP TABLE <table_name> TO '/directory', you’ll

notice that mysqlhotcopy performs a very similar action, although the mysqlhotcopy utility is run in the

Unix shell instead of MySQL client shell. BACKUP TABLE is deprecated, but it is still available in the current

builds of MySQL. RESTORE TABLE is the complementary command to BACKUP TABLE. It pulls the table from

the backup directory into the live database. Plans for MySQL version 5.1 include replacements for these

commands.

One other way that you can use mysqlhotcopy is to create a new database in the active

MySQL server, by specifying a database name instead of a directory when running the pro-

gram. An example of a command for making a new database is shown in Listing 17-10.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Listing 17-10. Creating a New Database with mysqlhotcopy

shell> mysqlhotcopy shop shop_old

This command creates a new database, shop_old, by creating the directory in the active

data directory and making a copy of the table files from the shop database into the new direc-

tory. Having the backup available as a live database may be helpful to the users of the data.

Also, at a minimum, it means you can access and look at the data as it stood when the data

was copied, without needing to perform a restore from the copied data files.

■Caution If you run mysqlhotcopy as any user other than the user used to run your MySQL server, the

file permissions on the newly created database won’t be right. The directory and table files created when

running the command in Listing 17-10 resulted in a shop_old directory and table files owned by the user

we were using to run the command. Before you attempt to use the table, you’ll need to change the permis-

sions on the directory and files.

The options for mysqlhotcopy allow you to change how you interact with the utility and its

behavior. The common options are shown in Table 17-2.

Table 17-2. Common Options in mysqlhotcopy

Description

Option

--addtodest

--allowold

--checkpoint=<db.table>

--chroot=<dir>

--debug

-n, --dryrun

--flushlog

-h, --host=<name>

--keepold

Rather than renaming the destination directory if it exists, add

new copies of files to the existing directory.

Instead of exiting with an error because the database directory

for backup of the tables already exists, rename the directory with

_old appended and continue.

Make periodic entries into this table to indicate progress.

The table needs to have the following columns: time_stamp ➥

TIMESTAMP NOT NULL, src VARCHAR(32), dest VARCHAR(60),

and msg VARCHAR(255).

Location of the base chroot jail directory where mysqld runs.

Provide a lot of extra information while copying the files,

including a dump of an object structure containing all the

tables found to be copied.

Go through the checks and processing, but don’t actually

perform any of the copying of data.

Once all the tables are locked, flush the logs.

The name of the server to connect to when running the copy

program via a TCP/IP connection. This can be an IP address or

DNS name, but must be the local server.

When --allowold is specified, the renamed _old directory

is removed at the end of the process. This option tells

mysqlhotcopy to skip the deletion of that directory.

--noindices

Do not include full index files in copy of tables.

Continued


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

-q, --quiet

Except for errors, don’t create any output.

--record_log_pos=<db.table> Make an entry in the specified table with slave and master

--regexp=<string>

Copy databases that match the regular expression.

Description

Copy the tables using the specified method. cp is currently the

only supported value.

Use the password provided on the command line to connect to

the database, or prompt for one on the terminal if the password

isn’t specified.

Use this port to connect to the database server on the local

machine.

status. The table must have these columns: host VARCHAR(60),

time_stamp TIMESTAMP(14), log_file VARCHAR(32), log_pos

INT(11), master_host VARCHAR(60), master_log_file

VARCHAR(32), and master_log_pos INT.

Once all the tables are locked, reset the binary log.

Once all the tables are locked, re-create the master.info file.

Connect to the MySQL server using this socket file on the local

machine.

Append this string onto the names of databases copied with

mysqlhotcopy.

Instead of using /tmp for temporary files, use this directory.

Connect to the database using this username. By default, MySQL

uses the account name of the current user.

Table 17-2. Continued

Option

--method=<name>

-p, --password=<password>

-P, --port=<number>

--resetmaster

--resetslave

-S, --socket=<file>

--suffix=<name>

--tmpdir=<dir>

-u, --user=<name>

mysqlhotcopy options.

Restoring with mysqlhotcopy

See http://dev.mysql.com/doc/mysql/en/mysqlhotcopy.html for more information about

The restore process for MyISAM files copied with mysqlhotcopy is pretty straightforward. You

want to make sure the database is not being used, by shutting down the database server, or

the tables are locked (with a READ lock). Then simply copy the files for the database or tables

from your backup directory into the MySQL data directory. You need to copy every file, includ-

ing the .MYD, .MYI, .frm, and .TRG files for the table. The easiest way to make sure you have

everything is to use a wildcard, as shown in Listing 17-11.

Listing 17-11. Restoring MyISAM Data Files with a Wildcard Character

cp /backup/shop/cust_order* /data/mysql/shop/.

After you’ve copied the files, make sure the permissions on the directories and files are

set correctly. The recommended setting is to have the directories and files owned by the user

running your server (we hope that’s mysql, not root), and to make the directories and files

accessible only to that user (chmod 700). Release the lock on the table, and you are up and

running with the previous version of the table.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

■Caution Remember that, if you copy individual tables into your database from a previous time, you may

leave records in other tables orphaned. For example, if your customer table has a number of recent records

that point to entries in your cust_order table, and then you restore the customer table to a previous state,

you will have cust_order records that do not have a corresponding customer record. This can lead to

numerous problems in the database and may affect the application as well (for example, you’re trying

to look at an order but the query returns nothing because it’s joined to the customer table and no

record exists).

Creating Backups of InnoDB Files

For folks who have been using MyISAM for years, the introduction of InnoDB and its mysteri-

ous ibdata1 file may have caused some uncertainty and reluctance to embrace the new storage

engine. Because InnoDB is a transactional, multiversioning, and self-restoring table type,

moving data to InnoDB may have felt like letting go of some of your control.

Using the innodb_file_per_table option brings some familiarity back, in that, rather than

storing everything in one large database file, the storage engine creates an individual .ibd file

for each table in the corresponding database-named directory within your data directory. This

also means you can interact with the tables independently, instead of needing to work with

the entire set of databases and tables in one large ibdata file.

The truth is, while InnoDB is a more full-featured storage engine, InnoDB tables are noth-

ing to be nervous about. The primary thing to remember is that, at any given point, there may

be uncommitted transactions that aren’t yet saved to the data files. Any interaction with the

files themselves requires all transactions to be complete and all tables to be locked.

InnoDB tables can be easily backed up with mysqldump, just like the other table types. Any

version of MySQL greater than 4.0.2 supports the --single-transaction option, which should

be used if you have InnoDB tables, because it will give you a consistent snapshot of your data-

base without needing to maintain a lock on the tables.

As with MyISAM tables, you can use other methods and tools specific to InnoDB tables

for creating backups.

Manually Backing Up and Restoring InnoDB Files

Before we look at some of the InnoDB-specific programs, we want to mention that you can

manually copy InnoDB data files. To do this properly, you need to shut down your MySQL

server. Once the database server is shut down, you can take a backup manually by copying

files (or letting your file system backup do the work). Once the database server is down, copy

the ibdata*, *.ibd, *.frm, ib_logfile*, and my.cnf files to an alternate location.

To restore to the state when the backup was taken, shut down the database, copy the files

that were backed up to their original location, make sure the permissions on the files are cor-

rect, and start up the database.

It is also possible to manually back up and restore individual tables if you are using the

innodb_file_per_table option, which creates individual data files for each table. To copy a

table file, you need to stop all activity on the table and make sure all transactions are commit-

ted. One way to do this is to obtain a READ lock on the table with LOCK TABLES <table_name> ➥

READ. However, be aware that issuing this LOCK statement is dangerous, because if there are


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

uncommitted transactions, it forces those transactions to be committed to obtain the lock. It

might be better to use other means to stop interaction with the table. Use SHOW INNODB STATUS

to verify that the database has no active transactions, and then copy the .ibd data file.

To restore a single InnoDB table, use the following set of steps:

1. Stop writes coming to the table.

LOCK TABLES <table_name> WRITE;

2. Remove the table.

ALTER TABLE <table_name> DISCARD TABLESPACE;

3. Copy the individual .ibd file into the appropriate database directory.

4. Re-create the tablespace.

ALTER TABLE <table_name> IMPORT TABLESPACE;

5. Release the lock.

UNLOCK TABLES;

Understanding how to manually copy the entire database or individual files means you

can perform the backup and restore tasks manually, or write a script to put together your own

mechanism for backing up and restoring InnoDB databases and tables.

Using InnoDB Hot Backup (ibbackup)

Although it is a commercial product, for a long time, the recommended tool for working with

InnoDB data files was InnoDB Hot Backup, or ibbackup. This utility allows you to create a

backup of a running MySQL InnoDB database, without any noticeable effect on the database

performance. You can purchase the license for InnoDB Hot Backup online from the InnoDB

web site (http://www.innodb.com/).

Note that innobackup, which is covered in the next section, may better meet your needs.

However, innobackup relies on ibbackup to back up the InnoDB data files, so having an under-

standing of ibbackup is helpful, even if you plan to use the other tool.

The process of creating a backup with ibbackup is simple: you create a second configura-

tion file that matches some of the configuration options from your live database, and use that

second configuration file to give ibbackup information about how and where to perform the

backup. Listing 17-12 shows a snippet of the InnoDB options from a my.cnf file.

Listing 17-12. Sample Options from a Live my.cnf for ibbackup

[mysqld]

datadir = /data/mysql

innodb_data_home_dir = /data/mysql

innodb_data_file_path = ibdata1:10M:autoextend

innodb_log_group_home_dir = /data/mysql

set-variable = innodb_log_files_in_group=2

set-variable = innodb_log_file_size=20M


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Listing 17-13 shows an example of a second configuration file, called mybackup.cnf, with a

few of the options changed.

Listing 17-13. Sample Options from mybackup.cnf for ibbackup

[mysqld]

datadir = /backup

innodb_data_home_dir = /backup

innodb_data_file_path = ibdata1:10M:autoextend

innodb_log_group_home_dir = /backup

set-variable = innodb_log_files_in_group=2

set-variable = innodb_log_file_size=20M

After you have the two configuration files in place, run the ibbackup command. Listing 17-14

shows how the command is formatted, using the live and the backup configuration files.

Listing 17-14. ibbackup Command and Arguments

shell> ibbackup /etc/my.cnf /etc/mybackup.cnf

This command will generate some output to show its progress. It will finish with a statement

that the backup has completed. If you then do an ls -1 /backup (from where the mybackup.cnf file

indicated to put the backup), you’ll see a log of the backup and all of your data files. Listing 17-15

shows the contents of /backup. Note that ibbackup will not overwrite files, so before you run the

utility, you’ll need to make sure the contents of the backup directory are copied elsewhere or

removed.

Listing 17-15. Contents of the backup Directory

ibbackup_logfile

ibdata1

ibdata2

The process of restoring from an ibbackup backup involves two steps, and it takes an unusual

approach to restoring data. Instead of moving files into the data directory, you use the backup

configuration file as the main configuration file and run MySQL off the data files in the backup

directory. So, rather than having a backup directory, you have several data directories that you can

switch between, or use a symbolic link for your primary data directory. This also means that you

are required to take a snapshot of your other, non-InnoDB tables and put them in the data direc-

tory. Unless you do this, you won’t have all your data in the new directory when making it your

live MySQL data directory.

First, apply the ibbackup_logfile to the backed-up data files. This rolls the data files for-

ward to make them consistent with the log files. Applying the log file is a simple command, as

shown in Listing 17-16.

Listing 17-16. Applying the Log File to Data Files

shell> ibbackup --apply-log /etc/mybackup.cnf


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

After you have the data files ready, stop MySQL and start it using the configuration file

that was used to create the backup, as shown in Listing 17-17.

Listing 17-17. Moving MySQL to Backed-Up Data Files

shell> /use/local/mysql/bin/safe_mysqld --defaults-file=/etc/mybackup.cnf

We’ve provided an extremely limited overview of the ibbackup utility. Many command

arguments and options are available to customize the backup. For example, you can specify

compression, regular expression matches on table names, and to suspend the backup at the end

for additional processing. Refer to http://www.innodb.com/manual.php for more information.

Using innobackup

Although ibbackup has been around for a while, in most cases, it’s no longer the best choice

for backup when you consider that you need to do some scripting to have your non-InnoDB

tables added to the backup. The innobackup program was written to allow you to back up

both your MyISAM and InnoDB table types. The reason we say “in most cases” is because

innobackup issues a FLUSH TABLES WITH READ LOCK statement to get a snapshot of the non-

InnoDB tables. If you have large MyISAM tables or long queries against the MyISAM tables,

this command could cause a significant interruption in database availability.

The way that innobackup backs up and restores files is very similar to how ibbackup works,

except it includes all of the database, including database directories and all .frm, .MYI, and .MYD

files. Although innobackup is open source, it works by first running ibbackup. You are required to

have a licensed copy of ibbackup to run the database backup.

To create a backup, first create a second configuration file, just like the one shown earlier

in Listing 17-13, to be used by ibbackup. Then use the innobackup script, passing it a user, a

password, the configuration file location, and a backup directory, as shown in Listing 17-18.

Listing 17-18. Backup Using innobackup

innobackup --user=<username> --password=<password> /etc/mybackup.cnf /backup

The innobackup script will create a new directory in /backup, using the current date and

time, and place all of the database directories and files within that directory. Listing 17-19 shows

that, unlike the /backup directory contents for ibbackup, an ls -1 /backup/2005-08-15_13-27-09

(the backup directory) shows all of your database directories and files.

Listing 17-19. Contents of the innobackup Backup Directory

backup-my.cnf

ibbackup_logfile

ibdata1

ibdata2

ib_logfile0

ib_logfile1

mysql

mysql-stderr

mysql-stdout

test


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

As a part of the backup, innobackup creates the backup-my.cnf file with the current data-

base options. Also, the mysql-stderr and mysql-stdout files are created and contain messages

generated during the backup.

The restore process is similar to the process for ibbackup. It first requires running the logs

forward, as shown in Listing 17-20. Note that you need to specify the directory with the date

and time for the desired backup.

Listing 17-20. Applying Log Files to InnoDB Data Files

shell> innobackup --apply-log /etc/mybackup.cnf /backup/2005-08-15_13-27-09

After you’ve applied the log files, you must create a new configuration file, with the

options in your backup configuration (/etc/mybackup.cnf) and those saved by innobackup

into backup-my.cnf. A simple cat command, as shown in Listing 17-21, will do the trick and

create a valid configuration file for running the MySQL server.

Listing 17-21. Creating the Complete Configuration File for ibbackup

shell> cat /etc/mybackup.cnf /backup/2005-08-15_13-27-09/backup-my.cnf >\

/backup/2005-08-15_13-27-09/my.cnf

Now that you have a complete configuration file, you can start the database using the

backed-up structure, index, and data files. Listing 17-22 shows the appropriate command.

Listing 17-22. Moving MySQL to Backed-Up Data Files

shell> /use/local/mysql/bin/safe_mysqld \

--defaults-file=/backup/2005-08-15_13-27-09/my.cnf

We’ve provided the basics of using innobackup, but we have not covered all of the options

available. Refer to http://www.innodb.com/manual.php for more information about innobackup

options.

Using MySQL Administrator

Our last stop on the backup options tour is MySQL Administrator. This is a GUI tool that is

available for Windows, Linux, and Macintosh systems. We introduced MySQL Administrator’s

User Administration section in Chapter 15. MySQL Administrator also includes a set of inter-

faces to back up and restore data in your MySQL database. MySQL Administrator can connect

to a local database or run remotely and connect using TCP/IP.

■Note In Chapter 15, we used the Linux version of MySQL Administrator for interacting with the database.

In this chapter, we use the Mac OS X version to give you a sense of the differences. The most notable differ-

ence is that the major functional areas are in a bar across the top of the GUI in OS X, rather than on the left

side, as they are in the Linux program.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

The output generated by the MySQL Administrator Backup utility is like that of mysqldump.

Your backup file contains a collection of DROP, CREATE, and INSERT statements that are used to

re-create the table as it was at the time of backup.

Although the MySQL Administrator makes backing up your data simple while you’re at

the GUI, we don’t recommend that you use this method as a replacement for a scheduled

backup. Either use the scheduling functionality of MySQL Administrator to schedule a regular

backup of your data or set up a cron entry to do a regular backup.

Making Backups with MySQL Administrator

As shown in Figure 17-1, the MySQL Administrator Backup tool has a Project tab that allows

you to define projects. After you start up the MySQL Administrator and go through the steps

of connecting to your database (as described in Chapter 15), click on the Backup option in the

navigation bar. In this example, we’ve already connected to the MySQL server that pulled the

list of databases and tables into the tool. With the click of a mouse, you can create new proj-

ects and associate any number of databases or tables to be a part of the backup.

Figure 17-1. Project tab of MySQL Administrator Backup


![R3175](images/R3175)


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

To customize the output in the dump file created by the Backup utility, click the Advanced

Options tab. As you can see in Figure 17-2, you have some control over how the backup runs

and what is put into the backup file. These options are a subset of those available for the

mysqldump utility. Refer to Table 17-1 for more information about the mysqldump options.

Figure 17-2. Advanced Options tab of MySQL Administrator Backup

After you’ve chosen your backup project and tweaked the output accordingly, click the

Start Backup button to create a backup file. You will be prompted to specify a backup location

and filename on your local machine, as shown in Figure 17-3.

Figure 17-3. Prompt for backup directory and filename

After you’ve specified where to save the backup, click Start Backup. That’s all you need to

do to make your backup with MySQL Administrator.


![R3183](images/R3183)


![R3182](images/R3182)


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

The Windows and Linux versions of MySQL Administrator have an area for scheduling

daily, weekly, or monthly backups. (We hope this feature will soon be available in the Mac OS

X version.) For more information about backup scheduling with MySQL Administrator, refer

to http://dev.mysql.com/doc/administrator/en/mysql-administrator-backup-schedule.html.

Restoring with MySQL Administrator

With a backup file on your local system, it’s simple to restore the entire set of databases or any

selection of tables. From the MySQL Administrator main window, click Restore to go to the

Restore section. On the General tab, choose the backup file you want to use for the restoration.

Figure 17-4 shows this tab and the available options, including ignoring SQL errors and creat-

ing databases (schemas) on the fly if necessary during the processing of the backup

statements.

Figure 17-4. General tab of MySQL Administrator Restore

Once you’ve chosen the backup file and specified the options, you should move to the

Selection tab, where you can choose the databases and tables to restore when running Restore.

Figure 17-5 shows this tab.

When you’ve chosen the databases and tables you would like to restore, click the Restore

Backup button, and the statements will be run against the MySQL database.


![R3190](images/R3190)


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

For more information about MySQL Administrator, see http://dev.mysql.com/doc/

administrator/en/mysql-administrator-introduction.html.

Figure 17-5. Selection tab of MySQL Administrator Restore

Using Binary Logs for Up-to-Date Tables

Throughout this chapter, we’ve stopped the process of restoring data at the point where the most

recent backup file was restored. In some cases, this is okay; in other cases, it is not acceptable. In

the projects we’ve worked on, restoring data that is hours or days old is not acceptable.

In the instances where you need your data to be more up-to-date than the last backup,

MySQL’s binary log files are your key to bridging that gap. Binary logs are enabled with the

log-bin option in your server configuration file, which causes any statement that changes

the data to be written to the binary file. (See Chapter 14 for details on configuring MySQL.)

To make using the binary log easier, we recommend that each time you take a backup of

the database, you flush the binary logs, which you can do with the FLUSH LOGS SQL statement

or the RESET MASTER command. Flushing the logs creates a new log file in the series, each

numbered incrementally. Resetting the master removes existing binary log files and starts a

new one. The option to restart with a new binary log file is available with many of the backup

tools, which makes them easier to use (see the options listed in Tables 17-1 and 17-2). If you

start a new binary log file as a part of your backup (or immediately after), it will make bringing

the data forward in time much easier.


![R3197](images/R3197)


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

To bring all of the databases in your server up to the last statement before you restored

the data, use the mysqlbinlog tool to create text SQL statements from the binary log and pipe

them to your database, like this:

shell> mysqlbinlog <binlog file> | mysql

If you’re in the situation where you are restoring only a particular database, or need to

stop at a certain point in the log file before you get to the DELETE statement that wiped out the

table, mysqlbinlog has options to control the statement output. Listing 17-23 demonstrates

the use of these options.

Listing 17-23. Limiting the mysqlbinlog Output

shell> mysqlbinlog --database=shop --stop-position=4193 <binlog file> | mysql

The options given to mysqlbinlog in Listing 17-23 will ensure that only statements des-

tined for tables in the shop database are sent to MySQL, and that the statements will stop

when the log position reaches 4193, the position of the binary logs immediately before a

destructive statement was issued. You can find the log position by running the mysqlbinlog

tool on the binary log file and piping the output to grep or sending it into a file for text-based

searching.

■Note If you want to control the output of mysqlbinlog to include only statements for a specific table,

you will need to write your own utility to grep for those statements. mysqlbinlog does not offer a --table

option.

Review the statements in the binary log that come after the unwanted statement. You may

want to process those as well if they affect other tables. Do this by finding the binary log posi-

tion after the problem statement and run the same statement from Listing 17-23, but use the

--start-position option, setting it to the binary log position of the next statement.

Refer to http://dev.mysql.com/doc/mysql/en/mysqlbinlog.html for more information

about mysqlbinlog options.


C H A P T E R   1 7   ■ B A C K U P  A N D   R E S TO R AT I O N

Summary

In this chapter, you’ve seen the great deal of flexibility you have in implementing a backup

and restore strategy for your MySQL databases. However, before you think about the technical

details, consider how your backups and restorations will be a part of your organization, and

get the right people around the table to discuss the requirements. Be sure to document the

conversation and review the document periodically to make adjustments.

Regardless of the table type, you have several options for how to get the data out of the

database to store in an alternate location. For each of the methods to back up data, there is a

process to use the backup files for a restoration. Backup tools and restore tools both give you

a lot of options for customizing the way data is formatted and processed. Being aware of these

options helps in planning and implementing the backup and restore procedure. If you find

that your backup plan requires some hybrid combination of several tools, or repeated use of a

single tool for each database, you might consider writing your own backup script that calls on

any of the existing tools.

General discussions of data backup and restore topics often refer to these tasks as

uninteresting, boring, tedious, and worse than a needle under your fingernail. Yes, there are

probably more exciting things to be involved with, but there’s no reason why procedures for

protecting your data can’t be interesting as well. We hope that, as you’ve read this chapter,

you’ve gotten a sense of how this process can be more than a mundane, last-minute, and

dreaded responsibility.


C H A P T E R   1 8

■ ■ ■

Replication

Imagine, for a moment, that there was a single, physical phone book for the entire country

where you lived. This phone book was housed in a building in one city, and had specific hours

in which you were permitted to visit. Imagine that phone numbers weren’t available from any

other source. To look up a friend’s phone number, or find the number to call to make a reser-

vation for dinner, you’d be required to travel to the phone book building, get in line, and wait

for your turn to flip through the pages. You might imagine that over time, special services

would arise in which you could call in a request to the phone book office or a third-party serv-

ice that would retrieve the number for you. You might argue that this arrangement makes

having the phone book pointless, and the data stored in the book of little value to anyone who

needs immediate access to the data, or who doesn’t live within close proximity to the phone

book office.

Much like our phone book example, organizations or applications often require multiple

instances of their database, either within the same physical space for scalability or redun-

dancy, or spread halfway around the world for geographic diversity. In either case, the data

needs to be available in multiple instances to provide value to the organization. Although

issues with geographic diversity can sometimes be solved with good network connections,

there are plenty of cases in which having a separate instance of the data better serves the

needs of the organization.

Fortunately, we don’t live in a world where data has to be confined to a single physical

location. With replication, a MySQL database can exist partially, or in its entirety, in many dif-

ferent locations, with each replicated instance following close behind the primary database.

In the context of databases, replication means creating a copy of the data in an alternate

location. In most instances, this means the data is available via a second or third server, either

in the same location or a geographically separate location. However, there’s nothing to prevent

you from using replication between two databases on a single server. Replication is as much

about having an alternate copy as it is about active synchronization of the data, either real-

time or at some interval. The goal of replication is to make data from one database available in

more than that one place.

Replication in MySQL can be fairly simple to set up, depending on the complexity of your

replication requirements. For a single replicated database with a small amount of data, you’re

just a few commands away from having a replicated database—but more on that later.


C H A P T E R   1 8   ■ R E P L I C AT I O N

By the time you’ve completed this chapter, you’ll have learned about the following topics:

• What replication is

• Why you should replicate data

• What replication doesn’t solve

• How to plan for replication

• How MySQL implements replication

• Setting up replication initially

• Understanding your configuration options

• Monitoring and managing MySQL replication

• Replication performance

• Examples of replication

mean by replication.

Without further delay, let’s start our look into replication with a discussion of what we

What Is Replication?

Depending on your previous experience with replication, you may have some ideas about

what it means to replicate your data between servers or systems. Data replication tools are

available in most widely used database systems (Oracle, SQL Server, Sybase, PostgreSQL, and

so on), but the feature sets and management tools of each system vary.

Terminology

The terminology for replication varies between database systems. However, all seem to split

the replicated databases into two groups: databases that provide data and databases that con-

sume data.1 You might think of these groups as some databases exporting their data and other

databases importing data. To further complicate replication, you can set up a database to pro-

vide data to another database while at the same time being a consumer of data. We’ll get into a

few configuration examples later in the chapter to illustrate why and how you might use a

database as both data provider and consumer. Terminology to describe the process of repli-

cating data varies between different vendors. In MySQL, databases that are replicated from, or

that export their data, are called masters. Databases that replicate the data, or import it from

another server, are called slaves.

1. SQL Server separates databases into publishers and subscribers, but also has a third player called the

distributor. The distributor isn’t a database, but a process that can run independently on a separate

machine to move data between publishers and subscribers.


C H A P T E R   1 8   ■ R E P L I C AT I O N

REPLICATION TERMINOLOGY

If you’re new to replication, or are coming from another database system, you might not be familiar with the

replication terminology in MySQL. Following is a list of terms with corresponding definitions:

• Master: A database that serves as the primary source of data for other databases. A master exports

data to another database.

• Slave: The slave replicates, or imports data changes, from another database.

• Snapshot: A snapshot refers to making a point-in-time copy of the data on the primary database to be

moved to a slave database. Creating a snapshot gives a starting point for replication to move forward.

• Merge or multimaster: Merge or multimaster replication is a concept in which a system has multiple

databases that feed each other updates. MySQL doesn’t support this.

Synchronous vs. Asynchronous Replication

Before we talk about the feature sets of replication systems, note that, regardless of a system’s

features, the databases are kept in sync either synchronously or asynchronously. MySQL’s

replication implementation is asynchronous, meaning that the data in the replicated systems

lags behind that on the master, anywhere from fractions of a second to several seconds. Let’s

look more closely at the differences between the two synchronization types.

Synchronous Replication

In synchronous replication, the data is committed to the primary database as well as the repli-

cated database as a part of the same transaction. This is also known as dual commit or dual

phase commit. The transaction is written and committed on both the master and the slave as

a part of the transaction. In synchronous replication, the primary database and all replicated

databases are always in sync. Figure 18-1 visually represents the process of synchronous

replication.

Client

Client issues query

Master

Database

Slave

Database

Query executed on master

Query executed on slave

Query committed on master and slave

Status returned to client

Figure 18-1. Synchronous replication


C H A P T E R   1 8   ■ R E P L I C AT I O N

As you can see in the diagram in Figure 18-1, the query is executed on both the master

and the slave, and then committed on both before the client receives the return status. With

the query changing data in both places before returning a response, all databases in the envi-

ronment are kept in sync.

Asynchronous Replication

Asynchronous replication means that a query isn’t picked up on the replicated servers until

after the transaction is complete on the primary database. Typically, a process pulls or pushes

data changes from the primary database at a scheduled interval and makes those changes in

the replicated system. In MySQL, data is pulled from the master by a process on the slave after

the master has completed the query and made an entry in the binary log.

With asynchronous replication, the replicated databases are always some amount of

time behind the primary database. The amount of time depends on numerous factors: how

frequently the replication process grabs updates, how much data must be transferred to the

replicated systems, and how fast the network will allow the data to move between those sys-

tems. Figure 18-2 shows the flow of data in asynchronous replication.

Client

Client issues query

Master

Database

Slave

Database

Query executed on master

Status returned to client

Query copied to slave via separate process

Query executed on slave

Figure 18-2. Asynchronous replication

Figure 18-2 illustrates how an asynchronous replication system processes the query on

the master server and returns status to the client before the query is replicated on the slave.

At some future point the query is pulled to the slave and executed. Again, we want to point

out that MySQL replication is asynchronous, the flow of data matching that in Figure 18-2.

One-Way vs. Merge

Replication technology lives on a continuum that goes from simple to complex. Each database

vendor has its own set of tools to accomplish replicating data from one system to another.

Some of the tools are sophisticated, and include endless configuration options for controlling

and optimizing the data moving between your systems. Others are fairly simple, giving just

enough control to set up the system and let it take over.


C H A P T E R   1 8   ■ R E P L I C AT I O N

At the simpler end of the continuum are replication mechanisms that provide read-only

copies of the data, or one-way replication. In a one-way replication arrangement, all updates

to the database are directed to the master server, and then those changes are pulled down to

the replicated databases. The communication is one-way in that any change on a slave is

never communicated back to the master.

It is possible to set up a replication system in which a segment of your databases or tables

is replicated from a master and some tables are maintained locally. In that case, local data

changes to the nonreplicated tables on the slave won’t cause problems. Otherwise, if you’ve

got a set of replicated tables, you shouldn’t make updates on the slave, as the updates may

cause problems with future updates from the master, and the data will most likely be lost the

next time you do a complete refresh of the data.

In more advanced database replication systems, replication allows for both reading and

writing in the replicated database, and provides a mechanism to merge changes from multiple

databases into every other replicated database. Having multiple primary databases, with reads

and writes happening in each, presents some interesting problems. The replication software

has to make decisions about which records take precedence when there are conflicts.

MySQL’s replication falls on the simpler end of the spectrum, and doesn’t provide data

merging in its replication feature. Data is replicated to read-only servers. If changes are

made in the replicated data, they aren’t replicated back to the master. More information

about enabling merge replication in MySQL is available at http://dev.mysql.com/books/

hpmysql-excerpts/ch07.html#hpmysql-CHP-7-SECT-7.3.

Why Replicate Data?

Before running out and setting up a server to replicate your data, it’s good to consider what

role replication will play in the requirements of your database or database-backed applica-

tion. In many instances, replication is just the thing you’ve been looking for, and will make a

huge, positive impact on your system. However, in some cases it can be more hindrance than

help, as discussed in the section “What Isn’t Solved with Replication.” Let’s look at a few areas

where MySQL’s replication may help.

Performance

Having replicated databases can improve performance of your application. Perhaps you want

to be able to spread the load of database queries across several database servers. If you’re at a

point where the CPU or memory on your database server has peaked, or the network traffic

for database transactions is reaching capacity, you may find that replicating your data onto

several machines and balancing queries across multiple machines improves your database

response.

Even if you don’t have ongoing demand for performance improvements provided by

replication, sometimes providing a separate database for certain users or specific queries can

offer a great deal of relief for your primary database. Reporting or summary queries can be

extremely intensive, and can slow or stop other queries to those tables. Replicating the data,

and moving user accounts or pointing reporting tools to the replicated data, can be of great

benefit to the primary database.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Geographic Diversity

Replication is a good way to solve situations in which data is needed in multiple locations.

Perhaps you have offices located across the country or around the world and need to provide

a local copy of the data for each office. Using a replication mechanism could allow each office

local access to its data, but also make its data available to other offices, and vice-versa.

Limited Connectivity

If you have inconsistent network availability, replication may be a way to provide more uptime.

Perhaps you have customers in a certain part of the country with an intermittent pipe to the

public Internet, but a very good network within their region. Setting up a database within the

region that replicates off a master when the connection is up gives your customers a constantly

available database. The data is only as current as the latest successful connection to the master,

but the database is always available for use within the region.

Redundancy and Backup

A replicated database is an excellent way to provide redundancy and high availability. Having

one or more slave databases running all the time means that you can roll onto one of the slave

servers in the instance of a machine failure or disaster. You can do the switch manually, or you

can program the application to make the switch if the primary machine isn’t available.

In addition to providing redundancy, a replicated database is an excellent stand-by

backup for instances where you need to restore from a backup. Unlike a nightly dump of the

data, the replicated data is as current as the last statement read from the binary log on the

master database, which is likely to be more current than your most recent backup. Using a

replicated server as a backup means your backup is constantly updated, and if your primary

database server goes down you’ve got an almost-current copy of the database ready to start

the restore process.

■Caution Be careful when relying on a replicated database for restoring data. If you’re attempting to

restore data from an accidental query, the data change will likely happen in the slaves before you can get to

them to restore the data. Using replication as a backup is more appropriate for instances in which a restore

is required after a disk or server failure.

Storage Engine and Index Optimization

Replication can allow you to take advantage of multiple storage engines for a single table or

database. What does that mean? With replication it’s possible to use one table type on the

master and another table type on the slave. Perhaps you want to have foreign keys, which are

only allowed using the InnoDB and BDB table types, but you also want to be able to use the

full-text indexing feature of the MyISAM table type. Because replication simply executes

queries from one server on another server, it’s possible to have the master database use

InnoDB tables, which provides referential integrity. You can alter the tables replicated to the


C H A P T E R   1 8   ■ R E P L I C AT I O N

slave to be MyISAM, including the definition of full-text indexes. If you wanted to run queries

against the full-text index, you would send those queries to the slave with the MyISAM tables

and full-text index. Presumably, you’d use the InnoDB features on the master to enforce data

integrity, but get the advantages of the MyISAM performance, and so on.

We’ve hinted at it with the full-text indexes in our multiple-storage-engines example, but

it’s worthy to note that a slave database can have a different set of indexes than the master.

This can be helpful if you have fundamentally different methods for accessing the data that

require multiple indexes on a single table. Spreading those indexes across two different data-

bases and sending the queries to the appropriate machine can mean reduced index sizes and

improved performance.

What Isn’t Solved with Replication

Replication can be helpful, and necessary in many situations, but it doesn’t solve every prob-

lem. Just to give a few examples:

• Replication doesn’t solve data validation or integrity problems. Whatever changes are

made to the master database are also made in the slave.

• As cautioned earlier, using replication as a backup system to restore data from acciden-

tal updates or deletes doesn’t work. Because a replicated server has most likely executed

the same query within seconds of the master, going to a slave to retrieve records that

were accidentally updated or deleted on the master proves unsuccessful.

• Because MySQL replication is asynchronous, it isn’t useful in a system where data is

needed in real time by the slaves.

• By default, replication in MySQL doesn’t allow you to merge data from two different

servers into one. If you have updates happening in two databases and you need to rep-

resent them in one, you might be better served by replicating the separate databases

and then creating a view that brings the tables together. See Chapter 12 for more infor-

mation on views in MySQL.

• Replication in MySQL doesn’t natively give you the ability to run updates in two differ-

ent databases and have them reflect each other’s changes by replicating each other.

This is also known as multimaster replication.

You now should have a sense of what replication can and can’t do, and why you might

embark on creating replicated data in your environment.

Planning for Replication

Before we leave the replication why and get into the how, we encourage you to stop and think

about how replication fits into your organization. When looking at how to build replication

into your system, or expand a system to include replicated data, you should think about how

you can go about fully understanding the requirements. We encourage you to identify the

owners of the data and gather their expectations for the data in the system.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Armed with that knowledge, consider the things replication can and can’t do, and work

with the stakeholders to develop a technically viable policy on replicating data. Go through

things such as the requirements for synchronization and privacy. Help the stakeholders

understand the possibilities available through replication and the process of establishing and

maintaining a system with replicated data. Together, document a policy for replicating data

that is technically possible and meets the requirements of your organization.

Armed with the policy, put together an implementation plan that includes information

on the details of where and how the data is replicated. Good documentation of this plan will

serve as a fallback when you’ve been focused on other things and don’t recall the details, as

well as an aid for anyone who has to step in to help with implementation or problems in the

system.

We understand it’s rare to be a database administrator or application developer who loves

to write documentation, especially on something as nontechnical as policies. Hopefully, the

potential gains from having the process documented will be motivation enough to forge

through well-written policy and implementation documents. This will ensure that as you

move forward, you remain on the right track and don’t cause a lot of extra work for yourself

or others by not having documentation available for clarification.

How MySQL Implements Replication

In its simplest form, MySQL’s replication moves data from one database to another by copying

all the queries that change the data in one database and running those exact statements in the

replicated database. In effect, the slave databases are shadowing the master database by copy-

ing the master’s queries.

■Note Replication has been available since version 3.23.15, but underwent some significant changes in

4.0.2. If you’re attempting to set up replication that involves versions prior to 4.0.2, see MySQL’s documenta-

tion on replication for more information on replication with earlier versions of MySQL.

Binary Log

How does replication actually work? That’s what we’re here to look into. You’re probably famil-

iar with the binary log, a logging mechanism that keeps track of all changes in your MySQL

tables. Because replication relies on the binary log, you must enable it with the log-bin option

in your database startup to successfully replicate data. Chapters 4, 17, and 20 talk about the

binary log a bit, but in different contexts, so we’ll do a quick review here, keeping replication

in mind.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Every time a query makes a change in your database, or has the potential to make a

change, that query is executed and then appended to the binary log.2 Test this by issuing the

statement in Listing 18-1 in your MySQL client.

Listing 18-1. DELETE Statement to Test Binary Log

DELETE FROM customer;

After you’ve issued the statement, check the last entry in the binary log. If you aren’t

familiar with the binary log file, it’s in your data directory. By default, if you haven’t specified

it in the options, it’s named <server name>-bin.00000x (the currently active binary log is the

highest numbered). It’s necessary to use the myslqbinlog tool included with MySQL to convert

the binary to ASCII to make it readable. You can see that the last entry in the binary log looks

like that of Listing 18-2, except your time will be different.

Listing 18-2. Last Statement in Binary Log

# at 716

#050319 12:07:21 server id 1  end_log_pos 793   Query   thread_id=120   exec_time=0

error_code=0

USE shop;

SET TIMESTAMP=1111252041;

DELETE FROM customer;

As you can see in Listing 18-2, the last item in the binary log is the DELETE statement.

There are a few other pieces of information. First, the log entry tells us the position of the

binary log when starting: #at 716. The next line gives us, among other things, the time, the

server number, the binary log position at the end of the statement, the time it took to execute

the query, and if there was an error. The binary log then includes a USE shop; statement to

ensure you’re in the right database, a SET TIMESTAMP statement to adjust the time to the time

this statement was entered, and the actual SQL statement that was processed. As you might

sense, this information all comes in handy when attempting to keep another database in sync

with this one. It’s as if you could copy these five lines to another identical database and see the

same changes in the data on the other database. Series of statements that are part of a trans-

action are written to the binary log once the transaction has successfully completed. Transactions

that fail and roll back, or are rolled back manually, don’t change the data and thus aren’t written to

the binary log.

Because we’re here to talk about replication, we won’t explain the binary log further, but

you can find more information in the MySQL documentation at http://dev.mysql.com/doc/

mysql/en/binary-log.html.

2. As of MySQL version 4.1.3, any statement that could potentially change data, like a DELETE where no

rows were matched, is still written to the binary log.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Replication Process

Now that you’re familiar with the binary log, and we’ve hinted at how the binary log might be

used in replication, let’s look at the steps that happen when data is replicated to another server:

1. INSERT, UPDATE, DELETE or some other data-changing query is issued to the master

database.

2. The query is parsed, executed, and written to the binary log on the master.

3. The I/O thread on the slave asks for new queries from the I/O thread on the master,

and pulls anything new from the binary log on the master into a log on the slave called

the relay log.

4. A processing thread on the slave reads the relay log and executes the query.

The simple explanation is that for any data change on the master, an entry is made into

the binary log. That statement is copied to the slave and executed there as well, making the

exact change to the slave as was made on the master and thus keeping the data in sync.

We hinted at different threads in these four steps. Running a replication slave requires

three threads, in addition to those already used to keep your database’s non-replication-

related features running. Two threads run on the slave, the first to communicate with the

master for entries in the master’s binary log and to pull the statements onto the slave

machine. The second slave thread reads the queries in the relay log (which were pulled from

the master) and processes them. The third thread runs on the master and is responsible for

communicating changes in the master’s binary log. If you have multiple slaves pointing at a

single master, the master will run a separate thread to communicate with each of the slaves.

Relay Log

The binary log is the master’s representation of changes in the data. As you’ve seen in the

replication steps, the entries in the master’s binary log get copied to the slave. Where do those

statements go?

The queries pulled from the master are stored in what’s called a relay log, named some-

thing like <machine>-relay-bin.00001. The relay log files typically reside in your data directory,

but you can specify to have them stored elsewhere. The relay log is a delayed copy of the mas-

ter’s binary log, and you only see it in your data directory if the database is set up to run as a

slave of another database. If you’re running replication, the relay log will grow at the same rate

as the binary log on the master. In fact, the format of the binary log and relay log are the same;

you can view the text version of the relay log by using mysqlbinlog on the relay log file. Watch-

ing the entries in the relay log can give you a rudimentary sense of what data is being

replicated to your database, and how quickly.

As of MySQL 5.0, a new relay log is created each time the I/O thread starts (prior to 5.0,

a new log was created only on the first startup). You can control the size of relay logs by the

max_relay_log_size, a new file being generated when the size of the currently active log file

reaches the specified limit.

Unlike the binary log, MySQL automatically purges the relay logs when the slave no

longer needs them (because every statement has been processed in the database).


C H A P T E R   1 8   ■ R E P L I C AT I O N

info Files

When running replication, two new files appear in your data directory: master.info and

relay-log.info. MySQL uses these files to save information about your replication state,

and they’re used when MySQL starts up, if they’re available.

■Caution MySQL considers the information contained in the master.info and relay-log.info file

before looking for settings in the configuration files. This means that changes in your my.cnf file may be

ignored, if the information is stored in the info files.

Both of these files provide information about the configuration and status of your replica-

tion, but shouldn’t be used as configuration files to make changes. The primary purpose for

these files is to keep state information between database restarts, and for database backups.

The slave threads control both of these files, and you should only use them for information.

You can make changes to these files with the CHANGE MASTER command, which is discussed in

more detail in the section “CHANGE MASTER.”

master.info File

The master.info file contains a number of lines detailing the configuration and status of

the master database. The information in this file, and much more, is also available with the

SHOW SLAVE STATUS command, which is covered in the section “SHOW SLAVE STATUS.”

Listing 18-3 shows a sample master.info file.

Listing 18-3. Sample master.info File

master-database-bin.000002

master-database.example.com

replicate

r3p1!c8

(6 blank lines removed)

In Listing 18-3, we’ve removed six blank lines that are place holders for SSL information.

The complete listing of entries in the master.info file is shown in Table 18-1. Lines 9 through

14 contain information about the use of SSL connections for the replication threads.3 These

lines may be blank if values aren’t specified on startup.

3. The SSL connection options are new to the master.info file as of MySQL version 4.1. Previous versions

of MySQL included only seven lines, represented by lines 2–8 in Table 18-1.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Table 18-1. Line Descriptions for master.info File

Line Number

Example

Description

master-database-bin.000002

master-database.example.com

replicate

r3p1!c8

0 or 1

master.cert

ALL:-AES

master.key

Indicates to the I/O thread how many lines of

data are in the file.

The name of the current binary log file on the

master.

The read position of the I/O thread in the binary

log file on the master database.

The DNS name or IP address of the master

database.

The name of the user for connections to the

master for replication.

The password used when connecting to the

master database. This is not shown in the

SHOW SLAVE STATUS command.

Port number for connections to the master.

Number of seconds to wait until the connection

to the master is retried.

Boolean value that indicates if SSL is allowed on

the master.

Name of the master SSL certificate file.

List of ciphers allowed in SSL encryption,

separated by a colon.

Name of the master SSL key file.

/data/mysq/ssl/master-ca-list

Path to a file containing a trusted CA.

/data/mysql/ssl

Path to the directory where CA certificates exist.

relay-log.info File

The relay-log.info file contains information about the state of the thread that is responsible

for reading and processing the statements in the relay log. Listing 18-4 shows a sample file.

Listing 18-4. Sample relay-log.info File

./slave-database-relay-bin.000054

master-database-bin.000002

As you can see, the relay log information file contains four lines. A sample and description

of these lines are shown in Table 18-2.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Table 18-2. Line Descriptions for relay-log.info File

Line Number

Example

Description

./slave-database-relay.bin.000034

master-database-bin.000002

Name of the master log that is being read.

Name of the file to read for pulling in

queries.

Position in the relay log file where the

thread is currently reading.

Position in the master binary log where the

thread is currently reading.

■Note The master.info and relay-log.info files aren’t the only flat files that appear in your data

directory. Under normal operation, MySQL keeps a <machine>-bin.index to help it keep track of the binary

log files. The same is true for replication. If you’re replicating data from a master machine, the slave will

keep a <machine>-relay-bin.index file in your data directory to help MySQL keep track of the existing

relay log files.

Initial Replication Setup

We’ve been through a lot of discussion about creating policies and implementation plans for

replication, and have looked at the details of how MySQL accomplishes replication. Now let’s

turn to the hands-on details of setting up a replicated environment. We’ll start with the sim-

plest replication setup to illustrate the required steps to configure a master and slave, and get

the slave replicating data from the master. These steps are minimal, but show how easy it can

be to get basic replication up and running. After you’ve gotten a simple replicated environ-

ment established, you’ll most likely want to look deeper into the configuration options and

example configurations for more in-depth information on customizing your replication.

Adjust Configuration

For the master database, assign a unique server ID (usually 1, 2, 3, and so on) and enable

binary logging with two entries in the mysqld section of the server startup configuration file.

These options come preset in the default configuration files, so you might already have some-

thing configured as such in your master:

For the slave, assign a unique server ID with one entry in the mysqld section of the config-

uration file used on startup:

[mysqld]

server-id=1

log-bin

[mysqld]

server-id=2


C H A P T E R   1 8   ■ R E P L I C AT I O N

■Tip For replication to work properly, the master and slave need to be able to communicate via TCP/IP on

a designated port. For MySQL, the default port is 3306. Ensure that the --skip-networking option isn’t in

your configuration file, and that the firewall allows this traffic through on port 3306, or the port you’ve desig-

nated for MySQL.

You can also set the server_id from within the MySQL client by issuing this command:

mysql> SET global server_id=2;

This allows you to set server IDs without restarting your database. Be sure to make corre-

sponding changes in the configuration files so the server IDs will stick on a restart.

Create Replication Account

For the slave to get data from the master, you need to establish an account for the slave to

connect through to grab updates from the binary log. We recommend setting up a specific

user for replication, with permissions limited to replication.

On the master, create an account for replication with this statement:

mysql> GRANT REPLICATION SLAVE ON *.* TO 'replicate'@'%' IDENTIFIED BY 'r3p1!c8';

The REPLICATION SLAVE piece of this statement indicates that the only permission this user

has is to pull statements from the master’s binary log. The tables (*.*) and host ('%') pieces

of this statement should follow after your privilege rules. If you’re only replicating from one

machine, you should probably limit the @ to that specific machine. See Chapter 15 for more

information on specifying privileges based on the host, and for specific databases or tables.

■Note Versions of MySQL prior to 4.0.2 did not have the REPLICATION SLAVE privilege. Creating permis-

sions for replication on older versions requires granting the FILE privilege.

Schema and Data Snapshot

Before you can start replicating your data, your slave server needs to have a copy of the data-

base structure and any existing data on the master. You need a snapshot of your data that

represents your database at a single point in time. When you start replicating the data, you’ll

start replicating from the time you made a snapshot of your master database. When the slave

database starts, it begins pulling data from the master starting at a particular point in time. To

avoid any overlap or gap in data, you’ll want to be sure that the point at which the replicated

machine starts reading your data is the exact point where you made your data snapshot. For

the purposes of this simple setup, we’ll assume you’ll replicate all databases, including your

permissions tables in the mysql database.

The most universal tool for making a snapshot is mysqldump. This tool works with all stor-

age engines and gives you a file that’s easy to work with to create a duplicate set of data on a

second server. Listing 18-5 goes through the list of steps to create a dump.


C H A P T E R   1 8   ■ R E P L I C AT I O N

■Tip Although it’s the easiest way to copy data for the purposes of showing how to get a simple replication

up and running, mysqldump might not be the right tool for you. There are several other ways to create a

snapshot. Two other shell tools, mysqlhotcopy and mysqlsnapshot, may fit your needs better if you

have large tables that use the MyISAM storage engine. If you’re using MyISAM, you should also look at the

possibility of using the LOAD DATA FROM MASTER command, which you can run from within the MySQL

client to pull data from the master and set your relay log position. You can find more information about

LOAD DATA FROM MASTER at http://dev.mysql.com/doc/mysql/en/load-data-from-master.html.

mysqlhotcopy documentation can be found at http://dev.mysql.com/doc/mysql/en/mysqlhotcopy.

html, and information on mysqlsnapshot is at http://jeremy.zawodny.com/mysql/mysqlsnapshot/.

Chapter 17 also contains details about ways to create data snapshots.

Listing 18-5. Lock Tables and Find Binary Log Position

mysql> FLUSH TABLES WITH READ LOCK;

mysql> SHOW MASTER STATUS\G

*************************** 1. row ***************************

File: master-bin.000002

Position: 6016

Binlog_Do_DB:

Binlog_Ignore_DB:

Make a note of the File and Position settings on the master—you’ll use these later in

configuring the slave. Leave the MySQL client connection open (closing it removes the lock).

While you still have the client connection open, issue the mysqldump command from another

shell, as shown in Listing 18-6.

Listing 18-6. Create a Snapshot of the Data

shell> mysqldump –A > all_database.sql

Once your entire database is dumped to the file, you can go back into your client and

unlock the table. You can either simply exit the client tool, which releases the lock; go back

and release the lock from the tables by exiting the client; or issue the lock release statement

shown in Listing 18-7.

Listing 18-7. Release the Tables Lock

mysql> UNLOCK TABLES;

Move the all_database.sql file to your slave server. Start your slave server database, if it’s

not running already. Other than having a server ID, you don’t need any additional options in

the configuration file because the replication options will be specified as a part of starting the

replication.

With your slave database running, send the dump of your master database to the client,

using the statement in Listing 18-8.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Listing 18-8. Create Slave Tables from Master Snapshot

shell> mysql < all_database.sql

Running the command in Listing 18-8 brings your slave database to the exact point in

time that your master was when the snapshot was taken. With the data in place, we’re ready

to start the replication processes and start pulling updates from the master.

Start Replication

We’re finally there. With the slave machine’s database set to a particular point in time, we’re

ready to start replication, which will pull statements from the master’s binary log and keep

the slave synced closely with the master database.

How do you ensure you won’t miss any statements that have changed data on the master

since you took the snapshot? If you recall, we made note of the position of the binary log when

the snapshot was taken. If we tell the slave to start pulling statements at that point, it will pull

everything that has happened since the snapshot. Setting the master log position is a part of

the configuration of the slave. Listing 18-9 shows the command to configure the replication

on your slave server.

Listing 18-9. Set up Slave for Replication with CHANGE MASTER

mysql> CHANGE MASTER TO

MASTER_HOST='master.example.com',

MASTER_USER='replicate',

MASTER_PASSWORD='r3p1!c8',

MASTER_LOG_FILE='master-bin.000002',

MASTER_LOG_POS=6016;

statement:

mysql> START SLAVE;

With these options set, you’re ready to start replication, which is done with a simple

Your slave server is now running, right? How do you know it’s working? There are a num-

ber of ways to check the status of the slave. You can verify that the statements from the master

are being copied into your relay log files by performing a mysqlbinlog on the latest relay log.

You can also check records in the database on the master and compare the counts or highest

ID for different tables. These methods are nice ways to watch replication in action, but don’t

always provide the summary information about your replication process. In addition, if the

replication isn’t running, you won’t find the reason by looking through the replicated data.

To really see what’s going on in your server, you should be familiar with the monitoring and

management commands. But before you do that, we have to look at all the remaining configu-

ration options available for your replication setup. Let’s take a few minutes and go over all the

options that will enable you to take our simple example and build it up to meet your needs.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Configuration Options

We’ve gone through the entire process of setting up replication in a MySQL database, but in a

somewhat simplistic way. We didn’t show most of the available configuration options during the

process. Although simple replication works pretty well, we suspect that most folks will require

more granular control over their replication. MySQL’s replication configuration options give you

a lot of flexibility to control what’s happening in your replication environment.

We’ve grouped the options into three main categories: core options used on the first

startup of the slave and stored in the master.info file, options that can be controlled from

within a running MySQL instance, and options that must reside in the configuration file.

■Note We refer to your configuration files a lot in this section, and want to point out that replication

options are just like any other MySQL options. They can be a part of the configuration file hierarchy

described in Chapter 14.

Core Options

We’ll call the configuration options in Table 18-3 core options. They’re options that are stored

in the master.info file and are considered essential options to running replication. You can

also specify these options in the CHANGE MASTER command.

If you want replication to start immediately upon startup of the slave, place these config-

uration options and their values in your configuration file. When the slave server starts, it pulls

these options from your configuration file, stores them in master.info, and attempts to start

replication.

If you want to start replication by hand after your slave server is already running, you

shouldn’t have these options in your configuration file. After the slave database is up and run-

ning, issue the CHANGE MASTER command, specifying values for each of the options as a part of

the command, and then issue the START SLAVE command. A sample of the CHANGE MASTER

command is shown in Listing 18-9, and this command is covered later in the chapter.

Whether you have replication start automatically by getting values from your configura-

tion file or start using CHANGE MASTER, be aware that from that point forward the core options

are always pulled from the master.info file. The only way to reset these options is to issue

another CHANGE MASTER command, or remove the master.info file prior to a startup. Table 18-3

shows the core replication options.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Table 18-3. Core Replication Options

Option

--master-host=<hostname>

--master-user=<user>

--master-password=<password>

--master-port=<port number>

--master-connect-retry=<number of seconds>

--master-ssl=<0|1>

--master-ssl-ca=<file>

--master-ssl-capath=<dir>

--master-ssl-cert=<name>

--master-ssl-cipher=<cipher:cipher>

Description

This is the hostname or IP address of the

master database, where the slave should

connect to retrieve statements from the

binary log.

The thread that retrieves queries from the

master uses this name for its connection to

the master database.

This is the password used along with the

--master-user to connect to the master server.

This is the port number to connect to the

master server. The default port for MySQL

is 3306.

This option tells the slave how often to check

for the presence of a master if a connection

cannot be made. If the slave attempts to

connect, and can’t get through to the master,

it waits this number of seconds until it makes

another attempt.

Tells the slave whether it should be using SSL to

connect with the master. If SSL is turned on, you

need to set the other master-ssl-* options.

Path to a file containing trusted CA certificates.

Path to the directory where CA certificates exist.

Name of the master SSL certificate file.

List of ciphers allowed in SSL encryption,

separated by a colon.

--master-ssl-key=<name>

Name of the master SSL key file.

Other Options

Beyond the core set of configuration options stored in the master.info file, there’s quite a list

of available options for your configuration file. You can also specify any of these options on

the command line when starting MySQL. Table 18-4 shows these options with a description

of the behavior changes based on the specified value.

Table 18-4. Startup Replication Options

Option

--log-slave-updates

Description

--log-warnings

Turn on logging for updates made in the slave database.

Normally, statements that are pulled from the master to

run on the slave aren’t logged to the binary log. With this

option specified, the statements from the master will be

logged into the binary log after they’re run.

Add additional information to the error log, such as

network connection success after failure and how slaves

are started. This is enabled by default after version 4.0.19

and 4.1.2. Use --skip-log-warnings to disable.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Option

Description

--master-info-file=<file>

--max-relay-log-size=➥

<number of bytes>

--read-only

--relay-log=<file>

Use this file to store and read information about the

master. See Table 18-1 for information on the contents of

this file.

The maximum size of the relay log before a new one is

created. The default setting is 0, which causes MySQL to

use the --max_binlog_size setting.

Prevents writes to the slave database except for those users

with SUPER privilege. This is useful if you want to protect

replicated databases from accidental data changes.

Name of the file where the slave writes and reads queries

coming from the master. You can use this option to put

your log files onto a disk separate from the disks with your

data for improved performance.

--relay-log-index=<file>

Name of the file with information about the current relay

log and position.

--relay-log-info-file=<file>

Name of the file used to store the list of available relay

log files.

--relay-log-purge=<0|1>

Specifies if the replication process should remove relay log

files once they are processed. The default is 1.

--relay-log-space-limit=➥

<number of bytes>

--replicate-do-db=<database name>

--replicate-do-table=➥

<database name>.<table name>

--replicate-ignore-db=➥

<database name>

Forces MySQL to keep the combined relay log size under

a certain size. If this size is reached, MySQL will suspend

replication until the slave has caught up and the relay

log files can be purged. MySQL may ignore this setting

temporarily to prevent a deadlock when it conflicts

with --max-relay-log-size.

Specifies the name of a database to replicate. Use this

option multiple times to specify multiple databases. The

slave replicates statements in which this database was

the currently active database, not queries with a qualified

database, such as UPDATE db.table. Unless the query is

issued while <database name> is the active database, the

statements won’t be replicated. To get around this, use

--replicate-wild-do-table=<database name>.%.

Specifies the name of a table, within a database, to be

replicated. Use this option multiple times to specify

multiple tables. Works with queries qualified with a

database, such as INSERT INTO db.table.

Ignores statements that update data in this table. Use this

option multiple times to specify multiple databases. The

slave ignores statements where this database was the

currently active database, not queries with this as the

qualified database, such as UPDATE db.table. Unless

the query is issued while <database name> is the active

database, the statements won’t be ignored. To get around

this, use --replicate-wild-ignore-table=➥

<database name>.%.

Continued


C H A P T E R   1 8   ■ R E P L I C AT I O N

Table 18-4. Continued

Option

Description

--replicate-ignore-table=➥

<database name>.<table name>

--replicate-wild-do-table=➥

<database name>.<table name>

Ignores statements issued to this table, within the specified

database. Works to ignore queries qualified with a database,

such as INSERT INTO db.table.

Similar to --replicate-do-table, but allows you to

specify wild-card characters. “_” matches a single

character and “%” matches any number of characters. You

can use wild-card characters multiple times in both the

database and table names. For example, to replicate the

customer, customer_order, customer_address, and

customer_payment tables in the shop database, use

shop.customer%.

Like --replicate-ignore-table, but allows you to use

wild-card characters. “_” matches a single character and

“%” matches any number of characters. You can use

wild-card characters multiple times in both the database

and table names. For example, to ignore the customer,

customer_order, customer_address, and customer_

payment tables in the shop database, use shop.customer%.

Translates the name of the database on the master to a

new name on the slave. This only works for updates made

to the database when it’s the default database, not for

statements to tables qualified with the database name,

such as DELETE FROM shop.customer. Be aware that the

rewrite happens before any of the matching to determine

whether the statement should be replicated, so your

matching rules need to use the <new name>.

The default behavior is to ignore statements in the relay

log that have a server ID that indicates the statement

originated from itself. This prevents infinite loops in

replication ring configurations. Use this option if you

need to disable this so you can run statements marked

as being from this server.

The hostname to register with the master. In most cases

this should be the hostname of the slave, but it can be any

string. Each registered slave shows in the SHOW SLAVE

HOSTS statement on the master.

The port number the slave should use for registering with

the master. Leave unset to use the default port.

When starting up the database, don’t start up the slave.

Use this option if you want to have some of the slave

options in your configuration file, but don’t want the

slave to start replicating automatically.

If the master and slave support it, a value of 1 will cause

them to use compression for data exchange during

replication.

--replicate-wild-ignore-table=➥

<database name>.<table name>

--replicate-rewrite-db=➥

<master name>-><new name>

--replicate-same-server-id

--report-host=<hostname>

--report-port=<port>

--skip-slave-start

--slave_compressed_protocol=<0|1>


C H A P T E R   1 8   ■ R E P L I C AT I O N

Option

Description

--slave-load-tmpdir=<file>

--slave-net-timeout=➥

<number seconds>

--slave-skip-errors=➥

<err_code, err_code,... | all>

Specifies an alternate location for temporary file storage.

Used in replication of LOAD DATA INFILE statements

where files need to be stored somewhere temporarily

while being imported into the database.

Waits for this number of seconds for the master to send

more data, and then considers the connection broken

and retries.

In replication, the default is that on any error, replication

stops. This option allows you to tell the replication process

to ignore certain error numbers, or all errors. This option

can be dangerous, as problems in replication can get

hidden. Use it cautiously. For more information on MySQL

error numbers, see http://dev.mysql.com/doc/mysql/

en/error-handling.html.

How Does MySQL Decide What to Replicate?

We’ve just looked at all the configuration options for replication in MySQL. A number of them

are designed to allow you to control which tables are replicated. These include replicate-do-➥

*, replicate-ignore-*, and replicate-wild-*. You may wonder how MySQL parses these

statements and prioritizes what statements to respect when there are multiple matches for a

table.

MySQL uses a specific set of logical steps in determining whether each statement will get

replicated. The logic used to decide where to stop in the tree is more fully documented in the

MySQL documentation, but in general the rules are considered in the following order:

1. replicate-do-db

2. replicate-ignore-db

3. replicate-do-table

4. replicate-ignore-table

5. replicate-wild-do-table

6. replicate-wild-ignore-table

You can find more information on the details of the decision-making process at http://

dev.mysql.com/doc/mysql/en/replication-options.html.

■Tip You can also control what gets replicated to slave servers by limiting what gets written to the binary

log with the binlog-do-db and binlog-ignore-db options in your MySQL configuration. If a statement

isn’t written to the binary log, it won’t be replicated to the slave machines. Use care with this option. If you’re

using the binary log to roll forward to a point in time after a restore from backup, you may run into trouble if

you aren’t writing all changes to the binary log.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Monitoring and Managing

Whether you’re just embarking on setting up replication, or have been at it for years, being

familiar with the tools to monitor and manage MySQL replication is the key to having well-

performing, successfully replicating copies of your data. In this section, we’ll go through

seven key commands to keep your eyes on and to tweak your data replication.

■Note The tools provided with MySQL to monitor replication are designed to be run manually. For

most production situations, you’ll want to have an automated status update and alert system in place.

Several scripts are available for building an alert system. See this URL for some of these scripts: http://

dev.mysql.com/books/hpmysql-excerpts/ch07.html#hpmysql-CHP-7-SECT-5.4.2.

SHOW MASTER STATUS

The SHOW MASTER STATUS statement gives you information on the status of the master server as

it relates to replication. Example output from this statement is shown in Listing 18-10.

Listing 18-10. Output from SHOW MASTER STATUS

mysql> SHOW MASTER STATUS;

+---------------------+----------+--------------+------------------+

| File                | Position | Binlog_Do_DB | Binlog_Ignore_DB |

+---------------------+----------+--------------+------------------+

| master-bin.000002   |     6016 |              |                  |

+---------------------+----------+--------------+------------------+

The output of this command includes the currently active binary log, the current position

that MySQL is writing to the log, and the value of Binlog_Do_DB and Binlog_Ignore_DB. These

last two columns show the value of the corresponding configuration options to limit the state-

ments that are written to the binary log.

As you can see, this particular host is using binary log master-bin.000002 at position 6016.

If you’re running this statement as a part of creating a snapshot of your data, take note of the

log name and position for use in your CHANGE MASTER command on the slave.

SHOW SLAVE HOSTS

This statement is run on the master server and returns a list of all the slaves that have regis-

tered and are replicating data from this machine. A replication slave registers with the master

if the --report-host option is specified in the slave configuration options. Slaves that don’t

have --report-host won’t appear in the SHOW SLAVE HOSTS command. Listing 18-11 shows an

example of the output of this statement.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Listing 18-11. Output from SHOW SLAVE HOSTS

mysql> SHOW SLAVE HOSTS;

+-----------+-------------------+------+-------------------+-----------+

| Server_id | Host              | Port | Rpl_recovery_rank | Master_id |

+-----------+-------------------+------+-------------------+-----------+

|         2 | slave.example.edu | 3306 |                 0 |         1 |

+-----------+-------------------+------+-------------------+-----------+

The output includes the ID of the server, the host string that was reported, the port that

replication is running on, the ranking of the machine for priority in getting updates from the

master, and the ID of the master server.

SHOW SLAVE STATUS

The SHOW SLAVE STATUS command gives you a dump of information about the status of repli-

cation from the slave’s point of view. Listing 18-12 shows a sample output. Using the \G option

outputs in rows instead of columns.

Listing 18-12. Output from SHOW SLAVE STATUS

mysql> SHOW SLAVE STATUS\G

*************************** 1. row ***************************

Slave_IO_State: Waiting for master to send event

Master_Host: master.example.edu

Master_User: replicate

Master_Port: 3306

Connect_Retry: 60

Master_Log_File: master-bin.000002

Read_Master_Log_Pos: 6016

Relay_Log_File: slave-relay-bin.000005

Relay_Log_Pos: 232

Relay_Master_Log_File: master-bin.000002

Slave_IO_Running: Yes

Slave_SQL_Running: Yes

Replicate_Do_DB:

Replicate_Ignore_DB:

Replicate_Do_Table:

Replicate_Ignore_Table:

Replicate_Wild_Do_Table:

Replicate_Wild_Ignore_Table:

Last_Errno: 0

Last_Error:

Skip_Counter: 0

Exec_Master_Log_Pos: 6016

Relay_Log_Space: 232

Until_Condition: None

Until_Log_File:


C H A P T E R   1 8   ■ R E P L I C AT I O N

Until_Log_Pos: 0

Master_SSL_Allowed: No

Master_SSL_CA_File:

Master_SSL_CA_Path:

Master_SSL_Cert:

Master_SSL_Cipher:

Master_SSL_Key:

Seconds_Behind_Master: 0

This is a way to see all the settings that were specified in the options file or in the

CHANGE MASTER statement, and to see the active log files and corresponding positions. The

Slave_IO_Running and Slave_SQL_Running columns indicate that both slave threads are running,

or more generally that the replication processes designated for the slave are operating. Three

items deserve closer attention: slave state, last error, and seconds behind master.

Slave State

The slave’s I/O thread is always in a state, which is displayed in the SHOW SLAVE STATUS com-

mand. Understanding the different states can be helpful in troubleshooting problems with

replication. State messages point you to the specific step in the replication process that is hav-

ing problems. Table 18-5 shows a list of the different states and a description of what’s

happening during that state.

Table 18-5. Slave State Descriptions for Slave I/O Thread

State

Description

Connecting to master

The thread is trying to create a connection to the master.

Checking master version

Registering slave on master

Requesting binlog dump

Waiting to reconnect after a failed

binlog dump request

Queuing master event to the relay log

Waiting to reconnect after a failed

master event read

After the connection to the master is made, the slave

checks the version of the master. This state happens

immediately after the slave makes the connection,

and is very brief.

The slave, after connecting, is now registering with the

master. The slave is only in this state briefly.

The I/O thread on the slave is making a request to get the

statements from the binary log.

The thread is sleeping while it waits for the next time to

try to connect. The slave goes into this state on a failed

attempt to get statements from the binary log.

The thread has requested binary log entries from the

master, and is waiting for the master I/O thread to

respond with some data. This state is common, and in

most cases means that the master doesn’t have any

statements to send just now.

The thread is putting entries returned from the master’s

binary log into the relay log on the slave.

When reading the statements sent from the I/O on the

master, an error occurred. Waiting to reconnect and try

again.

Reconnecting after a failed binlog

dump request

The thread is attempting to connect to the master after a

failed attempt.

Waiting for master to send event


C H A P T E R   1 8   ■ R E P L I C AT I O N

State

Description

Reconnecting after a failed master

event read

Waiting for the slave SQL thread to

free enough relay log space

Waiting for slave mutex on exit

The last connection failed during a read of the statements

sent from the master’s binary log. Attempting to connect

again.

The I/O thread is waiting for more space to be made for

relay logs. This state occurs when the relay_log_space_

limit option is specified and the slave needs to rotate

those logs to free up more space.

The thread is in the process of stopping. The slave is only

in this state briefly.

Last Error

The last error is the error number and message from the most recently executed SQL statement

from the relay log. If the statement had no error, the value will be 0 for Last_Errno, and there

will be no value in Last_Error. The errors are helpful in troubleshooting a failing replication.

Seconds Behind Master

The Seconds_Behind_Master column compares the time a statement was brought in from the

I/O thread to the time that statement was processed. If your network is fast, and statements

are getting to the slave quickly, the value of Seconds_Behind_Master will give you a pretty good

sense of how long it takes for a statement to be processed. The slower the network connection,

the less accurate this value.

To find the real value of how long it was between issuing a statement on the master and

its execution on the slave, you need to create some monitoring or health-check scripts to test.

Replication performance is addressed in the upcoming section “Replication Performance.”

CHANGE MASTER

We looked at the CHANGE MASTER command back when we did the initial setup of our replication

server. All the name/value pairs are optional, and you can use the CHANGE MASTER command to

change any or all of the options. Table 18-1 and Table 18-3 laid out details about the values.

Listing 18-13 recaps the command and shows all the available options.

Listing 18-13. CHANGE MASTER Statement

mysql> CHANGE MASTER TO MASTER_HOST = '<host name>',

MASTER_USER = '<user name>',

MASTER_PASSWORD = '<password>',

MASTER_PORT = <port number>,

MASTER_CONNECT_RETRY = <number seconds>,

MASTER_LOG_FILE = '<master log name>',

MASTER_LOG_POS = <master log position>,

RELAY_LOG_FILE = '<relay log name>',

RELAY_LOG_POS = <relay log position>,

MASTER_SSL = <0|1>,

MASTER_SSL_CA = '<ca file name>',


C H A P T E R   1 8   ■ R E P L I C AT I O N

MASTER_SSL_CAPATH = '<ca directory path>',

MASTER_SSL_CERT = '<certificate file name>',

MASTER_SSL_KEY = '<key file name>',

MASTER_SSL_CIPHER = '<cipher list>';

■Caution When making changes to the configuration, be sure that either replication is stopped or that

relay logs aren’t being processed. You may want to check SHOW SLAVE STATUS for the state before execut-

ing a CHANGE MASTER statement.

START SLAVE

To start a slave running, issue the START SLAVE command. This  will  start replication using the

options set with CHANGE MASTER, or in the  master.info file from a previous start. By default this

command starts both the I/O and the SQL threads, which start retrieving and processing state-

ments from the master.

If you want to start only the I/O thread to read statements from the master, or only the

SQL thread to process statements in the relay log, you can specify which thread to start. To

start just the I/O thread, use the statement in Listing 18-14.

To start just the SQL thread, use the statement in Listing 18-15.

Listing 18-14. Starting the I/O Thread

START SLAVE IO_THREAD;

Listing 18-15. Starting the SQL Thread

START SLAVE SQL_THREAD;

You can also add conditions to the SQL thread startup with the UNTIL keyword. Adding

this keyword tells the SQL thread to process statements up to a certain point in the binary or

relay log. Listing 18-16 shows the syntax for a statement using the UNTIL clause.

Listing 18-16. Starting the SQL Thread with the UNTIL Clause

START SLAVE [sql_thread]

[UNTIL relay_log_file = '<log name>', relay_log_pos = <log position>] |

[UNTIL master_log_file = '<log name>', master_log_pos = <log position>];

With the UNTIL clause, you aren’t allowed to mix the relay log options with the master log

options. If you leave the sql_thread syntax out, both the I/O and SQL threads will start.

STOP SLAVE

You use the STOP SLAVE statement to tell the threads that have been running the replication

processes to quit. You can execute it without any arguments to stop both the I/O and SQL

threads, or specify which slave thread to stop, as shown in Listing 18-17.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Listing 18-17. Stopping Replication

STOP SLAVE [io_thread, sql_thread];

RESET SLAVE

The RESET SLAVE statement deletes the master.info and relay-log.info files, removes all relay

logs, and starts fresh with a new relay log. This statement initiates a clean start. Along with the

STOP SLAVE and CHANGE MASTER commands, the RESET SLAVE statement gives you the control to

remove any connection with previous replication settings or positions.

■Caution When using RESET SLAVE, be aware that all relay logs are removed, even if statements in the

relay log haven’t been processed.

Replication Performance

Everyone wants to know how fast MySQL replicates data from a master to its slaves. That’s a

difficult question to answer. One thing is for sure: the data isn’t available in the slave until after

the statement is completed in the master. The fact is, the statement isn’t written to the mas-

ter’s binary log until after the statement execution is complete on the master. This means that,

at best, the statement is picked up the instant it’s in the master’s binary log, quickly copied to

the slave server, and then run the instant it’s appended to the relay log on the slave. How long

does that process take?

Unfortunately, there’s no concrete answer. Cursory tests in a single-slave environment

with smaller records, on a server under little load, indicate a nearly undetectable delay.4 How-

ever, a lot depends on your environment, including the servers, network, database load, and

record size.

To answer how quickly the data will replicate in your environment, our recommendation

is that you set up a test server for replication. This could be a full-blown testing environment,

or if you don’t have a large budget, an older server or unused desktop. Set up replication, with

data changes in the master representative of the changes you see in your production database.

Watch the Seconds_Behind_Master value from the SHOW SLAVE STATUS command, or create a

script to test time differences between queries on the master and slave.5 Perhaps you want to

automate a regular check of the slave and record its health during different periods of activity

on the master server. After you get a sense of how fast replication is working for your data,

start to put some test loads on the slave server to see how offloading queries from the master,

or accepting queries from elsewhere, would affect the delay between the master and slave.

Our sense is that replication works as fast as the environment allows it, which is nearly

instantaneous in situations where the database load isn’t overbearing and the hardware and

4.

5.

Information about this test can be found at http://dev.mysql.com/books/hpmysql-excerpts/

ch07.html#hpmysql-CHP-7-SECT-1.3.

If you have the time on the machines synced, one idea is to insert a record into a table using the

time() function, or have a timestamp column. Because the time() function is in the replicated state-

ment, the insert into the table on the slave is a certain number of seconds later than the insert into

the master.


C H A P T E R   1 8   ■ R E P L I C AT I O N

network are sufficient. We encourage you to consider the following five factors as you try to

assess (or improve) the performance of your replication environment.

Hardware

First, replication is only going to be as fast as your disks and CPU can save, retrieve, and

process statements from the binary and relay log files. This applies to more than just replica-

tion, but is a factor in how fast the server can communicate an addition to the binary log out

to a slave server.

Network

Your network is a key link in replication speed. Every statement logged on the master server

needs to be sent across the network to your slave servers. A slow or congested network has a

significant effect on the delay on your slave servers.

MySQL replication doesn’t do any network magic that enables it to push traffic across a

network at lightning speed. It uses TCP/IP for communicating changes, and is subject to the

same bandwidth limits, bottlenecks, and packet failures that normal network traffic encoun-

ters. If you have a slow connection between your servers, and someone decides to copy a 5GB

log file from one machine to the other, your replication speeds will suffer accordingly.

Database Load

The load on your master database affects the speed of your replication. Not only does it take

more work to keep feeding the ever-increasing binary log statements to the slave, the thread

has to compete with the other MySQL threads for access to the disk and CPU time.

Record Size

Records executed on the master have to be read from the binary log file, transferred across

the network, saved into the relay log file, read from the relay log file, and executed in the slave

database. The size of your record plays a role in how fast MySQL can move through all these

steps. If you have a record with three char(10) columns, the transfer will be much faster than a

record with a 15MB BLOB.

Amount of Data and Types of Queries

The amount of data and types of queries you run against that data will have an effect on how

quickly changes are seen in the slave. Suppose you have several million rows of data in a table.

You perform an update with a WHERE clause that requires a full-table scan and updates half the

records in the table. If the statement takes 20 seconds to run on the master, it will be at least

20 seconds until those changes are seen in the slave. Even if it only takes 1 millisecond to get

the statement from the master to the slave, it will take the same amount of time to process on

the slave.6

6. This is assuming you haven’t done some trickery with the indexes on the slave, which could make the

statement run faster (or slower) on the slave.


C H A P T E R   1 8   ■ R E P L I C AT I O N

Replication Examples

To get a better sense of what kind of configurations are possible, we provide a few configura-

tion options in this section, complete with diagrams.

Simple Replication

The simplest type of replication is to have one master and a single slave that replicates the

master’s data. This is the easiest environment to set up and maintain. This setup provides a

hot-backup copy of your data, or a separate database to use to take backups without inter-

rupting the production database. Figure 18-3 shows the simplest of replication setups.

Master

Slave

Figure 18-3. Single-server replication

The single-server replication is the easiest to restore when there are replication problems.

If replication has stopped, getting it back up and running involves working with just one mas-

ter and one slave machine. The worst-case scenario to get back up and running is that you

have to go through the setup process, starting with taking another snapshot of the master,

and so on.

Multiple Slaves

A slightly more involved replication environment is where you have multiple slaves getting

data from the same master. Figure 18-4 shows four slaves pointing at a single master.

Master

Slave

Slave

Slave

Slave

Figure 18-4. Multislave replication


C H A P T E R   1 8   ■ R E P L I C AT I O N

This type of setup is good for environments with heavy loads of read queries, with fewer

writes. All write statements are directed to the master, and reads are spread across many slave

servers. This reduces the load on any single server and can also provide redundancy. If one of

the slaves fails, traffic can easily be pushed off to one of the other slaves.

■Note A master can have multiple slaves, but a slave can only have one master. As we discussed in the

section “How MySQL Implements Replication,” there are no tools to merge updates from multiple servers.

Even if you were tempted to try, MySQL’s configuration file only allows you to specify one master_host

parameter.

Daisy Chain

Although having multiple slaves pointed to a single master works well in certain situations,

there may be other cases where creating a chain of replicated machines meets your needs bet-

ter. Perhaps having many machines replicating from a single master requires too much work

for your master, or your replication environment is spread across such a large geographic area

that chaining the closest ones together gives you better replication speed.

Whatever the reason, it’s entirely possible to set up a slave server to one machine as a

master to another. As long as you have a unique server ID in the configuration of a server, and

have binary logging enabled, any server can be a master, even if its statements are coming

from another master. Figure 18-5 shows a sample configuration where servers are daisy-

chained together.

Master

Slave

-

Master

Slave

-

Master

Slave


C H A P T E R   1 8   ■ R E P L I C AT I O N

To make this possible, be sure that each slave is recording updates from the master in its

binary log with the --log-slave-updates option.

Repairing a daisy-chain replication environment can be tricky, especially if a catastrophic

failure on one of the middle machines sets off a failure in all the slaves below. In an ideal situa-

tion, you would repair the faulty machine and start replication back up to find that the slaves

downstream have continued to wait for the next update and picked right back up where they

left off. A more difficult scenario would be a failure that required a new snapshot from the

master, going down through each replicated machine restoring from the snapshot, and

manually restarting replication.

Other

You’re probably getting the sense that there’s little restriction on the kinds of replication envi-

ronments you can build. Indeed, with the configuration options and ability for a slave to be a

master, there is a ton of flexibility with MySQL replication configurations. You might have a

large tree of replicated databases that contains three, four, or five levels of replication, each

level with different fine-grained controls over the list of databases and/or tables that get repli-

cated down to the next level. Or you might have a daisy chain of servers with multiple slaves

running off each master in the chain. There are no limits, except your sanity.

Remember, with each layer you add to your environment, the environment becomes that

much more difficult to maintain. Resolving an issue with a server that feeds to a tree of ten

other database servers can lead to a lot of work. Be careful of how creative and deep your

investment into replication goes.

■Note There’s a chance that reading about replication in MySQL has made you uneasy, or you wish that

replication was more full-featured, or implemented in another way. If that’s the case, you might want to look

at the available third-party solutions. Many commercial products offer replication as well as clustering for

redundancy and high availability, including multimaster replication. A few open-source projects also offer

wrappers for MySQL. Rather than getting into specific vendors, check out this link for a list of MySQL

partners, in which you can find MySQL-endorsed products that offer third-party replication tools:

http://solutions.mysql.com/.

Summary

Replication in MySQL opens up possibilities for significant expansion of your database sys-

tem. Hopefully we’ve conveyed the importance of careful planning to determine why and how

replication fits into your system.

We spent a good deal of time throughout the chapter focusing on setting up, configuring,

monitoring, and maintaining your replication servers. Armed with this information, you’re

equipped to embark on a venture into replication, or improve your existing replication setup.

Replication is an exciting technology, and although MySQL’s implementation doesn’t have

all the bells and whistles of other database systems, it gives you a lot of room to build a cus-

tomized system.


C H A P T E R   1 8   ■ R E P L I C AT I O N

We hope your environment has replication requirements, or areas where replication

could meet an unmet need. We see implementing a replication system as one of those fun,

exciting technical challenges. We hope you look at replication in the same way.


C H A P T E R   1 9

■ ■ ■

Cluster

Most database administrators spend time worrying about the availability of their database,

and how to provide uninterrupted access to the data. In the past two chapters, we’ve gone

over backups and replication and talked about how they might fit into building a system in

which you can minimize downtime if a server or database fails. With a backup on hand, you

can minimize the downtime for a database to as little as the time it takes to restore the data

from your backup. Replicating your data to a second machine to serve as a hot copy of your

data should mean even less downtime than waiting for a backup to restore. In both these

instances you still have some downtime. You can reduce the downtime even further by build-

ing your application, or a database access layer under your application, to move automatically

to the replicated database if the primary database becomes unavailable. To do this requires a

significant design and development effort.

Part of determining the effectiveness of your backup or replication plan is to assess just

how much downtime is acceptable. Most managers will respond with, “We cannot have any

downtime,” but when presented with information about the cost associated with trying to

provide an uptime guarantee, the response usually softens. Many organizations can live with

the one or two hours it takes to restore a backup of the data to a machine, or the few minutes

it takes to point the application at a new database server that has been replicating the data.

But what if you can’t afford that kind of downtime? What if you’re running an application

that contains critical data for a hospital information system, or are running a high-volume

e-commerce site that loses money each second the database is down? Even if you don’t have

this kind of critical situation, you may have a client or manager who requires that his or her

database be capable of having a server die and to have no interruption in the flow of data to

the application.

To meet the needs of those who require a highly available database, MySQL provides the

NDBCLUSTER storage engine, which spreads data redundantly across many servers and provides

access to the data as if the servers were all one. The cluster spreads data across the servers in

a way that allows any one of the servers to go offline and not interrupt the availability of the

database or data either to users or your application. If you’re running a system with a set of

load-balanced web servers spread across several data centers, and are looking for a database

to back your application that requires the same level of scalability, redundancy, and availabil-

ity, MySQL Cluster is worth a close look.


C H A P T E R   1 9   ■ C L U S T E R

■Note You don’t have to have a huge data center filled with servers to be interested in, or even benefit

from, MySQL Cluster. It can be set up on as few as three servers and still provide complete redundancy.

If you’ve come to MySQL with clustering technology experience from another database,

this chapter should give you an idea of how MySQL implements clustering.

Through the remainder of the chapter we’ll discuss the following topics:

• Configuring and setting up a cluster implementation

• What clustering is

• How MySQL implements clusters

• How to install MySQL Cluster

• Using ndb_mgmd, ndbd, and ndb_mgm

• Options for configuring your cluster

• Managing the cluster

• What the log files contain

• Protecting your cluster

Once you’ve finished reading this chapter, you should have a good idea of what’s going on

under the hood of MySQL’s cluster engine, and how to set up and maintain a clustered data-

base successfully.

■Caution While we’ve been writing this book, a large percentage of the development activity for MySQL

has been on the cluster code. With a lot of development activity, things change quickly. Although most of the

concepts will remain the same, the details of MySQL’s cluster engine may change. As of this writing, MySQL

is using version 4.1.12 for production, and makes reference to how things used to be done in 4.1.9. If you’re

using an older or newer version than these, please review MySQL’s online documentation to get up-to-date

information at http://dev.mysql.com/doc/mysql/en/ndbcluster.html. Information about new cluster

features is available at http://dev.mysql.com/doc/mysql/en/mysql-5-1-cluster-roadmap.html.

What Is Clustering?

The concept of clustering has been around for a long time—almost as long as computers

themselves. In general, the cluster concept is about grouping multiple computers together

to behave as one, either to provide parallel computing power or for redundancy if one of the

machines goes down. A cluster is an abstract representation of the individual computers,

which allows the individual computers to come and go without any visible interruption to

the user interacting with the computer cluster.


C H A P T E R   1 9   ■ C L U S T E R

Database clustering flows right along those lines. A database cluster spreads data across

a set of servers to provide scalability and redundancy. Just like a computer cluster, a database

cluster can withstand a machine going down and still continue to provide access to the data.

A properly configured cluster has duplicate copies of the data in multiple machines in the

cluster. A cluster also provides scalability, in that you can easily add servers to the cluster for

more processing power, memory, or storage space. If you need more storage space, or want

improved performance, you add more servers to the cluster to assume some of the database

burden.

In the database world, we tend to look at clusters primarily as a way to provide guaran-

teed uptime. With a set of clustered databases, any one of the machines can go offline and not

interrupt the database availability. The cluster also provides more processing power as the

cluster size increases.

As hinted at in the introduction, MySQL’s clustered database technology started in 2003

with the purchase of an Ericsson division called Alzato. Alzato was developing a database

product for use in telecommunications. This database uses cluster concepts to provide highly

available databases.

■Note Throughout this book, we’ve pushed for good policy and implementation plans for your database.

Using MySQL Cluster shouldn’t be any different. Before you embark on getting servers allocated, set up, and

configured, be sure you’ve taken time to sit down with your data owners and explain the advantages and

disadvantages of MySQL Cluster. Make a formal document outlining your implementation plan, including

how the cluster will be configured and managed.

MySQL’s Cluster Implementation

MySQL makes cluster technology available through its NDBCLUSTER storage engine. From the

client perspective, using the cluster engine is just like interacting with any other storage engine.

Because MySQL provides clients with a unified mechanism to access data in the various stor-

age engines, using the cluster involves using the same familiar command-line interface or

programmatic access method you’ve been using to get to tables in other storage engines.

To be fair, although client access is similar to using the other storage engines, this storage

engine isn’t exactly the same. The MyISAM and InnoDB storage engines come prebuilt and are

ready to use upon installation and startup of the database. Any initialization required of these

storage engines is performed when the database is started up. Using the cluster engine is more

involved. Because a cluster involves several servers, there are a number of steps to go through

before the cluster engine is available to the client. These steps are covered in more detail in the

section “Initial Configuration and Startup,” but before we get into that, let’s first go through an

overview of how MySQL clustering works. The cluster engine is similar to HEAP tables in that it

stores all the data in memory. Like InnoDB, the cluster storage engine supports transactions.

Any transaction that isn’t complete when a node dies is rolled back. Failed transactions should

be handled in the application.


C H A P T E R   1 9   ■ C L U S T E R

Nodes

MySQL uses the term node to describe a specific process within the cluster system. Often, a

process is associated with an individual server, but it’s also possible to run multiple processes,

or nodes, on one machine.

There are three kinds of nodes: SQL, storage, and management. Each node serves a spe-

cific purpose in a functioning cluster.

SQL Node

A SQL node provides client access to the data in the storage nodes. The SQL node runs inside

a MySQL server process. On startup, the SQL node consults the cluster configuration informa-

tion on the management node to obtain information on the available storage nodes. Once up

and running, the MySQL server accepts queries, and after appropriate parsing and permission

checking, passes the required information to the cluster storage engine to retrieve the data.

■Note The MySQL Cluster SQL and storage nodes operate independently enough that you can run both on

the same server. Although this might have some financial gain and mean fewer machines to administrate, it

means your system won’t be as scalable or highly available. If you run a cluster with the SQL node on the

same server as your storage node and the machine crashes, you risk losing both the data and access to

the data.

Storage Node

A storage node is typically associated with a single server, but multiple storage nodes can exist

on one machine. The storage node runs an ndbd process to coordinate storage and retrieval

activity with the other nodes and communicate with the management server. Along with the

ndbd process, storage nodes store data in memory.

It’s natural to be curious about how the storage nodes interoperate to coordinate multima-

chine storage and retrieval of data. Each storage node has three main components: a transaction

coordinator, index storage, and data storage. When the SQL node receives a request and is ready

to retrieve the data, it makes a request of the transaction coordinator on one of the storage nodes.

Storage nodes are chosen in round-robin fashion. If a particular storage node is unavailable, the

transaction coordinator from the next storage node is used.

The transaction coordinator is capable of retrieving data from the index and data storage

that’s a part of its own node, as well as indexes and data from any of the other nodes. If the

data needed is spread across four nodes, the transaction coordinator will retrieve the informa-

tion from the data storage on all four nodes and return it to the SQL node. Each storage node

keeps a pool of I/O threads for processing requests for data.


C H A P T E R   1 9   ■ C L U S T E R

Management Node

The management node is responsible for providing information about the cluster to each SQL

and storage node as it starts up. When a SQL or storage node starts up, it looks to the manage-

ment node to get information about the cluster configuration and storage nodes in the cluster.

Thus, the management node must be configured and running before any of the storage nodes

can be started. The management node is also responsible for collecting log entries from the

nodes and writing them to central log files.

Once the SQL and storage nodes are running, they can operate independently from the

management node. If the management node becomes unavailable, the other nodes will con-

tinue normal operation, minus the central logging provided by the management node. Having

said that, it’s a good idea to keep your management node up and running because it provides

a set of tools to manage your cluster, even if it’s busy checking the status of your cluster, stop-

ping or starting nodes, or running backups. We’ll cover commands in the management client

later in the chapter.

■Note To be clear, the management node has two different processes that run: the management server

and the management client. The management server is a daemon that interacts with all the nodes in the

cluster. The management client is a command-line tool you use to issue commands that control and check

the status of the cluster.

Node Arrangement

Like replication in MySQL, clustering offers a lot of flexibility. We’re including a few example

arrangements to give you some ideas about how your set of nodes might be arranged.

Your node arrangement is based on both the data availability policy you’ve defined with

your stakeholders, and what hardware is necessary to meet the demands of your system. Once

you’ve decided that a MySQL cluster can meet your policy, you need to determine how many

machines are needed to meet your query demands and provide the appropriate amount of

redundancy. Here are a few sample arrangements to get you thinking.

Simple Arrangement

To have redundant storage you need at least two storage nodes. Figure 19-1 shows a simple

node arrangement. In this configuration the storage nodes each have a complete set of the

data, and are independent of the SQL node.


C H A P T E R   1 9   ■ C L U S T E R

Client

SQL Node

Storage Cluster

Storage Node

Storage Node

Management

Node

Figure 19-1. Simple node arrangement

As Figure 19-1 shows, the client connects to a SQL node, which has obtained information

about the storage cluster from the management node at startup. The storage cluster contains

redundant storage nodes with duplicate copies of the data. In this configuration, either of the

storage nodes could go down and the cluster would remain up, serving data from the remain-

ing storage node.

Robust Arrangement

You might be curious about what will happen if the SQL node in Figure 19-1 goes down. To

make your system completely redundant, you should have multiple SQL nodes. Figure 19-2

shows a more robust configuration.

In this configuration, we’ve specified redundant SQL nodes and have doubled the storage

nodes. We’ve assigned each client to a node, which provides two different independent inter-

faces to the data. This arrangement might fit well into a web environment where the web

servers are behind a load balancer. If either of the SQL nodes goes down and pages aren’t

available on the associated web server, the load balancer pushes traffic to the other machine

until you have a chance to repair the failing SQL node.

Minimalist Arrangement

Before leaving the conversation about node arrangements, we want to show how you can

build a redundant cluster with just three servers. We’ve mentioned this previously in the

chapter, and the three-server setup is the example featured in an article on MySQL’s site at

http://dev.mysql.com/tech-resources/articles/mysql-cluster-for-two-servers.html.1

To get redundancy in both SQL and storage nodes with three servers, you combine the SQL

and storage nodes onto the same machines. Figure 19-3 shows this arrangement.

1. The article claims to be geared toward a two-server setup, but immediately discloses that three

machines are needed for true redundancy.


C H A P T E R   1 9   ■ C L U S T E R

Management

Node

Client

Client

SQL Node

SQL Node

Storage Cluster

Storage Node

Storage Node

Storage Node

Storage Node

Figure 19-2. Robust node arrangement

Client

SQL Node

SQL Node

Storage Node

Storage Node

Management

Node

Storage Cluster

Figure 19-3. Minimalist node arrangement

As shown in Figure 19-3, the SQL nodes can run on the same machines as the storage

nodes. Because the SQL node (mysqld) and storage node (ndbd) are separate processes, they

can run on the same machine without conflict. If one of the machines in this arrangement

goes down, you still have an available database on the other machine.

Again, we reiterate that finding the right node arrangement is a matter of your data avail-

ability policy, combined with the anticipated load that will be put on the cluster.


C H A P T E R   1 9   ■ C L U S T E R

Calculating the Number of Nodes

Having looked at a few sample configurations, you might be wondering how many nodes you

should have in your cluster. You need to consider two primary factors, besides cost: memory

and performance.

Memory

The first and most concrete factor when choosing how many nodes to have is the amount of

memory you need to store your data. As we’ve mentioned, a MySQL cluster stores all data in

memory, which means you need to have enough memory within your storage nodes to store

all your data twice. Why twice? Because the cluster always has two copies of your data, so

when one of the storage nodes goes down, your data is still there. In addition, the storage

nodes need memory to run the ndbd process.

You can calculate the recommended amount of memory needed in each of your nodes by

using the formula in Listing 19-1.

Listing 19-1. Formula for Calculating Required Memory

(MB of data * number of replicas * 1.1)/number of nodes = MB in each node

Listing 19-1 shows the calculation to give you the amount of memory you need in each

machine. Listing 19-2 shows an example in which we need space for 500MB of data on a

cluster with two replicas and four nodes.

Listing 19-2. Example Calculation of Required Memory

(500 * 2 * 1.1)/4 = 275

Based on this calculation, the layout shown in Figure 19-2 would require each of the stor-

age nodes to have 275MB of memory available to be successful in the cluster. Obviously, as

your data needs grow the amount of memory on each server becomes significantly larger. A

system with 50GB of data will take either a few very expensive machines with a lot of memory

or a slew of less expensive machines with less memory.2

You should be generous when calculating the amount of space you need in the cluster

machines. Expanding memory can be significantly more difficult than adding disk space,

especially if you have machines that already have their memory slots filled.

Performance

The second thing to consider when deciding how many nodes to put in your cluster is per-

formance and scalability. A busy storage node can easily consume the CPU of a server. As you

explore using the NDBCLUSTER engine, run some tests with data from your production database

to get a sense of how scalable the engine is. You can set up a single SQL/storage node to run

these tests to begin with, just to experiment. As you get more serious about moving your stor-

age to a cluster, you’ll want to perform more significant tests on dedicated hardware to get

results that can be used for projections on hardware needs and expected performance.

2. At some point in the near future, 50GB of memory in a system will be standard, and we’ll chuckle

about this paragraph.


C H A P T E R   1 9   ■ C L U S T E R

Using the Cluster

Like any other storage engine, you must use a mysqld server that’s compiled with the cluster

engine into the database when it’s built. We recommend using a prebuilt max binary, which

has the cluster engine and tools built in.

Because a cluster involves several servers and has a set of its own configuration variables,

the configuration of the cluster involves some setup that isn’t required with the MyISAM or

InnoDB engines. Once the cluster is configured and started, you can create tables in the clus-

ter just like in any other storage engine by using the engine=NDBCLUSTER statement at the end

of the CREATE TABLE or ALTER TABLE statement.

■Note As of the writing of this chapter, MySQL only provides binaries with built-in support for MySQL

Cluster for Linux, Solaris, and Mac OS X. A Windows version is promised to be coming.

Limitations of MySQL Cluster

Cluster technology is fairly new to MySQL. Even though the cluster engine now available in

MySQL is a solid storage engine, it was developed for requirements that may differ from what

you might think should be standard for a database. Since adding the NDBCLUSTER storage

engine, MySQL’s developers have been actively working on the cluster code to integrate it

more fully into MySQL and provide a clustered storage engine that looks and behaves more

like the other storage engines (MyISAM, InnoDB, and so on).

We’d like to point out a few of MySQL Cluster’s current limitations, not as a comprehen-

sive list, but to show you some of the primary limitations and give you an idea of how using

the NDB storage engine might be different from MyISAM or InnoDB:

■Note It’s clear, from looking at the activity in the source code, that the MySQL developers are busily

working on removing these limitations. Although it’s important to document them, we encourage you to look

to the online documentation to verify that a limitation is still valid if it’s a concern. You can find the change

history of MySQL Cluster at http://dev.mysql.com/doc/mysql/en/mysql-cluster-change-history.htm.

• Except for BLOB fields, each record can only contain up to 8K of data.

• MySQL Cluster currently uses memory for all data storage. Although this makes the

database operations extremely fast, it can be an issue when there are large amounts of

data. The MySQL documents suggest that developing disk-based storage as an option is

high on the priority list.

• The combined database and table name for a particular table must be less

than 122 characters. If you have a database name that is 22 characters (for example,

east_fullfilment_centr), the tables within that database only have 100 of the total 122

characters to use for their name.


C H A P T E R   1 9   ■ C L U S T E R

• Column names can be no longer than 31 characters. If a table is created with column

names longer than 31 characters, the column names are truncated. Truncation may

result in an error if the truncated columns aren’t unique.

• In MySQL Cluster, all fields are fixed length. This means that even if you use a VARCHAR

data type, the entire space for that record will be allocated when storing the data, even

if the data doesn’t require all the space.

• In total, the number of database, table, index, and BLOB objects cannot exceed 1,600.

• Each table is limited to having 128 attributes (columns).

• Foreign keys aren’t supported. Foreign key statements are ignored in CREATE or ALTER

commands.

• Although you can stop and start defined nodes without causing any cluster unavailability,

adding a new node to the cluster requires a change to the management’s configuration

file. Changes in the configuration require a complete stop and start of all the nodes in the

cluster to become aware of the new node. This means some downtime for your cluster.

• Not all character sets are supported. As of writing this chapter, the following character

sets are supported: big5, binary, euckr, gb2312, gbk, latin1, sjis, tis620, ucs2, ujis,

and utf8.

• Prefix indexes (indexing of first few characters of a field) aren’t supported. Indexes

always cover the entire field.

• WKT and WKB geometric data types are not supported.

• There’s no support for partial rollback in transactions. NDB tables always roll back the

entire transaction on a failure.

• Query cache support is disabled because there is no way for invalidation of the cache

on nodes other than the local node.

• Because each server in the cluster maintains its own binary log, replication from the

cluster requires making all data changes on one machine in the cluster.

• You cannot mix big-endian and little-endian systems in your cluster. The management

and storage nodes must be the same architecture. Clients’ connections can come from

any architecture.

MySQL maintains a list of current limitations, which is longer than the list we’ve presented

here and gets into more detail. As MySQL continues its integration and enhancement of the

cluster engine, the limitation list will get smaller. You can watch the progress on the cluster soft-

ware by looking at the change history, which provides a general overview of the improvements

being made to the software. Here’s a pointer to MySQL’s cluster limitations and change history

documents: http://dev.mysql.com/doc/mysql/en/mysql-cluster-limitations-in-4-1.html.


C H A P T E R   1 9   ■ C L U S T E R

Installing MySQL Cluster

To use or try MySQL’s cluster technology, you need the clustering tools installed on your

server. If you’re running version 4.1.3 or later, and have installed using the max binaries, the

necessary tools are already installed on your machines. If you’re using an older version of

MySQL, or have installed from the standard binary package, you need to update to a more

current version of MySQL.

The max binary package includes binaries that have cluster support compiled inside them.

The installation also sticks a collection of binaries in your bin directory, including the storage

node daemon (ndbd), the management node daemon (ndb_mgmd), and the management client,

ndb_mgm.

■Note MySQL’s instructions for installing the management node include making a copy of only the neces-

sary binary files ndb_mgmd and ndb_mgm into a directory and discarding the rest of the installation. This

reduces the number of files on your system, but isn’t necessary for running the cluster management node.

If you’ve installed the max binary, it’s not necessary to remove the extra files.

Initial Configuration and Startup

With all your machines equipped with the latest max binary, you’re ready to get in, do some

configuring, and start up your cluster. You’ll first configure and start the management server,

then configure and start the storage nodes, and finally start up with SQL nodes. For the pur-

pose of our example, we’ll use the setup shown in Figure 19-3, which has a management node,

two storage nodes, and two SQL nodes.

Management Node

The management server is the first place to start. You must configure and start it before the

storage and SQL nodes are started, or they’ll fail on startup.

Configure

The management node requires the most significant configuration, but it’s still fairly straight-

forward to put together. You should put the configuration file in a location that will be used for

the cluster log files. For our example, we put it at /var/lib/mysql, but you may have another

preference. With your favorite editor, create a file /var/lib/mysql/config.ini that looks like

Listing 19-3.


C H A P T E R   1 9   ■ C L U S T E R

Listing 19-3. Sample Management Node Configuration

[NDBD DEFAULT]

NoOfReplicas=2

DataMemory=80M

IndexMemory=52M

[TCP DEFAULT]

[NDB_MGMD]

hostname=<ip of your management node>

datadir=/var/lib/mysql

[NDBD]

hostname=<ip of first storage node>

datadir=/var/lib/mysql

[NDBD]

hostname=<ip of second storage node>

datadir=/var/lib/mysql

[MYSQLD]

hostname=<ip of SQL node>

[MYSQLD]

hostname=<ip of SQL node>

We’ll go into more detail on what’s happening in this configuration file later in the chap-

ter. For now, you get an idea that we have several different sections, similar to the my.cnf file,

the first two applying to all nodes and the remaining four applying to individual nodes in the

cluster. The configuration file has one [NDBD] section for each storage node and one [MYSQLD]

section for every SQL node in the cluster.

Start

With the configuration file created for the management server, it’s time to start the manage-

ment server. Listing 19-4 shows the command to run as root (change the path if your MySQL

binaries are located elsewhere).

Listing 19-4. Command to Start the Cluster Management Daemon

shell> /usr/local/mysql/bin/ndb_mgmd -f /var/lib/mysql/config.ini

You shouldn’t see any output when starting up the management daemon. In fact, if

you do see some output, it’s likely to be about an error in the configuration file. Listing 19-5

displays what might show up if you had an error on line 3 of your configuration file.


C H A P T E R   1 9   ■ C L U S T E R

Listing 19-5. Sample Error from the Management Daemon

Error line 3: Parse error

Error line 3: Could not parse name-value pair in config file.

Unable to read config file

If you see output like Listing 19-5, look at the line number in your configuration file and

check it against the documentation.

Storage Nodes

With the management node up and running, you’re ready to configure and start up the stor-

age nodes. You’ll need to follow these steps for each storage node in your cluster.

Configure

The configuration for storage nodes goes right into your standard my.cnf file. Add the lines

shown in Listing 19-6.

Listing 19-6. Sample Storage Node Configuration

[MYSQL_CLUSTER]

ndb-connectstring=<ip of management node>

The storage node daemon uses the MYSQL_CLUSTER section options when starting up. You

only need one option for the storage node to operate: the location of the management server.

For our initial setup, everything else is contained in the management node’s configuration file.

Before you move on to starting up the node, be sure the data directory you specified in

the management node exists.

Start

To start the storage node for the first time, use the command in Listing 19-7. You should only

pass the --initial option the first time the daemon is started, or any time you want to reload

the configuration. Using this option removes all node recovery files.

Listing 19-7. Command to Start the Cluster Storage Node Daemon

shell> /user/local/mysql/bin/ndbd --initial

If the management server isn’t available, you’ll get an error during startup indicating that

it couldn’t find the management server.

SQL Node

With the management node and storage nodes up, we’re ready to configure and start the final

piece: the SQL node that allows us to interact with the storage engine.


C H A P T E R   1 9   ■ C L U S T E R

Configure

The configuration options for the SQL node go into your my.cnf file, right in the [mysqld] sec-

tion of your configuration, as shown in Listing 19-8.

Listing 19-8. Sample Configuration for the SQL Node

[MYSQLD]

ndbcluster

ndb-connectstring=<ip of management node>[:<port>]

The ndbcluster option tells this MySQL server that it will have the cluster as an engine

and that it should pull information about the cluster from the management server. The default

port is 1186. The port isn't required, but if your SQL nodes aren’t connecting when you start

them, add the port to the ndb-connectstring.

Start

To start up a SQL node, you simply start the MySQL server as you would normally. Listing 19-9

shows the startup command we’re so familiar with, to be run as root.

Listing 19-9. Start the SQL Node of the Cluster

shell> /usr/local/mysql/bin/mysqld_safe &

If the management server isn’t available, you’ll get an error during startup indicating that

it couldn’t find the management server.

Check Processes

We’ll cover the management client in greater detail later in the chapter, but before we call our

initial startup good, let’s take a quick peek at the cluster from the view of the management

client. On the management server, start the management client and issue the SHOW command

as shown by the two statements in Listing 19-10.

Listing 19-10. Start the Cluster Management Client

shell> /usr/local/mysql/bin/ndb_mgm

ndb_mgm> show

The result of this command should be something like the output in Listing 19-11.

Listing 19-11. Output from the Cluster SHOW Command

Cluster Configuration

---------------------

[ndbd(NDB)]     2 node(s)

id=2    @10.0.0.103  (Version: 4.1.12, Nodegroup: 0, Master)

id=3    @10.0.0.104  (Version: 4.1.12, Nodegroup: 0)


C H A P T E R   1 9   ■ C L U S T E R

[ndb_mgmd(MGM)] 1 node(s)

id=1    @10.0.0.102  (Version: 4.1.12)

[mysqld(API)]   2 node(s)

id=4    @10.0.0.103  (Version: 4.1.12)

id=5    @10.0.0.104  (Version: 4.1.12)

You can see from the output in Listing 19-11 that we have two storage nodes, one man-

agement node, and two SQL nodes running. You can also see that the storage node with ID 2 is

specified to serve as the master record for the data. If you get output indicating the node isn’t

connected, you may need to go back to the machine and verify that the process started and

that the configuration file is correct on the node. If complications continue, you may want to

look in the logs, which will be discussed shortly.

Once the cluster is set up, you probably want to see it in action. To do so, let’s get on one

of our SQL nodes and interact with the cluster.

To start, we’ll get on the SQL node with the ID of 4 and create a table, customer, and insert

some data, as shown in Listing 19-12.

Listing 19-12. Create a Table in the Cluster

mysql-node4> CREATE TABLE customer (

-> customer_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,

-> name VARCHAR(10)

-> ) ENGINE=NDBCLUSTER;

Query OK, 0 rows affected (0.69 sec)

mysql-node4> INSERT INTO customer VALUES (1,'Mike'),

-> (2,'Jay'),

-> (3,'Johanna'),

-> (4,'Michael'),

-> (5,'Heidi'),

-> (6,'Ezra');

Query OK, 6 rows affected (0.01 sec)

Records: 6  Duplicates: 0  Warnings: 0

■Note When creating databases to be used in MySQL Cluster, you must issue the CREATE DATABASE

statement on each SQL node in the cluster, as the statement isn’t propagated to each node in the cluster.

The CREATE TABLE statement in Listing 19-12 is like any other statement to create a table,

except it specifies that the cluster should be used for storing the table and data with the

ENGINE = NDBCLUSTER syntax.

With the table created and data inserted in the cluster, you should be able to see those

changes from the other SQL node. Listing 19-13 shows a SELECT statement issued on SQL node 5.


C H A P T E R   1 9   ■ C L U S T E R

Listing 19-13. SELECT Data from the Other SQL Node

mysql-node5> SELECT * FROM customer;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | Mike    |

|           3 | Johanna |

|           5 | Heidi   |

|           6 | Ezra    |

|           2 | Jay     |

|           4 | Michael |

+-------------+---------+

6 rows in set (0.11 sec)

The SELECT statement on the other SQL node demonstrates that you can get at the data

from either of the SQL nodes.

To further prove that the cluster is operating correctly, let’s simulate a situation where one

of the nodes becomes unavailable and make sure that you can still use the database and bring

the node back from the crash.

First, remove the customer table from the cluster:

mysql-node4> DROP TABLE customer;

Query OK, 0 rows affected (0.50 sec)

mysql-node4> SHOW tables;

Empty set (0.01 sec)

Now, to see what happens when a storage node is removed from the cluster, pull the node

identified with ID 2 for storage and ID 4 for SQL. When we remove this node (whether it be by

pulling the power or network cord), the SHOW statement on the management node indicates

that nodes in the configuration aren’t connected. Listing 19-14 shows the status after this node

is removed.

Listing 19-14. Output from the Cluster SHOW Command with Disconnected Nodes

Cluster Configuration

---------------------

[ndbd(NDB)]     2 node(s)

id=2 (not connected, accepting connect from 10.0.0.103)

id=3    @10.0.0.104  (Version: 4.1.12, Nodegroup: 0)

[ndb_mgmd(MGM)] 1 node(s)

id=1    @10.0.0.102  (Version: 4.1.12)

[mysqld(API)]   2 node(s)

id=4 (not connected, accepting connect from 10.0.0.103)

id=5    @10.0.0.104  (Version: 4.1.12)


C H A P T E R   1 9   ■ C L U S T E R

With the server at IP 10.0.0.103 missing, the SHOW command indicates that an expected

storage and SQL node aren’t connected.

However, even while those two nodes are missing, you can still connect to SQL node 5

and interact with the data. With a node down, you can continue to create tables and data as

if the database were completely available. Listing 19-15 shows how you’d look at the existing

tables and create the customer table again. This time you’re creating it on node 5 while nodes

4 and 2 are offline.

Listing 19-15. Creating a Table with Unavailable Database Nodes

mysql-node5> show tables;

Empty set (0.01 sec)

mysql-node5> CREATE TABLE customer (

-> customer_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,

-> name VARCHAR(10)

-> ) ENGINE=NDBCLUSTER;

Query OK, 0 rows affected (0.55 sec)

mysql-node5> INSERT INTO customer VALUES (1,'Mike'),

-> (2,'Jay'),

-> (3,'Johanna'),

-> (4,'Michael'),

-> (5,'Heidi'),

-> (6,'Ezra');

Query OK, 6 rows affected (0.01 sec)

Records: 6  Duplicates: 0  Warnings: 0

You’ve just created a new table and inserted a number of rows of data while node 4 was

completely unavailable. If you bring node 4 back up, as shown in Listing 19-16, the SHOW com-

mand on the management node indicates that the storage and SQL nodes are back up and

functioning on that server.

Listing 19-16. Output from the Cluster SHOW Command with Reconnected Nodes

Cluster Configuration

---------------------

[ndbd(NDB)]     2 node(s)

id=2    @10.0.0.103  (Version: 4.1.12, Nodegroup: 0)

id=3    @10.0.0.104  (Version: 4.1.12, Nodegroup: 0, Master)

[ndb_mgmd(MGM)] 1 node(s)

id=1    @10.0.0.102  (Version: 4.1.12)

[mysqld(API)]   2 node(s)

id=4    @10.0.0.103  (Version: 4.1.12)

id=5    @10.0.0.104  (Version: 4.1.12)


C H A P T E R   1 9   ■ C L U S T E R

You might ask, “Will the node that was unavailable be brought up to speed with data in

the other node?” The answer is yes. When the unconnected node is brought back online, the

data from the good node is replicated back onto the server. A SELECT on node 4, which was

unavailable as you created the table and inserted data on node 5, shows that the data is also

available on node 4 after it comes back online. Listing 19-17 shows the records in the customer

table.

Listing 19-17. Records in the Formerly Failing Node

mysql-node4> SELECT * FROM customer;

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           4 | Michael |

|           1 | Mike    |

|           3 | Johanna |

|           5 | Heidi   |

|           6 | Ezra    |

|           2 | Jay     |

+-------------+---------+

6 rows in set (0.02 sec)

This simple example demonstrates that data is duplicated across storage nodes, and that

the nodes communicate changes in data as nodes come and go from the cluster. This means

that you can get data from any connected SQL node. It also means you can trust that if a node

goes down, your data will be available through the other nodes, and when you bring the fail-

ing node back up it will automatically get up to speed on data from the other storage nodes.

Cluster Processes

As we ran through the quick configuration and startup details, you used a few cluster tools

that deserve more attention. These tools are ndb_mgmd, the management server daemon; ndbd,

the storage node daemon; and ndb_mgm, the management client.

Management Server

The management node runs a server that provides management commands to control the

cluster. This daemon, ndb_mgmd, also holds the configuration information for all nodes in the

cluster and provides central logging for each of the nodes. Table 19-1 shows a complete list of

startup options.

Table 19-1. ndb_mgmd Startup Options

Option

-?, --usage, --help

-V, --version

Description

Show help information and exit.

Display information about the version and exit.


C H A P T E R   1 9   ■ C L U S T E R

Option

Description

--ndb-connectstring=<connect string>

Set the connection string for making contact with

the management node. Format is [nodeid=<id>;]➥

<hostname>[:<port>]. In most cases, this will be just

an IP address or hostname.

--ndb-shm

Enable shared memory connections if available.

--ndb-optimized-node-selection

Use an optimization mechanism to choose nodes for

transactions. Default is round robin.

-f, --config-file=<file>

Use the specified configuration file on startup.

-d, --daemon

--interactive

--no-nodeid-checks

--nodaemon

Run in daemon mode. This is on by default.

Run in interactive mode (a shell). Used for testing,

there isn’t much you can do from the shell.

Do not check node IDs.

Do not run as a daemon. It is keeping the process

running in the terminal.

Storage Node

Each storage node runs a daemon that’s responsible for responding to requests for retrieving

and storing data. This process is started up after the management server is running, and pulls

information about the cluster from the management node’s configuration file. Table 19-2

shows the available startup options that can be passed to ndbd on the command line.

Table 19-2. ndbd Startup Options

Option

-?, --usage, --help

-V, --version

-c, --ndb-connectstring=<connect string>

--ndb-optimized-node-selection

--ndb-shm

--initial

-n, --nostart

-d, --daemon

--nodaemon

Description

Show help information and exit.

Display information about the version and exit.

Set the connection string for making contact with

the management node. Format is [nodeid=<id>;]➥

<hostname>[:<port>]. In most cases, this will be

just an IP address or hostname.

Enable shared memory connections if available.

Use an optimization mechanism to choose nodes

for transactions. Default is round robin.

Perform file cleanup and read configuration

options from the management server. Use caution

with this option; using it at the wrong time can

remove important files. This option is intended for

use on first start of ndbd and only for subsequent

starts where the logs need to be removed and

configuration reread.

Run the daemon, but don’t start full operation until

the management node issues the start command.

Run in daemon mode. This is the default.

Do not run as a daemon. It is keeping the process

running in the terminal.


C H A P T E R   1 9   ■ C L U S T E R

Management Client

The management client is a command-line tool that allows you to monitor and manage the clus-

ter. Most of this tool’s usefulness comes from the commands you can issue in interactive mode,

but there are also a number of startup options. The startup options are shown in Table 19-3.

Table 19-3. nbd_mgm Startup Options

Option

-?, --usage, --help

-V, --version

-c, --ndb-connectstring=<connect string>

--ndb-shm

--ndb-optimized-node-selection

-e, --execute=<command>

-t, --try-reconnect=<number>

Description

Show help information and exit.

Display information about the version and exit.

Set the connection string for making contact with

the management node. Format is [nodeid=<id>;]➥

<hostname>[:<port>]. In most cases, this will be

just an IP address or hostname.

Enable shared memory connections if available.

Use an optimization mechanism to choose nodes

for transactions. Default is round robin.

Instead of launching the interactive shell, execute

the command, print the output, and exit. See

Table 19-8 for a complete list of commands.

Try to connect to the management server every

5 seconds for this number of times. Default is 3.

For more information on the commands when the management client is running, or that

can be used with the -e flag, see the section “Managing the Cluster.”

Configuration File Options

You got a taste for some of the configuration file options in your initial cluster setup, and now

you are familiar with all the startup options for the various cluster programs. Now let’s take a

close look at the configuration file options for each of the nodes—meaning the management,

storage, and SQL nodes. Options are stored in either the config.ini or my.cnf configuration

files. Even if you won’t use all these options, having an awareness of the different sections in

the configuration files and what options are available in each is helpful to understanding how

the cluster runs, and all the option possibilities.

Management Server Configuration File

The management server configuration file is typically config.ini, and goes in the data direc-

tory on the machine where the management node will run. Six different configuration groups

are in your config.ini: COMPUTER, MYSQLD, NDB_MGM, NDBD, TCP, and SHM. Each of these sections

has different options and values. Let’s look at the significant ones, which exclude TCP and SHM.

More information on all the options can be found at this URL: http://dev.mysql.com/doc/

mysql/en/mysql-cluster-config-example.html.


C H A P T E R   1 9   ■ C L U S T E R

■Tip The use of DEFAULT within the section declaration (for example, [MYSQLD DEFAULT]) tells the man-

agement server that the options and values apply to any node of that section type. If you want to have

some options apply to all nodes, and then some that apply to a node individually, you can use both a

[MYSQLD DEFAULT] that applies to all SQL nodes and several [MYSQLD] sections that apply to specific

SQL nodes.

COMPUTER

Table 19-4 shows all the options available in the COMPUTER section of config.ini. This section

is a place to define the machines in the cluster. If the COMPUTER section is used, the id and

hostname options are required.

Table 19-4. COMPUTER Options in Management Server Configuration

Option

Description

id=<number>

ID of the server.

hostname=<name>

IP address or hostname of the computer.

MYSQLD

The MYSQLD section is used one time for every SQL node in the cluster. Table 19-5 has all the

options available for this section.

Table 19-5. MYSQLD Options in Management Server Configuration

Option

Description

arbitrationdelay=<number>

Number of milliseconds the SQL node will delay before

responding to an arbitration.

arbitrationrank=<number>

batchbytesize=<number>

batchsize=<number>

A SQL node’s arbitration power can be set to 0, 1, or 2 to indicate

no arbitration, high priority, or low priority in arbitration. Only

SQL and management nodes can arbitrate.

Set the number of byte increments to use when fetching records

from the data node.

Set the number of record increments used when fetching

records from the data node.

executeoncomputer=<name>

A pointer to a machine named in the COMPUTER section. Takes the

computer ID as the value.

id

ID of the server.

maxscanbatchsize=<number>

Limits the amount of data coming to the SQL node from all data

nodes. The default is 256KB, maximum is 16MB.


C H A P T E R   1 9   ■ C L U S T E R

NDB_MGMD

Table 19-6 has all the options available in the NDB_MGMD section of the management configura-

tion file. You can also identify this section using [MGM].

Table 19-6. NDB_MGMD Options in Management Server Configuration

Option

Description

arbitrationdelay=<number>

Number of milliseconds the management server will delay before

responding to an arbitration.

arbitrationrank=<number>

Management node’s arbitration power can be set to 0, 1,

or 2 to indicate no arbitration, high priority, or low priority in

arbitration. Only management and SQL nodes can arbitrate.

datadir=<dir>

Directory where log files should be stored.

executeoncomputer=<name>

A pointer to a machine named in the COMPUTER section. Use the

defined ID.

id=<number>

ID of the server.

logdestination=<name>

The place where the management server should send the logs;

can be any combination of console, syslog, or file. Multiple

logging options are separated by a semicolon. See the MySQL

documentation for information on customizing the management

logging at http://dev.mysql.com/doc/mysql/en/mysql-➥

cluster-event-reports.html.

portnumber=<number>

The port number that the management node uses to

communicate with the other nodes.

■Note In the configuration file for the management and SQL node, you see some settings for arbitration.

Arbitration is required when nodes in the cluster become unavailable and a process needs to decide if

enough nodes are left to represent the data fully, and which of those nodes will constitute the new cluster

while some of the nodes are unavailable.

NDBD

The NDBD section is used for defining storage nodes in the cluster, and should appear once for

each storage node. In addition, the configuration must have an [NDBD DEFAULT] section with

noofreplicas and either hostname or executeoncomputer. Table 19-7 shows the most significant

options for this section; see this web site for the complete list of options and explanations:

http://dev.mysql.com/doc/mysql/en/mysql-cluster-config-example.html.


C H A P T E R   1 9   ■ C L U S T E R

Table 19-7. NDBD Options in Management Server Configuration

Option

Description

backupdatadir=<dir>

Directory for backup files. By default, backupdatadir is stored in a

BACKUP folder in the filesystempath directory (which defaults to

datadir).

datadir=<dir>

Directory where trace, log, and error files should be stored.

datamemory=<number>

Specifies the amount of memory that can be used for storing data.

executeoncomputer=<name>

A pointer to a machine named in the COMPUTER section. Takes the

computer ID as the value.

filesystempath=<path>

hostname=<name>

id=<number>

indexmemory=<number>

noofreplicas=<number>

serverport=<number>

Location where metadata, UNDO, and REDO logs are stored. Default

is datadir. Directory must exist before ndbd starts.

IP address or hostname of the computer.

ID of the server.

Specifies the amount of memory that can be used for storing

indexes.

Number of duplicates of the data to be stored on the storage

nodes. In most cases, 2 provides enough redundancy. Maximum

value is 4.

Port number other storage nodes should use when attempting to

connect to this node.

Storage Node Configuration

The options for configuring the storage node are put into the standard my.cnf file, in the

[MYSQL_CLUSTER] section. There is only one option and value, the ndb-connectstring, which

should be pointed at the management node of your cluster.

SQL Node Configuration

Configuration options for the SQL node go into the standard my.cnf file. There’s no special

section for the SQL node, configuration options going under the standard [MYSQLD] section.3

There are only two options that are related to the SQL node in this section: ndbcluster and

ndb-connectstring.

Putting the ndbcluster option in the configuration file tells the MySQL server to bring up

the NDBCLUSTER storage engine when it starts up. The ndb-connectstring is the IP address or

hostname for the management server. The connect string can also contain the node ID and

port to get to the management server.

3. For more information on the [MYSQLD] configuration group and the MySQL configuration files in

general, see Chapter 14.


C H A P T E R   1 9   ■ C L U S T E R

Managing the Cluster

Managing a cluster, especially when there’s a large pool of storage and SQL nodes, can be a

daunting task. When your cluster is up and running, you’ll need to think about things such as

how to stop and start nodes to perform server upgrades, when and how to back up your data,

and what to do if you’ve had a disaster and your data is corrupt or gone.

Management Client

The management client is a good place to start when learning about cluster management and

putting together a plan for how you’ll carry out backup, recovery, or scheduled maintenance.

The set of commands available in the management client give you a good deal of control over

the nodes in your cluster. Table 19-8 shows a complete list of commands available in the

ndb_mgm tool. In many commands, a <severity> option is specified. These values can be any

combination of alert, critical, error, warning, info, or debug.

Table 19-8. ndb_mgm Client Commands

Command

HELP

SHOW

START BACKUP [NOWAIT | WAIT ➥

STARTED | WAIT COMPLETED]

ABORT BACKUP <id>

SHUTDOWN

Description

Print all the commands, with their descriptions.

Output a complete status for the cluster. This includes

information on and status of the management node and

all storage and SQL nodes.

Start the backup process. When running the backup, either

don’t wait for the process to start before returning, wait

until the backup has started to return, or wait until the

backup has completed before returning to the shell.

Stop the backup with the specified ID. The ID is returned

from the START BACKUP command.

Stop all processes in the cluster. This command stops all

storage and SQL nodes, then stops the management

server.

CLUSTERLOG ON [<severity>]

Turn on cluster logging, with an optional severity label.

CLUSTERLOG OFF [<severity>]

Turn off cluster logging for the specific severity level if

included.

CLUSTERLOG FILTER [<severity>]

For the specified severity, toggle logging on or off.

CLUSTERLOG INFO

<id> START

<id> RESTART

<id> STOP

ENTER SINGLE USER MODE <id>

EXIT SINGLE USER MODE

<id> STATUS

Print information about cluster logging. The output is a list

of severities that are enabled.

Start a particular database node (or all of them with ALL).

Restart a particular database node (or all of them with ALL).

Stop a particular database node (or all of them with ALL).

Go into single user mode with the specified node as the

only one to accept updates from. The specified node must

be a SQL node.

Go out of single user mode, allowing all SQL nodes to

resume sending statements to the storage nodes.

Show status information for the specified node (or all of

them with ALL).


C H A P T E R   1 9   ■ C L U S T E R

Command

Description

PURGE STALE SESSIONS

Have the management server reset reserved node IDs.

CONNECT [<connectstring>]

Connect, or reconnect if already connected, to the

specified management server.

QUIT

Exit the management client.

■Note To be clear, a proper shutdown and startup of a node won’t result in the loss of data, even though

the data is cleared from where it’s stored in memory when ndbd stops. When the shutdown statement is

issued from the management node, each storage node writes its data to disk before exiting. When the node

starts back up, the data is loaded from the disk back into memory.

Single User Mode

The single user mode command is in the list of commands in Table 19-8, but we thought it

important to talk about in more detail. If you’re trying to pinpoint a problem with your appli-

cation or database and want to restrict access temporarily to the cluster, the single user mode

is a helpful command in the features of MySQL Cluster.

Single user mode allows you to specify that updates to the storage nodes should be lim-

ited to a specific node. The command, shown in Listing 19-18, demonstrates how to stop all

commands except for those from SQL node 2.

Listing 19-18. Command to Enter Single User Mode

ndb_mgm> ENTER SINGLE USER MODE 2

■Note Entering a node ID of a node that isn’t a SQL node causes the command to fail.

After entering single user mode, only that node is allowed to send statements to the stor-

age nodes. Once you’re finished with your debugging, you can exit single user mode with the

statement in Listing 19-19, which reinstates all SQL nodes in the cluster.

Listing 19-19. Command to Exit Single User Mode

ndb_mgm>EXIT SINGLE USER MODE

Backing Up and Restoring

Even if you have completely redundant systems, backing up and being capable of restoring

your cluster’s data is important. Remember, until the MySQL development team implements

a disk-based storage mechanism, all your data is in the memory of your storage nodes. If you

ever have a power outage, or a problem with enough of your storage nodes that you lose your


C H A P T E R   1 9   ■ C L U S T E R

data, you’ll need a way to restore the data back into memory once the machines come back

up. Chapter 17 covered creating backup policies and implementation plans in detail.

mysqldump

Because mysqldump is storage-engine independent, you can always use it to create a scheduled

(or unscheduled) dump of your data. This is wise if you want to have backups for the purpose

of restoring single databases or tables. For complete details on using the mysqldump utility to

back up and restore data, see Chapter 17.

Cluster Backup and Restore

The other backup option is to use the built-in cluster backup tools that come with MySQL.

These tools allow you to create a complete backup of your cluster data. You issue the backup

command in the management client, as shown in Listing 19-20.

When the backup is started, the management client prints a few statements that show

the ID that has been assigned to the backup. Listing 19-21 shows the statement that’s printed

when the backup has started, showing that the backup ID assigned is 3.

Listing 19-20. Starting a Cluster Backup

ndb_mgm> START BACKUP

Listing 19-21. Finding the Backup ID

Backup 3 started

Make note of this backup ID—you’ll need it if you want to restore, and it’s necessary if

you decide to cancel the backup. When the backup has completed, each node will have a set

of backup files: one for the data dictionary information, a second with the actual data, and a

third with the transaction log with information about when and how data was stored in the

nodes.

To restore from this backup, the cluster database must first be empty. You can do this by

shutting down the storage nodes and starting them back up with the --initial option, which

cleans out the log and data files. You must issue the restore command on each storage node,

but you also need to restore the metadata (table structures) on the first node to be restored.

Listing 19-22 shows the command that should be issued on the first node that’s restored. You

need to be in the directory where the backup files were created on the node.

Listing 19-22. Cluster Restore with Schema Create

/usr/local/mysql/bin/ndb_restore --restore_meta --nodeid=<node id>

--backup_id=<backup id>

Once the first node has been restored, you can issue the same statement on the remain-

ing nodes, but without the --restore_meta option to finish the restore.


C H A P T E R   1 9   ■ C L U S T E R

Log Files

We’ve seen some of the configuration options and commands to set up and change output to

the log files. We haven’t seen the different log files, and what they might contain.

Your cluster contains two kinds of logs: a cluster log and a node log. Both these types of

log files contain information about node connections, checkpoints, startup, restarts, statistics,

and errors.

Cluster Log

The cluster log is located in the data directory of the management server, and contains infor-

mation about the entire cluster, including the management, storage, and SQL nodes. The

cluster log file is named ndb_<id>_cluster.log, the ID being the ID of the management node.

Listing 19-23 shows a few lines from a cluster log file.

Listing 19-23. Sample Output from a Cluster Log File

shell> more ndb_1_cluster.log

2005-07-08 15:54:29 [MgmSrvr] INFO     -- NDB Cluster Management Server.

Version 4.1.12

2005-07-08 15:54:29 [MgmSrvr] INFO     -- Id: 1, Command port: 1186

2005-07-08 15:54:29 [MgmSrvr] INFO     -- Node 1: Node 2 Connected

2005-07-08 15:54:29 [MgmSrvr] INFO     -- Node 1: Node 3 Connected

In this cluster log, we see that the management node has started and two nodes have con-

nected to the cluster.

Node Log

The node log lives in the data directory of each node, and only contains information specific

to that node. This log file is named ndb_<id>_out.log, the ID being the ID of the node. Listing

19-24 shows a sample of a few lines from a storage node log file.

Listing 19-24. Sample Output from a Node Log File

shell> more ndb_2_out.log

2005-07-08 16:19:23 [NDB] INFO     -- Angel pid: 738 ndb pid: 739

2005-07-08 16:19:23 [NDB] INFO     -- NDB Cluster -- DB node 2

2005-07-08 16:19:23 [NDB] INFO     -- Version 4.1.12 --

2005-07-08 16:19:23 [NDB] INFO     -- Configuration fetched at 10.0.0.2 port 1186

Listing 19-24 shows that the storage node started up and was able to pull configuration

information from the configuration file on the management node.

The MySQL documentation contains detailed information about what kinds of messages

you’ll see in the logs.


C H A P T E R   1 9   ■ C L U S T E R

Security

By default, MySQL Cluster isn’t secure. There are no permission checks when connections are

made to the management server, which can leave you open to all kinds of unwanted behavior.

Data transfer between nodes in the cluster and interaction between the management server

and nodes aren’t encrypted, and are left open for anyone to sniff. If you run your cluster on a

public network, you expose all the data in your database and leave yourself open for anyone

to connect to the management server to play with the cluster configuration and possibly shut

down the cluster.

For these reasons, we recommend implementing a network-layer mechanism for protec-

tion. Your best bet is to use a private network for cluster communication, and limit connections

to the management server to within the private network. If this isn’t possible, you might want to

implement a set of firewall rules that restrict database communication between the manage-

ment server and nodes to those on your network.

The MySQL permissions tables still control access to the actual data in the cluster databases

and tables. Any connection to the SQL node with a database statement goes through the rigors

of MySQL’s authentication and authorization mechanism. Chapter 15 fully explains authentica-

tion and authorization.

Summary

Cluster technology in MySQL is exciting, and holds a lot of promise for the future of highly

available databases. Although there are some limitations in MySQL’s cluster implementation,

the storage engine is stable and being developed actively enough to make concerns about the

limitations short-term.

Using the cluster engine is no different from any other storage engine, but setting up the

cluster requires some extra work, and extra servers. The configuration and startup of the clus-

ter nodes is fairly straightforward, and should be familiar to those who have worked with the

MySQL configuration files and server before. You can use many configuration options to cus-

tomize the cluster to meet your implementation needs.

If you need a database that has high availability, MySQL Cluster is worth a close look.

Although MySQL continues to provide simplicity in its MyISAM and InnoDB engines, this

storage engine demonstrates that MySQL is serious about meeting the rigorous demands of

mission-critical, highly available databases.


C H A P T E R   2 0

■ ■ ■

Troubleshooting

If you’ve been using MySQL as the database back-end for your application for any amount of

time, you’ve probably experienced problems of some sort. For example, a user may have been

attempting to run her query in the database, and after several attempts to get to the mysql>

prompt, gave up in frustration and sent you an e-mail containing the message she saw on

her terminal:

ERROR 2002 (HY000): Can't connect to local MySQL server through socket

'/tmp/mysql.sock'

Or maybe, as you executed the final steps of the release of a new piece of functionality

on your web-based software, you went to the site to start browsing around. After a few proud

clicks, you came across the following message on your web browser:

Warning: mysqli_connect(): Access denied for user 'webuser'@'localhost'

(using password: YES) in /home/promysql/web/customer_basket.php on line 32

Failed to connect: Access denied for user 'webuser'@'localhost'

(using password: YES)

No matter how much time you spend working to anticipate and prevent problems in your

database-backed system, you should be prepared to resolve issues that arise. Even if you’ve

designed the perfect application and database, pieces within the systems change over time,

require upgrades, rely on external resources, and are used in unexpected ways. At some point,

you will need to figure out what might be the cause of poor performance, or you may even

need to deal with a system that is totally unavailable.

Troubleshooting is a very general term, covering a wide expanse of technical ground. In

this chapter, we’ll begin by covering what types of tools are useful for MySQL troubleshooting.

Then we’ll discuss a spectrum of issues that will help you in determining the cause of per-

formance bottlenecks or a completely unavailable database. This chapter will cover the

following topics:

• Common problems: indicators and suggested solutions

• Troubleshooting tools

• MySQL bug reporting

• MySQL support options


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Troubleshooting Toolkit

A number of tools can be helpful when you’re troubleshooting a problem with your database.

These include MySQL logs, the MySQL thread list, your operating system process list, and

monitoring programs.

Error Logs

The first time MySQL starts, it creates a file where it logs information about startup, shutdown, and

critical errors. By default, this file is put in your data directory and is named <server_name>.err.

You can change the name and location of the error log by using the --log-error=<file>

startup option.

Error log entries start with the date and time, in YYMMDD HH:MM:SS format, and then contain

a message indicating what is happening in the database at that particular time.

The error log is a valuable resource when troubleshooting issues with your server. It not

only contains a record of details about problems the server has encountered, but it also has a

history of when your server was stopped, started, and restarted (manually, as well as automat-

ically with mysqld_safe). When you’re troubleshooting, knowing what errors are occurring and

when the database was last restarted can be critical pieces of information.

■Tip MySQL maintains a document about using the log files to find errors. The document can be found at

http://dev.mysql.com/doc/mysql/en/using-log-files.html.

Startup Entries

For a server startup using mysql.server to start the database, without configuration options,

the log file will contain something like the output shown in Listing 20-1.

Listing 20-1. Entries in Log for Startup

050430 13:45:48  mysqld started

050430 13:45:48  InnoDB: Started; log sequence number 0 43655

050430 13:45:48  InnoDB: Starting recovery for XA transactions...

050430 13:45:48  InnoDB: 0 transactions in prepared state after recovery

050430 13:45:48 [Note] /usr/local/mysql/bin/mysqld: ready for connections.

Version: '5.0.6-beta-max-log'  socket: '/tmp/mysql.sock'  port: 3306

MySQL Community Edition - Experimental (GPL)

As you can see, this example shows messages from the MySQL daemon as well as the

InnoDB storage engine as they start. In the end, you see a ready for connections message,

with a log of information about the version, socket, and port used by the server. This indicates

that the server has successfully started.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

The startup entries in the error log can be more extensive. If you’re starting MySQL for the

first time after going through the installation process, you’ll see a lot more information about

InnoDB getting the environment set up. Listing 20-2 shows the log entries during initial

startup of a MySQL server.

Listing 20-2. Entries in Log for Initial Startup

050430 13:22:49  mysqld started

InnoDB: The first specified data file ./ibdata1 did not exist:

InnoDB: a new database to be created!

050430 13:22:49  InnoDB: Setting file ./ibdata1 size to 10 MB

InnoDB: Database physically writes the file full: wait...

050430 13:22:50  InnoDB: Log file ./ib_logfile0 did not exist: new to be created

InnoDB: Setting log file ./ib_logfile0 size to 5 MB

InnoDB: Database physically writes the file full: wait...

050430 13:22:50  InnoDB: Log file ./ib_logfile1 did not exist: new to be created

InnoDB: Setting log file ./ib_logfile1 size to 5 MB

InnoDB: Database physically writes the file full: wait...

InnoDB: Doublewrite buffer not found: creating new

InnoDB: Doublewrite buffer created

InnoDB: Creating foreign key constraint system tables

InnoDB: Foreign key constraint system tables created

050430 13:22:50  InnoDB: Started; log sequence number 0 0

050430 13:22:50  InnoDB: Starting recovery for XA transactions...

050430 13:22:50  InnoDB: 0 transactions in prepared state after recovery

050430 13:22:50 [Note] /usr/local/mysql/bin/mysqld: ready for connections.

Version: '5.0.6-beta-max-log'  socket: '/tmp/mysql.sock'  port: 3306

MySQL Community Edition - Experimental (GPL)

Shutdown Entries

When MySQL shuts down normally, you see lines like those shown in Listing 20-3 in your

error log.

Listing 20-3. Entries in Log for Shutdown

050430 16:05:23 [Note] /usr/local/mysql/bin/mysqld: Normal shutdown

050430 16:05:23  InnoDB: Starting shutdown...

050430 16:05:25 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete

050430 16:05:25  mysqld ended

If the InnoDB storage engine isn’t a part of your server, your log won’t contain the notice

about the storage engine shutting down.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Critical Error Entries

Beyond showing a record of the database starting and stopping, the error log provides a place

to look for information about critical problems in the database. For example, suppose you

attempt to start MySQL using the mysql.server script but get a failure:

Starting MySQL................................... ERROR!

You can look in the error log to see if it has any information that would help identify the

problem:

050430 15:39:02  mysqld started

050430 15:39:02 [ERROR] /usr/local/mysql/bin/mysqld: unknown variable 'default-

sorage=InnoDB'

050430 15:39:02  mysqld ended

This example shows that somewhere in your configuration files, there is an unknown

variable. Armed with this information, you should be able to resolve the issue.

We could go on for pages talking about everything you might see in your MySQL error

log. The point is to be familiar with the kind of information that is written to the log. Then,

when you’re attempting to resolve an issue with your server, you’ll be able to identify any

abnormalities.

General Query Log

Another helpful place to look for information while troubleshooting a MySQL server is the gen-

eral query log. In this log file, MySQL logs every connection made and every statement sent to

the server. The general query log is enabled with the --log option in your configuration file. The

default location for this log is in your data directory, with the filename <hostname>.log. You can

change the path and location of the log file by specifying a value in your --log configuration

option, such as --log=/var/log/mysql/query.log. Queries are entered into this log file as the

server receives them, not after they are executed, as they are entered in the binary log.

The general query log stores data in plain text, readable by any text viewer or editor. The

log contains the time of the command, the connection identifier (each connection has a

unique ID), the command type, and the command itself. Listing 20-4 shows a section from

the general query log of the server used for running examples for this book.

Listing 20-4. General Query Log Entries

Time                 Id Command    Argument

050501 13:16:25       1 Connect     root@localhost on

1 Query       drop database if exists shop

1 Query       create database shop

1 Query       SELECT DATABASE()

1 Init DB     shop

1 Query       create table city

(city_id integer not null auto_increment primary key,


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

name varchar(50))

1 Query       insert into city (name)

values ('Boston'),('Columbus'),('London'),('Berlin')

1 Query       create table customer

(customer_id integer not null auto_increment primary key,

name varchar (10),

region integer)

1 Query       insert into customer values (1,'Mike',1)

1 Query       insert into customer values (2,'Jay',2)

1 Query       insert into customer values (3,'Johanna',2)

1 Query       insert into customer values (4,'Michael',1)

1 Query       insert into customer values (5,'Heidi',3)

1 Query       insert into customer values (6,'Ezra',3)

1 Query       load data infile

'/home/mkruck/ProMySQL/examples/Chapter11/customer_data.csv'

into table customer fields terminated by ',' (name,region)

1 Query       create table login

(login_id integer not null auto_increment primary key,

customer_id integer,

login_time datetime,

login_unixtime integer)

1 Query       load data infile

'/home/mkruck/ProMySQL/examples/Chapter11/login_data.csv'

into table login fields terminated by ',' (customer_id,login_unixtime)

1 Query       update login set login_time = from_unixtime

(login_unixtime)

1 Query       create index name on customer (name)

1 Query       create index region on customer (region)

1 Query       create index customer_id on login (customer_id)

050501 15:23:11       2 Query       show tables

050501 15:23:14       2 Query       select * from customer

050501 15:23:19       2 Quit

The query log shows the statements used to create the shop database and set up the city,

customer, and login tables. All of these statements were issued through one connection, with

an ID of 1. The last three statements were through a second connection.

For troubleshooting, the value of the general query log is that you can look at the syntax of

the queries being sent to the database. If you’re experiencing performance problems or client

connection issues, reviewing the general query log can help you determine if a particular

query is causing issues in your system.

■Note Chapter 6 covers how to use the general query log and slow query log for profiling your system.

See that chapter for more details about these logs.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Slow Query Log

The slow query log is a lot like the general query log, except that it logs only queries that

reach a specified time threshold during execution. The slow query log is enabled with the

--log-slow-query option in your configuration file. The default location for this log is in your

data directory, with the filename <hostname>-slow.log. You can change the path and location

of the log file by specifying a value in your --log-slow-query configuration option, such as

--log-slow-query=/var/log/mysql/slow-query.log. To set the threshold for how many sec-

onds must pass before the query is logged, use --long-query-time=<number_of_seconds>.

For every slow query, MySQL logs the current date and time, user, execution time, lock

time, the number of rows sent to the client, the number of rows examined by the query, and

the SQL statement itself. Listing 20-5 shows a few entries from a slow query log on a server

where --long-query-time is set to 1.

Listing 20-5. Slow Query Log Entries

# Time: 050501 15:54:49

# User@Host: root[root] @ localhost []

# Query_time: 4  Lock_time: 0  Rows_sent: 0  Rows_examined: 0

use shop;

SET insert_id=1;

load data infile '/home/mkruck/ProMySQL/examples/Chapter11/login_data.csv'

into table login fields terminated by ',' (customer_id,login_unixtime);

# Time: 050501 15:54:53

# User@Host: root[root] @ localhost []

# Query_time: 4  Lock_time: 0  Rows_sent: 0  Rows_examined: 0

update login set login_time = from_unixtime(login_unixtime);

# Time: 050501 16:01:52

# User@Host: root[root] @ localhost []

# Query_time: 2  Lock_time: 0  Rows_sent: 0  Rows_examined: 0

SET timestamp=1114981312;

update login set login_time = now() where customer_id > 1000;

In this example, the slow query log shows that three queries exceeded the one-second

limit: one to load data into the database and two UPDATE statements.

Familiarity with the slow query log will come in handy when you have a situation where

one query is tying up many tables for long periods of time and interrupting other queries.

MySQL Server Thread List

If it hasn’t happened yet, at some point in your use of MySQL, you’ll want to see a real-time list

of all the connections to the server and what each one is doing. If you have the SUPER privilege,

the SHOW PROCESSLIST command will show you all connections to the database and what each

connection is doing.1

1.

If you do not have the SUPER privilege, SHOW PROCESSLIST will show you the connections for your

account only.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

■Note An alternative to running SHOW PROCESSLIST at the MySQL client prompt is to use the mysqladmin ➥

processlist script, which can be run from the Unix shell. You might prefer this approach if you’re attempt-

ing to set up some automated monitoring of the MySQL connections with a shell script.

The SHOW PROCESSLIST command gives you the connection identifier, user, host, database,

current command, time, and state for each open connection. A sample output of the

SHOW PROCESSLIST command is shown in Listing 20-6.

Listing 20-6. Output from SHOW PROCESSLIST

mysql> SHOW PROCESSLIST\G

*************************** 1. row ***************************

Id: 4

User: root

Host: localhost

db: NULL

Command: Query

Time: 0

State: NULL

Info: SHOW PROCESSLIST

Id: 6

User: root

Host: localhost

db: shop

Command: Query

*************************** 2. row ***************************

Time: 7

State: Repair by sorting

Info: CREATE INDEX customer_id ON login (customer_id)

2 rows in set (0.00 sec)

Here, you see two active connections to the database. One is running the SHOW PROCESSLIST

command, and the other is building an index. Note the Time row, which indicates that the query

has been running for seven seconds.

Using the SHOW PROCESSLIST command is a helpful tool in identifying what’s currently

running in MySQL. If you have a slow or unresponsive database and you can get on the

machine to run this command, you may be able to find the troublesome query.

If you do find a problematic query in your list of connections, you may want to stop it.

The KILL command can either terminate the connection altogether (KILL <connection_id>)

or terminate the currently running query but leave the connection intact (KILL QUERY ➥

<connection_id>). To stop the CREATE INDEX query in Listing 20-6, where the connection ID

is 6, the command is KILL QUERY 6. You must have the SUPER privilege to stop queries.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Operating System Process List

Most operating systems provide a mechanism to get information about running processes,

CPU usage, memory availability, disk I/O, and so on. While we tend to focus on MySQL, it

doesn’t run in a vacuum. Being able to figure out what is going on at the operating system

and hardware level can often help in resolving an issue.

Whether you use ps, top, or prstat on Unix or the Windows Task Manager, the key is being

able to get a sense of what processes are running on the machine. At a minimum, the process

list will tell you if a MySQL server is running. You may also find the output valuable to identify

issues like an overworked CPU or unavailable memory hindering MySQL’s ability to respond

to queries.

Monitoring Programs

System monitoring and alert tools can be homegrown scripts that regularly parse log files and

alert you when certain events are detected. They also can be full-blown services that receive or

request periodic status indicators from your server, and plot the history of the health of your

database and machine over days, months, and years.2 Whether homegrown or out of the box,

these monitoring tools are designed to make sure you are immediately notified when a prob-

lem arises, give you a view of the load on your database and server over time, and provide

other functions to help you watch your system.

When you are responsible for a production database, you’ll want to know as soon as pos-

sible that a problem occurred, and get as much information as you can from a monitoring

program. This will allow you to more quickly assess the situation and start using the tools

necessary to determine the cause of the problem and move toward resolving it.

Commonly Encountered Issues

Now that we’ve considered the basic troubleshooting tools, we’re going to spend some time

outlining common issues you may encounter in your day-to-day administration of a MySQL

server or server cluster. For each issue, we’ll explain how to diagnose the problem, and then

suggest one or more solutions.

Obviously, we can’t cover every single issue that might occur when you’re using MySQL.

However, reviewing the specific steps to solve some of the problems will help familiarize you

with using the MySQL tools for resolving other issues as well.

■Note Our commonly encountered issues summary isn't far off from a list that MySQL maintains at

http://dev.mysql.com/doc/mysql/en/common-errors.html. You may find it helpful to review sugges-

tions from both this section and the MySQL documentation. You’ll see other pointers to sources for more

information throughout this chapter.

2. A popular open-source monitoring tool is Nagios (http://www.nagios.org/), which includes clients

on each machine and a central server that collects reports on various processes on servers. Also, a

number of web-based monitoring services can do anything from ping your server to test specific

services and functionality on a machine.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

We’ve divided the common scenarios by general category, though to be sure, some sce-

narios cross categorical lines, as you’ll see. We’ll cover the following broad range of possible

trouble areas:

• User, connection, and client issues

• Server installation, restart, and shutdown problems

• Data corruption

Troubleshooting User, Connection, and Client Issues

A fairly common category of troubleshooting is the group of errors and issues associated with

client connections to the server. In this section, we’ll cover how to handle these extremely

pesky occurrences:

• Permissions issues (user denied SELECT, INSERT, UPDATE, or DELETE)

• Can't connect through socket errors

• Can't connect to host errors

• Access denied for user messages

• Too many connections errors

• MySQL server not responding errors

• Packet length too big messages

• MySQL server has gone away messages

Can’t Connect Through Socket Errors

When connecting to a MySQL server on the same machine as the client, MySQL uses the

Unix socket instead of the network.3 If you do not specify a hostname, or use localhost as

the host to connect with, your client will attempt to connect via the Unix socket. If your client

can’t find the socket file, it will fail when attempting to connect to the MySQL server.

The mysql.sock file is created by the MySQL server when it starts up, and it is removed

when the server shuts down. When the client can’t find the socket file, it can’t connect to the

local database server.

Evidence of the Problem

When a client cannot connect to MySQL through the socket file, it returns an error. This mes-

sage might appear on the command line, as a page in your web browser, or in any window that

displays error messages from the MySQL client. The message will look something like this:

ERROR 2002 (HY000): Can't connect to local MySQL server through socket

'/tmp/mysql.sock'

3. A Unix socket file connection is faster than a network connection using TCP/IP, but it is limited to a

connection on the same machine.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

This error is an indication that either the server is not running or the socket file can’t be

found when attempting a connection to the server.

If this error is happening in your production environment, and you have an alert

system in place, that alert system should tell you that MySQL is unavailable. In the case of

the mysql.sock socket file, you might have your alert system monitor for that file as a part of its

checks of the MySQL process. If you are just getting MySQL up and running, and are tweaking

your configuration or needing to periodically restart the database, you (or another user) may

actually see this error message.

■Note Windows servers do not use socket files, so you will not see the Can't connect through socket

error on Windows. The comparable technology on Windows is Named Pipes, which serves a similar purpose,

allowing you to connect to MySQL without using the network.

Solutions

When confronted with a socket error, the following set of suggestions will likely reveal the

source of your problem:

• Using your process monitor, check to be sure your MySQL server is running. Starting

the server is a good start to removing the problem. If the server should have been run-

ning, you may want to spend some time figuring out what happened to make it stop.

• If the server is running, make sure the socket file is where the server and client expect

to find it. By default, the socket is created at /tmp/mysql.sock, but this can be changed

when compiling the database and in the MySQL configuration. The configuration

options that go in your my.cnf file for the server and client files are socket=/path/to/

mysql.sock, in both the [mysqld] and [client] sections. As you can imagine, if the

client and server options don’t match, you won’t be able to connect and will have

trouble getting the client to connect to the server.

• If MySQL is running, and mysql.sock is where it should be, check the permissions on

the socket file. When the server creates it, the ownership is as follows:

srwxrwxrwx  1 mysql    mysql     0 May  2 16:05 mysql.sock

If the ownership or permissions of the socket file have changed, your error may be

caused by inability to access the socket file.

• If your socket file is missing altogether, a restart of the server will re-create it in the

default location (or the location where you’ve configured it to go).

• If circumstances prevent you from having or using a socket file, you can force a TCP/IP

connection to the server by specifying the hostname of your computer or the loopback

address with -h 127.0.0.1.

For more information about server connection failures, see http://dev.mysql.com/

doc/mysql/en/can-not-connect-to-server.html. You can find more details on protecting

mysql.sock at http://dev.mysql.com/doc/mysql/en/problems-with-mysql-sock.html.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Can’t Connect to Host Errors

When you are in an environment where your MySQL connections are network-based, you

may run into a problem connecting to the server. The network may be down, or the server

might not be responding.

Evidence of the Problem

When a client cannot connect to MySQL via the network, it returns an error. As with any MySQL

errors, this message might appear on the command line, as a page in your web browser, or in

any window that displays error messages from the MySQL client. The message will look some-

thing like this:

ERROR 2003 (HY000): Can't connect to MySQL server on '10.0.0.200' (111)

This error is an indication that the server is not running on the given host machine.

If there are network problems, or the network address does not exist, you will either

experience a long wait or see a message indicating that the host is unknown:

ERROR 2005 (HY000): Unknown MySQL server host '10.0.0.300'

If this error is happening in your production environment, and you have an alert system

in place, that system should let you know that MySQL is unavailable. Some alert systems simply

check to see if the MySQL process is running; others actually attempt to make a connection to

the database and run a query. If you are just getting MySQL up and running, and are tweaking

your configuration, you (or another user) may actually see this error.

Solutions

Following are some suggestions for dealing with a host connection problem:

• Check the processes on the host machine where you are attempting to connect. Check

your process list to verify that MySQL is running. If not, starting it should resolve your

problem.

• Verify that the MySQL server is allowing TCP/IP connections. This is set with the

--skip-networking configuration option. If SHOW VARIABLES LIKE 'skip_networking';

indicates that the option is set to ON, your server won’t allow network connections until

you change that value to OFF.

• Verify that the port used by the MySQL server matches the one being used in your

client. By default, MySQL uses port 3306, but this is easily changed with the --port

option in the server or client configuration files, or with the -P option when starting

the MySQL command-line client.

For more information, see http://dev.mysql.com/doc/mysql/en/can-not-connect-to-

server.html.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Access Denied for User Messages

We started the chapter with an example of a user getting a message from a PHP page about

denied access. You may find that as much as you try to keep on top of your privilege assign-

ments, this error gets its fair share of exposure to users.

When a user attempts to connect to MySQL and issue a SQL statement, the database first

checks if the user is allowed to connect, and then checks to see if the user has permission to

execute the submitted statement. In either of these phases of authentication, MySQL may find

that the user is not permitted access, and the client will receive an error. The access denied

message is specifically about not having permission to connect to the database from a host

with the supplied username and password.

Evidence of the Problem

The access denied error occurs when a user’s credentials don’t align correctly with permis-

sions in MySQL. In the instance that you are using a general account for your web site

interactions with the database, but MySQL is not allowing the connection, you or your users

will see a message like this on your site page:

Warning: mysqli_connect(): Access denied for user 'webaccount'@'localhost'

(using password: YES) in /home/promysql/web/customer_basket.php on line 32

Failed to connect: Access denied for user 'webaccount'@'localhost'

(using password: YES)

If you have a system that implements user-level connection rules and permissions, where

users make individual connections, the message will be more specific to the particular user

account. You may also see the same message, but with an indication that no password is

being used, like this:

Warning: mysqli_connect(): Access denied for user 'webaccount'@'localhost'

(using password: NO) in /home/promysql/web/customer_basket.php on line 32

Failed to connect: Access denied for user 'webaccount'@'localhost'

(using password: NO)

Solutions

To resolve an issue where access is denied, use the following suggestions to delve into the

problem:

• Verify that the username is a valid MySQL account.

• Check that you are actually sending a password.

• Determine if the user’s username and password in the connection match those in the

MySQL database.

• Review the connection permissions for the user and verify that the user has the ability

to connect from the given host.

• If permission is lacking, GRANT appropriate connection permission.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

MySQL’s privilege system is fairly complex. To fully understand how a user gains access to

the MySQL server, read Chapter 15, which covers the privilege system in detail. You can also

refer to http://dev.mysql.com/doc/mysql/en/privilege-system.html.

Permission Issues

Beyond the ability to connect to a MySQL server is the permission to execute a particular

statement. As we noted, MySQL has a complex permission structure, which allows for a great

deal of granularity in controlling user access to the server and data.

Evidence of the Problem

User denied errors come up frequently when new users or new functionality that requires

changes in the user permissions are added to your system. Even with the most carefully

planned rollout, as the changes settle, you are likely to see a few users have problems with

queries they attempt to run.

The problem shows up in the form of an error message indicating that the given user is

denied permission to run a given SQL command, as in this example:

mysql> SELECT * FROM customer;

ERROR 1142 (42000): SELECT command denied to user 'mkruck'@'localhost'

for table 'customer'

The user denied messages do not appear in the MySQL log files, so you’ll often learn

about the problem from specific users, in the form of an e-mail message or phone call. If you

are using a client, either desktop or web-based, you may be able to find information about a

user’s problem by reviewing the log files from the web server or from your desktop application

logs.

Solutions

Resolving issues with permissions can be tricky, especially if you haven’t mastered the MySQL

permission scheme. In the instances we’ve seen, these two suggestions have solved most per-

mission problems:

• Use the SHOW GRANTS FOR <username> command and verify that the output shows that

permission has been granted for the appropriate action on that table.

• If the rule seems to be there, check for instances where a more specific rule may be

blocking a more general rule. An UPDATE permission for a specific IP address will block

a SELECT rule for % (any host). If this is the case, you’ll need to GRANT a more specific

SELECT permission for the IP address or revoke the UPDATE.

As we recommended for access denied issues, see Chapter 15 of this book and http://

dev.mysql.com/doc/mysql/en/privilege-system.html for more information about the MySQL

access privilege system.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Too Many Connections Error

Each client that runs a query in MySQL requires a connection to the database. MySQL wisely

allows you to set how many connections are allowed to the database with the --max_connections

configuration option, which defaults to 100.

Evidence of the Problem

The problem arises when a connection is attempted after MySQL has reached the limit allowed

with --max_connections. When this happens, the user will get a Too many connections error, in

the command-line client, web interface, or other location that is displaying the response from a

MySQL connection failure.

Solutions

You can deal with the problem of too many connections in these ways:

• Increase the value of your --max_connections configuration option to be large enough

to handle the number of clients you anticipate at your highest volume. Depending on

your operating system, you can set the value to accommodate anywhere from 400 to

4,000 connections.

• Use persistent database connections or implement a connection pooling mechanism

to lower the number of connections to MySQL. Many languages provide persistent

database connections, where instead of making a new connection for each query,

connections are kept in memory for a period of time and reused. If your language does

not have this capability, it is not difficult to implement your own connection pooling

mechanism.

• Do a code review and look for places where you can consolidate or eliminate connec-

For more information, refer to http://dev.mysql.com/doc/mysql/en/too-many-

tions to the database.

connections.html.

MySQL Server Not Responding

In your experience as an administrator or developer using MySQL, you’ve probably been

in a situation where you can connect to the server, but when you attempt to issue a query,

the server doesn’t seem to respond. Based on our experience, the unresponsive server isn’t

actually the entire database server; instead, one or more tables have been locked and are

preventing another user from querying those tables. This could be caused by another user

running an intensive report, your system taking a point-in-time backup, or an update on a

large table that is central to your system.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Evidence of the Problem

For web-based applications, the first sign of an unresponsive server is a hung web page that

won’t load, waiting for data from the web server. This behavior can also be duplicated in the

command-line client: you type in a query, and you just sit there, waiting for minutes without

anything happening.

Your users will certainly let you know about an unresponsive server, if the problem lasts

for any amount of time. To be more proactive, a homegrown script or a good monitoring sys-

tem can provide alerts based on predefined queries to your database.

Solutions

If you find yourself in the position of having a database-backed page or a client query that is not

responding, here are some immediate steps you can take to get to the bottom of the problem:

• If you can connect to the database, issue SHOW PROCESSLIST and look at the query execu-

tion times to see if you can pinpoint a specific query that might be blocking the other

ones. If you find such a query, the fastest way to get your database moving again is to

kill the query (KILL QUERY <connection_id>). This might not be wise if the query is

important, but, in most cases, we’ve found that the query is a noncritical, poorly writ-

ten SQL statement being run by an unaware user.

• If you have a query that seems to overwhelm the database, rebuild it, making sure your

syntax accounts for references between all tables. Use the EXPLAIN syntax to analyze the

indexes and create or change indexes as appropriate. See Chapter 6 for details on using

EXPLAIN and other profiling techniques.

• If you can’t obtain a connection to the database at all, and your connection attempt

seems to stall and not return, you may have a network-related issue like a firewall

blocking your connection. If your firewall is configured to drop unwanted packets,

you won’t see the Unknown MySQL server host message. Instead, MySQL will just wait

for a response (which isn’t coming).

Packet Length Too Big Messages

If you are sending large queries to your database, or retrieving large BLOB fields of data from

your database, you may experience a Packet too large error. This is caused by having the

--max_allowed_packet configuration option set too small. A packet is considered one incom-

ing SQL statement or an outgoing row of data.

Evidence of the Problem

Having packets that are larger than allowed can be quite a puzzler. When MySQL determines

that the incoming query or outgoing record exceeds the maximum allowed size, it logs a

Packet too large error and closes the connection. In the clients we’ve used, this results

in the client reporting a Lost connection to MySQL server during query error. To determine

what really happened, you need to look in the server’s error log, where you’ll see the

Packet too large error.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

This error occurs in client-to-server communication as well in server-to-server communi-

cation for replication. In either case, it’s only when you look at the error messages in the logs

or the replication status report that you see what the issue is.

Solutions

The following are two ways to deal with the large packet problem:

• Increase your --max_packet_length setting to be large enough to accommodate any

SQL statement being sent to the database and any single row of data that is returned

to the client. There’s no blanket rule of thumb for calculating this value; just make sure

it’s larger than any piece of data you need to store in your database. For a database that

stores large documents or images, you will need to set the --max_packet_length value

much higher than if you’re keeping track of customer addresses.

• If you have huge rows or large BLOB fields that are so big you cannot make the

--max_packet_length setting large enough (either because of memory limitations or

because the maximum limit is 1GB), or you want to break up the data for performance

reasons, you might consider this suggestion: before you insert the large data object,

break it into smaller chunks and insert a row for each piece of data, using a common

identifier to group the pieces of data together. When you need the data, a single SELECT

statement gets all of the records that contain the data, and the application assembles

the data into one large chunk for use.

For more information, see http://dev.mysql.com/doc/mysql/en/packet-too-large.html.

The Server Has Gone Away Messages

On rare occasions, when you are using the MySQL client, you get the pleasure of seeing this

message: MySQL server has gone away. The first time it happens, you panic and frantically get

to the database server and start the process of figuring out why the database has shut down.

After a little looking around, you find that the database is still running. A review of the error

log reveals the database has not stopped, started, or restarted in the past few days or weeks.

You probably spend some time puzzling over what happened, even trying to figure out why

MySQL didn’t log the server crash.

Evidence of the Problem

The MySQL server has gone away message is sent to a client for several reasons, each one

resulting in the client’s connection to MySQL being lost:

• The database administrator has used the KILL command to terminate your connection.

• You attempt to run a query after the connection is closed.

• The client or server has timed out for the connection.

• The size of your SQL statement is too large, or the results have a record that is too large

for the --max_allowed_packet setting.

• You send an incorrect query to the server.

• You have found a MySQL bug and the database died during the query execution.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Solutions

The following are a few ways of discovering the cause of a broken MySQL connection:

• To verify that it was a connection problem, reconnect and issue the statement again.

If the statement runs successfully, you probably encountered a timeout.

• If the connection is broken when you run the query a second time, check the value

of your --max-allowed-packet setting. You can also look in the error log to see if a

Packet too large message is logged. If so, increase the --max-allowed-packet value.

• Check with your database administrator to see if he killed your connection.

■Note The database administrator should immediately contact users with a notification that their connec-

tion was causing a problem and was killed, and help them work through the problem.

• If you don’t have a problem with the packet size, carefully examine the syntax of your

query. MySQL will sometimes close the connection if the query syntax is incorrect.

Make sure all of your join fields are specified. You may want to reduce the complexity

of the query, and gradually build it piece by piece to get back to the original complex

query.

• If, in building a query, you find that some combination of valid SQL syntax generates

this error, you may have stumbled into a MySQL bug (rare, but possible). See the “How

to Report MySQL Bugs” section later in this chapter for information about finding and

reporting bugs to MySQL AB.

For more information, refer to http://dev.mysql.com/doc/mysql/en/gone-away.html and

http://dev.mysql.com/doc/mysql/en/communication-errors.html.

Troubleshooting Start, Restart, and Shutdown Issues

In this section, we’ll discuss common problems related to starting and shutting down the

server properly, including the following:

• Determining whether the server crashed

• Problems starting the MySQL server

• Problems stopping the MySQL server

• Unexpected restarts

■Note While MySQL aims to make every server installation a bump-free and quick process, you may run

into trouble when installing or upgrading your server. See Chapter 14 for information that will help if you

have problems installing or upgrading a MySQL database.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Did the Server Crash?

Depending on the message you get from the client, you may not be sure if the database server

restarted or if you just had an issue with a client or a query. It is sometimes confusing trying

to determine how significant the event was. Although a client connection getting closed is

important to resolve, most administrators would consider a server restart far more serious.

Being aware of where the problem occurred is important.

You have several ways to determine when the server last restarted. One way is to use the

mysqladmin version command and check the uptime to determine if the server has recently

restarted. Output from this command is shown in Listing 20-7. As you can see on the Uptime

line, the server has been up for ten days, meaning that, in this example, the message you just

got from the client was not because the server restarted.

Listing 20-7. Output from mysqladmin version

# mysqladmin version

mysqladmin  Ver 8.41 Distrib 5.0.6-beta, for unknown-linux-gnu on x86_64

Server version          5.0.6-beta-max-log

Protocol version        10

Connection              Localhost via UNIX socket

UNIX socket             /tmp/mysql.sock

Uptime:                 10 days 21 hours 58 min 21 sec

Threads: 1  Questions: 858  Slow queries: 0  Opens: 0  Flush tables: 1

Open tables: 3  Queries per second avg: 0.001

You can also get the uptime in seconds from within the MySQL shell, by using the

SHOW VARIABLES LIKE 'uptime' command. The output of this command is shown in Listing 20-8.

Listing 20-8. Uptime from MySQL Client

mysql> SHOW VARIABLES like 'uptime';

+---------------+-------+

| Variable_name | Value |

+---------------+-------+

| Uptime        | 84472 |

+---------------+-------+

1 row in set (0.00 sec)

Another method for seeing if the database has recently restarted, and to get the history

of activity over time, is to check the error log. Listing 20-9 shows the output of the log with an

egrep for messages that indicate the server has stopped, started, or restarted. If you find unex-

plained entries in this output, you should look more closely at the error log and general query

log to compare database activity with the unexplained server restarts to determine what might

be the cause of the problem.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Listing 20-9. egrep of Error Log

shell> egrep "(ended|started|restarted)" promysql.err

050501 13:16:10  mysqld started

050501 15:51:32  mysqld ended

050501 15:51:33  mysqld started

050502 15:41:29  mysqld ended

050502 15:41:31  mysqld started

050502 15:41:43  mysqld ended

050502 16:02:04  mysqld started

050502 16:04:50  mysqld ended

050502 16:05:03  mysqld started

050505 17:48:40  mysqld ended

050505 17:54:07  mysqld started

For more information about the mysqld_safe startup script, see http://dev.mysql.com/

doc/mysql/en/mysqld-safe.html. For what to do if MySQL keeps crashing, refer to http://

dev.mysql.com/doc/mysql/en/crashing.html.

Problems Starting MySQL Server

Have you ever started the MySQL server only to find that, before you can connect, the MySQL

server daemon ended? In MySQL version 5.0.4, the mysql.server script changed a bit to pre-

vent the server from indicating it started up only to shut right back down. As of MySQL 5.0.4,

when you issue the start command, you wait until the database has started, and then get a

success message:

/etc/init.d/mysql start

Starting MySQL SUCCESS!

Evidence of the Problem

The most common way to find that your server won’t start is to wait in suspense as the server

startup process runs, and then see it finally indicates an error occurred:

/etc/init.d/mysql start

Starting MySQL................................... ERROR!

If you aren’t using the startup script, the common indicator is the mysql ended message

in the logs or on the console where the server was started. Also, starting the server using

the MySQL binary itself will keep the process and messages in the forefront, as shown in

Listing 20-10.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Listing 20-10. Running MySQL Without a Startup Script

./bin/mysqld

050430 14:56:32 [Warning] Can't create test file /data/mysql/promysql.lower-test

./bin/mysqld: Can't change dir to '/data/mysql/' (Errcode: 2)

050430 14:56:32 [ERROR] Aborting

Seeing the error about /data/mysql shown in Listing 20-10, you would check what’s going

on in the /data/mysql directory where your data files are stored. You might learn that the data

directory is not properly mounted.

Solutions

Following are some steps to take when you have problems starting up MySQL:

• Check to see if MySQL is already running, or if the network port you are using for

MySQL is being used by another process.

• Check the error logs to determine if any abnormal event was logged.

• Be sure your directories and data file permissions are set for the MySQL user and group.

• If the startup fails with an unknown option, fix the offending option.

• Check to see if there are missing data or log directories specified in the configuration file.

• If all of your existing options seem correct and your directories are fine, but you still

are not seeing any log information, start MySQL using just the daemon itself with

./bin/mysqld, and see what kind of output is generated.

For more information about the MySQL startup script, see http://dev.mysql.com/doc/

mysql/en/mysql-server.html.

Problems Stopping MySQL Server

In rare cases, you may find that you cannot seem to stop the MySQL server. Most often, this is

related to a thread being busy in the database.

You’ll see this problem when you attempt to stop the MySQL server:

Evidence of the Problem

sudo /etc/init.d/mysql stop

And instead of the typical, few seconds to stop the database, the wait continues until your

database indicates it can’t be stopped:

Killing mysqld with pid 32441

Wait for mysqld to exit................................. gave up waiting!

Or, with the MySQL 5.0.4 and later mysql.server script, you’ll see that the stop process

ends in an error:

/etc/init.d/mysql stop

Shutting down MySQL................................... ERROR!


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Solutions

Here are a few things to check and do if you are having a problem shutting down MySQL:

• You may have a thread that is busy and is preventing the server from stopping. Use the

SHOW PROCESSLIST command to identify queries that are in progress. Killing the connec-

tion may be what’s required to stop MySQL.

• Before stopping the database, stop resources (like Apache) that maintain connections

to MySQL that could prevent the database from stopping.

• Is the MySQL server actually running? Look at processes and verify that MySQL is run-

ning. If the PID file exists, the error will come back even if the process isn’t running. If

your server stopped abnormally and didn’t have a chance to remove the PID file, it will

attempt to shut down as if it were running.

■Caution When you’re having issues with shutting down a server, you may be tempted to use the operat-

ing system to force MySQL to exit. If MySQL won't shut down because it's busy writing data and you force it

to, you may end up with corrupt or missing data. Use the operating system-level process termination com-

mand or tool only as a last resort.

For more information, see http://dev.mysql.com/doc/mysql/en/mysql-server.html.

Problems with Unexpected Restarts

A server unexpectedly restarting can lead to a lot of stress. If you are in an environment where

every second counts, not knowing when the next server restart is going to happen may be unac-

ceptable. For other database uses, unexpected restarts are less damaging, but still unnerving. If

you have experienced unexpected restarts, you’ll want to know what caused them and how to

prevent them in the future.

Evidence of the Problem

Although a restart by mysqld_safe happens quickly, it is easily noticed by an application under

heavy usage when connections can’t be made for the small amount of time the server is down

during the restart. If a restart goes unnoticed, or to figure out the exact timing, you can see the

entry (or entries) by doing a grep "restarted" host.err.

Solutions

If you have problems with unexpected server restarts, the following items may help you resolve

the problem:

• Not having enough memory can cause unexpected restarts. This can happen if MySQL

needs more memory than is physically available on the server or another process is

consuming a lot of memory. If you have a system that monitors your server’s resources,

check to see whether the low amount of memory available correlates to the times when

the MySQL server restarted.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

• Server restarts are a sign of corruption in the database tables. You should go through

the steps to check the status of your tables and repair them if necessary. The next sec-

tion provides more information about data corruption.

• Perform troubleshooting tasks on the operating system and hardware. A defective disk,

damaged RAID controller, or faulty RAM can affect MySQL’s ability to function and may

cause the database to restart during certain failures.

• Check the following MySQL documentation:

• What to do if MySQL keeps crashing: http://dev.mysql.com/doc/mysql/en/

reproduceable-test-case.html

• Table maintenance: http://dev.mysql.com/doc/mysql/en/table-maintenance.html

• Check MyISAM tables: http://dev.mysql.com/doc/mysql/en/myisamchk-syntax.html

• Repair MyISAM tables: http://dev.mysql.com/doc/mysql/en/repair.html

Resolving Data Corruption

As hard as MySQL developers work to perfect the database software, and database administra-

tors work to keep their systems protected, data corruption does occur. The MySQL development

team takes data corruption very seriously and provides a set of instructions to follow to create a

reproducible bug that will allow them to identify where the corruption is happening.

Evidence of the Problem

The corrupted data files often show up in the form of a server crash or unexpected restart.

They cause queries to fail or to return unexpected results (or no results). A more proactive

approach for databases using the MyISAM storage engine is to regularly run the mysqlcheck

script to determine if any tables are corrupted.

The following are some reasons that you might experience data file corruption:

• The server was killed in the middle of an update.

• A bug caused MySQL to stop while writing to disk.

• An external program is manipulating the data files.

• Multiple servers are pointed to the same data files.

• A corrupted data file caused the server to act improperly and corrupt other data.

• A storage engine bug caused bad data to be written.

• The operating system, hardware, or disks may be faulty.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Solutions

If you encounter a corrupt data file, here are some areas to look into:

• Be sure you have backups of your data. Yes, once you’ve discovered there is corruption

it may be too late, but we hope you’ve had enough foresight to create regular backups

(see Chapter 17 for details about backing up MySQL).

• If you are using MyISAM tables, run the mysqlcheck or myisamchk script to repair the table.

• If you can still get your database to run and use the table, do a mysqldump of the table,

DROP the table, and then import the data from the dump. (Chapter 17 describes how to

use mysqldump.)

• Follow MySQL’s steps to create a repeatable situation and contact MySQL with the nec-

essary information. You can find these steps at http://dev.mysql.com/doc/mysql/en/

reproduceable-test-case.html.

You can refer to the MySQL documentation for checking and recovering MyISAM tables,

at http://dev.mysql.com/doc/mysql/en/myisamchk-syntax.html and http://dev.mysql.com/

doc/mysql/en/crash-recovery.html, respectively.

How to Report MySQL Bugs

It is possible that, in your use of MySQL, you encounter a bug. MySQL doesn’t release software

marked as production-ready until all known fatal bugs are resolved. MySQL defines a fatal bug

as one that causes the server to crash under normal use, gives the wrong answer for a normal

query, or contains a security problem. That being said, there is an active bug-tracking system

that allows database users to submit bugs and track their status as they go through the system.

If you think you’ve found a bug, follow the steps outlined in the MySQL documentation

for submitting a bug report (http://dev.mysql.com/doc/mysql/en/bug-reports.html). This

involves the following steps:

• Make sure it’s a repeatable bug (http://dev.mysql.com/doc/mysql/en/reproduceable-

test-case.html).

• Search the existing documentation and mailing lists to see if there is a resolution.

• Search through the bug reports to see if it has been reported

(http://dev.mysql.com/doc/mysql/en/open-bugs.html).

• Finally, submit the bug report with information about your environment and how to

duplicate the bug.

The MySQL team follows the bug-tracking system very closely and usually gets to work on

a bug report within just a few hours.


C H A P T E R   2 0   ■ T R O U B L E S H O OT I N G

Support Options

A chapter on troubleshooting wouldn’t be complete without mentioning support options.

Each organization has different needs, and you have a wide spectrum of options when you’re

looking for support for your MySQL installation. What matches your needs will depend on

what assistance you require and when you require it.

Here are some support options:

Mailing lists: If you have some expertise with MySQL, and your troubleshooting priorities

allow you time to search and post, you can get a lot of information and help from the

MySQL mailing lists. The collective group of people who participate have a great deal of

expertise, and response time is typically pretty good (provided you have good manners).

Even if you have a critical problem that is happening in real time, it’s still worth trying out

a mailing list to get help exploring the issue and formulating a strategy to resolve it. There

are several MySQL mailing lists. Unless you have a specific question about a particular

piece of MySQL that has its own mailing list, the general user mailing list is the place to

go. For a list of all of MySQL mailing lists, along with the list archives and instructions for

subscription, visit http://lists.mysql.com/.

Consultants: If you are running an instance of MySQL, but don’t have the time, interest, or

ability to resolve a problem, a consultant may be the right person to step in. A web search

for “MySQL consultant” brings up hundreds of links leading to people who have experi-

ence with MySQL and are looking for opportunities to apply their knowledge and

experience.

Help from MySQL AB: If you are looking for MySQL expertise, why not turn to the folks

who are building the database? MySQL AB offers several consulting packages, including a

one-day rapid response service for urgent needs (a certified consultant will work with you

on troubleshooting, performance, architecture, or any of your MySQL needs). Another

option from MySQL AB is the MySQL Network (http://www.mysql.com/network/), a serv-

ice that gives you access to production support and MySQL developers to help solve your

unique issues. The MySQL Network also provides certified releases of the MySQL database.

Summary

Troubleshooting a database server can be a stressful experience, especially if the problem is

occurring in your production environment and affecting the availability of your application.

A good database administrator is familiar with the details of MySQL and knows exactly what

to do when a situation arises. This includes having a thorough knowledge of how to use the

troubleshooting tools and where to look for answers.

We spent a significant portion of the chapter discussing the various tools and logs that are

the foundation for dealing with specific problems. We then went through a number of differ-

ent common problems and gave details on possible causes and solutions. Our goal was to

provide some detailed information, as well as to show you examples of the methodology for

working through problems.

As you combine the knowledge of MySQL administration with the honing of your real-

time problem-solving skills, you will become more capable of surviving a problem in your

database without unnecessary stress and wasted time. This, in turn, will please the users of

your database, as well as your manager, customers, and clients.


C H A P T E R   2 1

■ ■ ■

MySQL Data Dictionary

In this chapter, we’ll be taking a closer look at a feature of MySQL 5 that’s receiving consider-

able attention. As of version 5.0.2, the INFORMATION_SCHEMA virtual database is available, which

offers a standardized way of reading meta information about the database server and its

schemas. In this chapter, we’ll examine what exactly the INFORMATION_SCHEMA data store is,

how you can use it, and what information is contained inside it.

Before we go further, we want to discuss a few terms used in this chapter. The discussion

of a database server’s meta information commonly involves the following terms:

• metadata

• data dictionary or system catalog

• INFORMATION_SCHEMA

The definition of metadata is simply data about other data. Metadata describes or sum-

marizes another piece of data. Examples of metadata include the number of rows in a table,

the type of index structure used on a set of columns, or the statement used to create a stored

procedure. Each of these pieces of data describes another piece of data or structure.

All major database vendors have a repository, or container, for metadata, but different

database vendors refer to this repository differently. The two most common terms, however,

are data dictionary and system catalog. We consider them synonymous, but when referring to

the metadata repository, we’ll use the term data dictionary.

The term INFORMATION_SCHEMA describes the ANSI standard interface to the database

server’s metadata. The INFORMATION_SCHEMA is not an actual schema (database), but the data

contained inside this virtual database can be accessed just like any other database on the

server. In this way, the INFORMATION_SCHEMA interface acts as a standardizing component for

accessing information about the database server and its actual schema. The “tables” inside

this virtual database aren’t tables at all, but rather table-like data that is pulled from a variety

of sources, including the underlying mysql system database, and the MySQL server system

variables and counters.

In this way, the INFORMATION_SCHEMA tables are more like views than tables. If you’re coming

from a Microsoft SQL Server background, you’ll recognize this concept, as the INFORMATION_SCHEMA

supported by Microsoft SQL Server are views that pull actual data from the Microsoft SQL Server

system tables, such as sys_objects and sys_indexes. INFORMATION_SCHEMA views are read-only,

partly because the data contained in the INFORMATION_SCHEMA views isn’t contained in a single

location, but instead pulled from the storage areas noted earlier.


In this chapter, we’ll be looking at the following topics related to the new INFORMATION_

C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

SCHEMA feature of MySQL 5:

• Benefits of a standardized interface

• The INFORMATION_SCHEMA views

• Examples of usage

Benefits of a Standardized Interface

Before we get into the specific tables that comprise the MySQL Data Dictionary, we want you

to understand why the data dictionary has been added as a feature to the MySQL 5 source

code. For those of you without much experience with MySQL’s SHOW commands, the transition

to using the INFORMATION_SCHEMA database might take some getting used to, but we highly rec-

ommend taking the time to do so.

There are three main advantages to the INFORMATION_SCHEMA interface versus the SHOW

commands:

• Adherence to standards

• Using SELECT to retrieve metadata

• More information than SHOW commands

Adherence to Standards

MySQL’s SHOW commands are proprietary and not standards-compliant. By contrast, the

INFORMATION_SCHEMA interface is a standard outlined by ANSI/ISO as part of the SQL-99 and

SQL:2003 standards.

One advantage to complying with these standards is that applications that rely on querying

for metadata—for example, a monitoring application—can be written in a portable fashion. The

databases supporting INFORMATION_SCHEMA views are MySQL, Microsoft SQL Server, and, to some

extent, IBM’s DB2 database. Hopefully, in the future, all major database vendors will move to full

compliance, and application code can be truly vendor-agnostic. Having metadata queries written

for the INFORMATION_SCHEMA interface is a proactive stance for future portability needs.

To adhere completely to the SQL standard, MySQL’s implementation of the INFORMATION_

SCHEMA shows columns for which MySQL has no equivalent data. For these columns—for

instance, the INFORMATION_SCHEMA.TABLES.TABLE_CATALOG column—MySQL simply displays

a NULL value, because MySQL has no concept of a database “catalog.” In addition, MySQL

displays certain additional data pieces in the INFORMATION_SCHEMA output where MySQL stores

nonstandard or extension information. This is done to provide complete equivalency to the

MySQL SHOW commands. We’ll detail later where the MySQL implementation diverges from

the ANSI standard.

Using SELECT to Retrieve Metadata

Perhaps the best reason to use the INFORMATION_SCHEMA views is that you can access metadata

through your standard SQL SELECT statements. Instead of various SHOW commands—such as

SHOW TABLES, SHOW FULL COLUMNS, and so on—you access the data through the old familiar

SELECT statement.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

This means you’ll have to learn the INFORMATION_SCHEMA views, to ensure you know where

to look for information. However, the advantage to using SELECT here is that you don’t have

to learn any new syntax to read information from the INFORMATION_SCHEMA. You can use the

various joins you learned in Chapter 7 to present views of related metadata in a way that was

impossible before. Because the INFORMATION_SCHEMA is accessible through standard SQL state-

ments, you can operate on the data sets returned from a query on the INFORMATION_SCHEMA

tables as you would any other SQL statement. This makes it easy to construct complex SELECT

statements that use the information in the INFORMATION_SCHEMA views like any other table in

your other databases.

More Information than SHOW Commands

As you’ll see in the following section, the INFORMATION_SCHEMA offers you more detailed infor-

mation than equivalent SHOW commands. In some cases, a single SELECT statement against the

INFORMATION_SCHEMA views can output more than what multiple SHOW commands could provide.

■Note To use the INFORMATION_SCHEMA views, the user must be granted privileges on the object that

the view represents. Therefore, although no special privilege is needed to issue a SELECT against the

INFORMATION_SCHEMA, the results of certain SELECTs on the metadata repository depend on which

schema, tables, or columns the user has been granted access to.

The INFORMATION_SCHEMA Views

In this section, we cover each of the views available under the INFORMATION_SCHEMA, and out-

line which columns returned from the view equate to the prior SHOW command, if one existed.

We use simple examples in this section to highlight the information available from the follow-

ing INFORMATION_SCHEMA views:

• INFORMATION_SCHEMA.SCHEMATA

• INFORMATION_SCHEMA.TABLES

• INFORMATION_SCHEMA.TABLE_CONSTRAINTS

• INFORMATION_SCHEMA.COLUMNS

• INFORMATION_SCHEMA.KEY_COLUMN_USAGE

• INFORMATION_SCHEMA.STATISTICS

• INFORMATION_SCHEMA.ROUTINES

• INFORMATION_SCHEMA.VIEWS

• INFORMATION_SCHEMA.CHARACTER_SETS

• INFORMATION_SCHEMA.COLLATIONS

• INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• INFORMATION_SCHEMA.SCHEMA_PRIVILEGES

• INFORMATION_SCHEMA.USER_PRIVILEGES

• INFORMATION_SCHEMA.TABLE_PRIVILEGES

• INFORMATION_SCHEMA.COLUMN_PRIVILEGES

■Note Plans are under way to add more views to INFORMATION_SCHEMA. Notably, the following views are

planned for release: TRIGGERS, PARAMETERS, and REFERENTIAL_CONSTRAINTS. As we go to press, details

about these views are still limited. Check the MySQL documentation for the latest INFORMATION_SCHEMA

view lists: http://dev.mysql.com/doc/mysql/en/information-schema-tables.html.

It’s worth noting again here that the results displayed from the INFORMATION_SCHEMA views

are specific to the user logged in. That means that only schemata, tables, or columns to which

the user has been granted access appear in the resultsets.

In the following subsections, for each INFORMATION_SCHEMA view, we show you the DESCRIBE

of the view, a simple SELECT on the view, then in a bulleted list, we define what each of the

output columns contains. For each section, you’ll see a note block detailing which SHOW

commands, if any, correspond to the new INFORMATION_SCHEMA view.

Instead of arranging the views in alphabetical order, we’ve ordered them in groups that

most closely relate to one another. For instance, we’ve grouped the privileges views together

and the character set and collation views together. This order will help give you an idea of the

relationship of the view data.

In the following sections, fields that are not part of the ANSI standard appear in italics to

denote that the column is a MySQL-specific data element. These fields have been left in the

INFORMATION_SCHEMA outputs as an extension to allow equivalent output to some SHOW com-

mands. If you’re attempting to create cross-platform portable SQL code, please be aware of

these extension fields.

■Note Two quick notes before we get into the views. First, some of the following examples were issued

against the test.http_auth table created and used in Chapter 6. If you get an empty resultset for some of

the examples, either follow along in the reading, or refer to Chapter 6 for creation of the http_auth table in

the test database.

Second, depending on your operating system and version of MySQL, you may notice slight differences in some

of the output. Notably, depending on the version of MySQL you use, a VARCHAR(4096) column displayed in

results in this chapter may appear as VARCHAR(4095), or in a Windows environment, VARCHAR(512). These

are minor discrepancies, and as the data dictionary features of MySQL 5 are an evolving work, these data types

may have changed by the time we go to print.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

INFORMATION_SCHEMA.SCHEMATA

The SCHEMATA view shows information about the databases on the server. Listing 21-1 shows

the columns displayed by the view.

Listing 21-1. INFORMATION_SCHEMA.SCHEMATA

mysql> DESCRIBE INFORMATION_SCHEMA.SCHEMATA;

+----------------------------+---------------+------+-----+---------+-------+

| Field                      | Type          | Null | Key | Default | Extra |

+----------------------------+---------------+------+-----+---------+-------+

| CATALOG_NAME               | varchar(4096) | YES  |     | NULL    |       |

| SCHEMA_NAME                | varchar(64)   | NO   |     |         |       |

| DEFAULT_CHARACTER_SET_NAME | varchar(64)   | NO   |     |         |       |

| SQL_PATH                   | varchar(4096) | YES  |     | NULL    |       |

+----------------------------+---------------+------+-----+---------+-------+

4 rows in set (0.04 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;

+--------------+--------------------+----------------------------+----------+

| CATALOG_NAME | SCHEMA_NAME        | DEFAULT_CHARACTER_SET_NAME | SQL_PATH |

+--------------+--------------------+----------------------------+----------+

| NULL         | information_schema | utf8                       | NULL     |

| NULL         | mysql              | latin1                     | NULL     |

| NULL         | test               | latin1                     | NULL     |

+--------------+--------------------+----------------------------+----------+

3 rows in set (0.02 sec)

The fields contained in INFORMATION_SCHEMA.SCHEMATA are as follows:

• CATALOG_NAME: This field will always be NULL, as MySQL doesn’t have any concept of a

catalog. It’s provided to maintain the ANSI standard output.

• SCHEMA_NAME: This is the name of the database.

• DEFAULT_CHARACTER_SET_NAME: This is the name of the default character set for the data-

base. We discuss the INFORMATION_SCHEMA.CHARACTER_SETS view later in the chapter.

• SQL_PATH: This field will always be NULL. MySQL doesn’t use this value to “find” the files

associated with the database. It’s included for compatibility with the ANSI standard.

Although the SCHEMATA view isn’t the most useful of the INFORMATION_SCHEMA views, it does

contain the database’s default character set, while the corresponding SHOW DATABASES command

doesn’t.

■Note The SHOW DATABASES command is the closest command to SELECT * FROM INFORMATION_

SCHEMA.SCHEMATA.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

INFORMATION_SCHEMA.TABLES

The INFORMATION_SCHEMA.TABLES view stores information about the database tables on the

server. Listing 21-2 shows the DESCRIBE and a simple SELECT from the view.

Listing 21-2. INFORMATION_SCHEMA.TABLES

mysql> DESCRIBE INFORMATION_SCHEMA.TABLES;

+-----------------+---------------+------+-----+---------+-------+

| Field           | Type          | Null | Key | Default | Extra |

+-----------------+---------------+------+-----+---------+-------+

| TABLE_CATALOG   | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA    | varchar(64)   | NO   |     |         |       |

| TABLE_NAME      | varchar(64)   | NO   |     |         |       |

| TABLE_TYPE      | varchar(64)   | NO   |     |         |       |

| ENGINE          | varchar(64)   | YES  |     | NULL    |       |

| VERSION         | bigint(21)    | YES  |     | NULL    |       |

| ROW_FORMAT      | varchar(10)   | YES  |     | NULL    |       |

| TABLE_ROWS      | bigint(21)    | YES  |     | NULL    |       |

| AVG_ROW_LENGTH  | bigint(21)    | YES  |     | NULL    |       |

| DATA_LENGTH     | bigint(21)    | YES  |     | NULL    |       |

| MAX_DATA_LENGTH | bigint(21)    | YES  |     | NULL    |       |

| INDEX_LENGTH    | bigint(21)    | YES  |     | NULL    |       |

| DATA_FREE       | bigint(21)    | YES  |     | NULL    |       |

| AUTO_INCREMENT  | bigint(21)    | YES  |     | NULL    |       |

| CREATE_TIME     | datetime      | YES  |     | NULL    |       |

| UPDATE_TIME     | datetime      | YES  |     | NULL    |       |

| CHECK_TIME      | datetime      | YES  |     | NULL    |       |

| TABLE_COLLATION | varchar(64)   | YES  |     | NULL    |       |

| CHECKSUM        | bigint(21)    | YES  |     | NULL    |       |

| CREATE_OPTIONS  | varchar(255)  | YES  |     | NULL    |       |

| TABLE_COMMENT   | varchar(80)   | NO   |     |         |       |

+-----------------+---------------+------+-----+---------+-------+

21 rows in set (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.TABLES

-> WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'http_auth' \G

*************************** 1. row ***************************

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

TABLE_TYPE: BASE TABLE

ENGINE: MyISAM

VERSION: 9

ROW_FORMAT: Fixed

TABLE_ROWS: 90000

AVG_ROW_LENGTH: 59

DATA_LENGTH: 5310000


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

MAX_DATA_LENGTH: 253403070463

INDEX_LENGTH: 3716096

DATA_FREE: 0

AUTO_INCREMENT: NULL

CREATE_TIME: 2005-03-08 23:25:28

UPDATE_TIME: 2005-03-08 23:29:38

CHECK_TIME: NULL

TABLE_COLLATION: latin1_swedish_ci

CHECKSUM: NULL

CREATE_OPTIONS:

TABLE_COMMENT:

1 row in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.TABLES are as follows:

• TABLE_CATALOG: Again, will always be NULL. Shown for compatibility purposes.

• TABLE_SCHEMA: The name of the database to which this table belongs.

• TABLE_NAME: The name of the table.

• TABLE_TYPE: Either BASE TABLE, TEMPORARY, or VIEW. Those entries having a VIEW value

also appear in INFORMATION_SCHEMA.VIEWS. More details about this view come later in

the chapter.

• ENGINE: The storage engine handling this table’s data.

• VERSION: The internal versioning of the table’s .frm file. Indicates how many times the

table’s definition has changed.

• ROW_FORMAT: Either FIXED, COMPRESSED, or DYNAMIC. Indicates the format of table rows.

See Chapter 5 for more details on the difference between the row formats.

• TABLE_ROWS: Shows the number of rows in a table.

• AVG_ROW_LENGTH: Shows the average length, in bytes, of the table’s rows.

• DATA_LENGTH: Shows the total length, in bytes, of the table’s data.

• MAX_DATA_LENGTH: Shows the maximum storage length, in bytes, that the table’s data can

consume.

• INDEX_LENGTH: Shows the total length, in bytes, of the table’s indexes.

• DATA_FREE: Shows the number of bytes that have been allocated to the table’s data, but

that haven’t yet been filled with table data.

• AUTO_INCREMENT: Shows the next integer number to be used on the table’s AUTO_INCREMENT

column, or NULL if no such sequence is used on the table.

• CREATE_TIME: Timestamp of the table’s initial creation.

• UPDATE_TIME: Timestamp of the last ALTER TABLE command on this table. If there have

been no ALTER TABLE commands, then shows the same timestamp as CREATE_TIME.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• CHECK_TIME: Timestamp of the last time a table check was performed on the table, or

NULL if the table has never been checked for consistency.

• TABLE_COLLATION: Shows the table’s default character set and collation combination.

See INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY for more details.

• CHECKSUM: Internal live checksum for the table, or NULL if none is available.

• CREATE_OPTIONS: Shows any options used at table creation, or nothing if none has

been used.

• TABLE_COMMENT: Shows any comment used during table creation.

Clearly, the INFORMATION_SCHEMA.TABLES view has a wealth of useful information about

the database tables on your MySQL server. The vast majority of the columns, as you may well

have noticed, are extension fields that MySQL has included to provide compatibility with the

SHOW TABLE STATUS command.

■Note The SHOW TABLE STATUS command displays most of the information that a SELECT * FROM ➥

INFORMATION_SCHEMA.TABLES would output.

INFORMATION_SCHEMA.TABLE_CONSTRAINTS

The INFORMATION_SCHEMA.TABLE_CONSTRAINTS view shows columns related to all tables for

which a constraining index exists. Listing 21-3 shows a DESCRIBE and a simple SELECT from

this view.

Listing 21-3. INFORMATION_SCHEMA.TABLE_CONSTRAINTS

mysql> DESCRIBE INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

+--------------------+---------------+------+-----+---------+-------+

| Field              | Type          | Null | Key | Default | Extra |

+--------------------+---------------+------+-----+---------+-------+

| CONSTRAINT_CATALOG | varchar(4096) | YES  |     | NULL    |       |

| CONSTRAINT_SCHEMA  | varchar(64)   | NO   |     |         |       |

| CONSTRAINT_NAME    | varchar(64)   | NO   |     |         |       |

| TABLE_SCHEMA       | varchar(64)   | NO   |     |         |       |

| TABLE_NAME         | varchar(64)   | NO   |     |         |       |

| CONSTRAINT_TYPE    | varchar(64)   | NO   |     |         |       |

+--------------------+---------------+------+-----+---------+-------+

6 rows in set (0.01 sec)


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

mysql> SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS

-> WHERE CONSTRAINT_SCHEMA = 'test' \G

*************************** 1. row ***************************

CONSTRAINT_CATALOG: NULL

CONSTRAINT_SCHEMA: test

*************************** 2. row ***************************

CONSTRAINT_CATALOG: NULL

CONSTRAINT_SCHEMA: test

CONSTRAINT_NAME: PRIMARY

TABLE_SCHEMA: test

TABLE_NAME: http_auth

CONSTRAINT_TYPE: PRIMARY KEY

CONSTRAINT_NAME: PRIMARY

TABLE_SCHEMA: test

TABLE_NAME: http_auth_idb

CONSTRAINT_TYPE: PRIMARY KEY

2 rows in set (0.31 sec)

The fields contained in INFORMATION_SCHEMA.TABLE_CONSTRAINTS are as follows:

• CONSTRAINT_CATALOG: Again, always NULL.

• CONSTRAINT_SCHEMA: Name of the database in which the table constraint (index) resides.

This is always the same as the value of TABLE_SCHEMA.

• CONSTRAINT_NAME: Name of the constraint.

• TABLE_SCHEMA: Name of the database for the table on which the index is built.

• TABLE_NAME: Name of the table on which the index is built.

• CONSTRAINT_TYPE: Either PRIMARY KEY, FOREIGN KEY, or UNIQUE, depending on what engine

is handling the table, and how the key was referenced in a CREATE TABLE statement. In the

future, MyISAM tables will fully support FOREIGN KEY constraints. Currently, you only see

FOREIGN KEY pop up when an InnoDB table is referenced during create time.

■Tip The SHOW INDEX command most closely resembles the output from INFORMATION_SCHEMA.

TABLE_CONSTRAINTS. The CONSTRAINT_TYPE column contains similar information to the KEY_NAME

column returned by SHOW INDEX for entries with a NON_UNIQUE value of 0.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

INFORMATION_SCHEMA.COLUMNS

The INFORMATION_SCHEMA.COLUMNS view shows detailed information about the columns con-

tained in the server’s database tables. Listing 21-4 shows a DESCRIBE and a simple SELECT

from the view.

Listing 21-4. INFORMATION_SCHEMA.COLUMNS

mysql> DESCRIBE INFORMATION_SCHEMA.COLUMNS;

+--------------------------+---------------+------+-----+---------+-------+

| Field                    | Type          | Null | Key | Default | Extra |

+--------------------------+---------------+------+-----+---------+-------+

| TABLE_CATALOG            | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA             | varchar(64)   | NO   |     |         |       |

| TABLE_NAME               | varchar(64)   | NO   |     |         |       |

| COLUMN_NAME              | varchar(64)   | NO   |     |         |       |

| ORDINAL_POSITION         | bigint(21)    | NO   |     | 0       |       |

| COLUMN_DEFAULT           | varchar(64)   | YES  |     | NULL    |       |

| IS_NULLABLE              | varchar(3)    | NO   |     |         |       |

| DATA_TYPE                | varchar(64)   | NO   |     |         |       |

| CHARACTER_MAXIMUM_LENGTH | bigint(21)    | NO   |     | 0       |       |

| CHARACTER_OCTET_LENGTH   | bigint(21)    | NO   |     | 0       |       |

| NUMERIC_PRECISION        | bigint(21)    | YES  |     | NULL    |       |

| NUMERIC_SCALE            | bigint(21)    | YES  |     | NULL    |       |

| CHARACTER_SET_NAME       | varchar(64)   | YES  |     | NULL    |       |

| COLLATION_NAME           | varchar(64)   | YES  |     | NULL    |       |

| COLUMN_TYPE              | longtext      | NO   |     |         |       |

| COLUMN_KEY               | varchar(3)    | NO   |     |         |       |

| EXTRA                    | varchar(20)   | NO   |     |         |       |

| PRIVILEGES               | varchar(80)   | NO   |     |         |       |

| COLUMN_COMMENT           | varchar(255)  | NO   |     |         |       |

+--------------------------+---------------+------+-----+---------+-------+

19 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-> WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'http_auth' \G

*************************** 1. row ***************************

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

COLUMN_NAME: username

ORDINAL_POSITION: 1

COLUMN_DEFAULT:

IS_NULLABLE: NO

DATA_TYPE: char

CHARACTER_MAXIMUM_LENGTH: 25

CHARACTER_OCTET_LENGTH: 25


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

NUMERIC_PRECISION: NULL

NUMERIC_SCALE: NULL

CHARACTER_SET_NAME: latin1

COLLATION_NAME: latin1_swedish_ci

COLUMN_TYPE: char(25)

COLUMN_KEY: PRI

EXTRA:

PRIVILEGES: select,insert,update,references

COLUMN_COMMENT:

… omitted

*************************** 4. row ***************************

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

COLUMN_NAME: gid

ORDINAL_POSITION: 4

COLUMN_DEFAULT: 0

IS_NULLABLE: NO

DATA_TYPE: int

CHARACTER_MAXIMUM_LENGTH: 11

CHARACTER_OCTET_LENGTH: 11

NUMERIC_PRECISION: 11

NUMERIC_SCALE: 0

CHARACTER_SET_NAME: NULL

COLLATION_NAME: NULL

COLUMN_TYPE: int(11)

COLUMN_KEY:

EXTRA:

COLUMN_COMMENT:

4 rows in set (0.01 sec)

PRIVILEGES: select,insert,update,references

The fields contained in INFORMATION_SCHEMA.COLUMNS are as follows:

• TABLE_CATALOG: Again, always NULL.

• TABLE_SCHEMA: Name of the database.

• TABLE_NAME: Name of the database table or view.

• COLUMN_NAME: Name of the column.

• ORDINAL_POSITION: Starting with 1, position of a column in the table.

• COLUMN_DEFAULT: Default value for a column in the table.

• IS_NULLABLE: Either YES or NO, describing whether the column allows for NULL values.

• DATA_TYPE: Shows only the data type keyword, not the entire field definition, for the

column.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• CHARACTER_MAXIMUM_LENGTH: Shows the maximum number of characters that the field

may contain.

field type.

• CHARACTER_OCTET_LENGTH: Shows the maximum length of the field in octets.

• NUMERIC_PRECISION: Shows the precision of numeric fields, or NULL if a non-numeric

• NUMERIC_SCALE: Shows the scale of numeric fields, or NULL if a non-numeric field type.

• CHARACTER_SET_NAME: Shows the character field character set, or NULL if a noncharacter

field type. See the section “INFORMATION_SCHEMA.CHARACTER_SETS.”

• COLLATION_NAME: Shows the character field collation set, or NULL if a noncharacter field

type. See the section “INFORMATION_SCHEMA.COLLATIONS.”

• COLUMN_TYPE: Shows the full field definition for the column.

• COLUMN_KEY: Shows any of PRI, UNI, MUL, or blank. PRI appears when the column is part

of a PRIMARY KEY. UNI appears when the column is part of a UNIQUE INDEX. MUL appears

when the column is part of an index that allows for duplicates. Blank appears for all

other columns.

• EXTRA: Shows any extra information about the column that MySQL stores; for instance,

the AUTO_INCREMENT keyword.

• PRIVILEGES: Shows a list of privileges available to the current user for this column.

• COLUMN_COMMENT: Shows the comment used during table creation.

■Note The SHOW FULL COLUMNS command is the closest equivalent to a SELECT * FROM INFORMATION_

SCHEMA.COLUMNS WHERE TABLE_NAME = 'table_name'.

The COLUMNS view has a wealth of information that doesn’t appear in the SHOW FULL ➥

COLUMNS output. The most useful part of the view output is that you get a normalized output for

numeric precision and scale, the data type, and the ordinal position of the column within the

table. This means you can avoid scripts that must parse out the non-normalized SHOW COLUMNS

output. You’ll see an example of this usage later in the chapter.

INFORMATION_SCHEMA.KEY_COLUMN_USAGE

The INFORMATION_SCHEMA.KEY_COLUMN_USAGE view details information about the columns used

in a table’s indexes or constraints. Listing 21-5 shows an output from DESCRIBE and a simple

SELECT from the view.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

Listing 21-5. INFORMATION_SCHEMA.KEY_COLUMN_USAGE

mysql> DESCRIBE INFORMATION_SCHEMA.KEY_COLUMN_USAGE;

+-------------------------------+---------------+------+-----+---------+-------+

| Field                         | Type          | Null | Key | Default | Extra |

+-------------------------------+---------------+------+-----+---------+-------+

| CONSTRAINT_CATALOG            | varchar(4096) | YES  |     | NULL    |       |

| CONSTRAINT_SCHEMA             | varchar(64)   | NO   |     |         |       |

| CONSTRAINT_NAME               | varchar(64)   | NO   |     |         |       |

| TABLE_CATALOG                 | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA                  | varchar(64)   | NO   |     |         |       |

| TABLE_NAME                    | varchar(64)   | NO   |     |         |       |

| COLUMN_NAME                   | varchar(64)   | NO   |     |         |       |

| ORDINAL_POSITION              | bigint(10)    | NO   |     | 0       |       |

| POSITION_IN_UNIQUE_CONSTRAINT | bigint(10)    | YES  |     | NULL    |       |

+-------------------------------+---------------+------+-----+---------+-------+

9 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE

-> WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'http_auth' \G

*************************** 1. row ***************************

CONSTRAINT_CATALOG: NULL

CONSTRAINT_SCHEMA: test

CONSTRAINT_NAME: PRIMARY

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

COLUMN_NAME: username

ORDINAL_POSITION: 1

POSITION_IN_UNIQUE_CONSTRAINT: NULL

1 row in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.KEY_COLUMN_USAGE are as follows:

• CONSTRAINT_CATALOG: Always NULL.

• CONSTRAINT_SCHEMA: Name of the database containing the constraint.

• CONSTRAINT_NAME: Name of the constraint.

• TABLE_CATALOG: Always NULL.

• TABLE_SCHEMA: Name of the database containing the table in which the constraint can

be found. Is always the same value as CONSTRAINT_SCHEMA.

• TABLE_NAME: Name of the table on which the constraint or index operates.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• COLUMN_NAME: Name of the column in the constraint.

• ORDINAL_POSITION: Position of the column within the index or constraint, starting at the

number 1.

• POSITION_IN_UNIQUE_CONSTRAINT: Either NULL, or the position of the column in a refer-

enced FOREIGN KEY constraint that happens to be a UNIQUE INDEX.

The KEY_COLUMN_USAGE data is useful for identifying column positioning in constraints on

tables. There’s no equivalent SHOW command that returns the same information.

INFORMATION_SCHEMA.STATISTICS

The INFORMATION_SCHEMA.STATISTICS view displays information regarding the indexes operat-

ing on the server’s tables or views. Listing 21-6 shows a DESCRIBE and a simple SELECT from

the view.

Listing 21-6. INFORMATION_SCHEMA.STATISTICS

mysql> DESCRIBE INFORMATION_SCHEMA.STATISTICS;

+---------------+---------------+------+-----+---------+-------+

| Field         | Type          | Null | Key | Default | Extra |

+---------------+---------------+------+-----+---------+-------+

| TABLE_CATALOG | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA  | varchar(64)   | NO   |     |         |       |

| TABLE_NAME    | varchar(64)   | NO   |     |         |       |

| NON_UNIQUE    | bigint(1)     | NO   |     | 0       |       |

| INDEX_SCHEMA  | varchar(64)   | NO   |     |         |       |

| INDEX_NAME    | varchar(64)   | NO   |     |         |       |

| SEQ_IN_INDEX  | bigint(2)     | NO   |     | 0       |       |

| COLUMN_NAME   | varchar(64)   | NO   |     |         |       |

| COLLATION     | varchar(1)    | YES  |     | NULL    |       |

| CARDINALITY   | bigint(21)    | YES  |     | NULL    |       |

| SUB_PART      | bigint(3)     | YES  |     | NULL    |       |

| PACKED        | varchar(10)   | YES  |     | NULL    |       |

| NULLABLE      | varchar(3)    | NO   |     |         |       |

| INDEX_TYPE    | varchar(16)   | NO   |     |         |       |

| COMMENT       | varchar(16)   | YES  |     | NULL    |       |

+---------------+---------------+------+-----+---------+-------+

15 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.STATISTICS

-> WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'http_auth' \G

*************************** 1. row ***************************

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

NON_UNIQUE: 0

INDEX_SCHEMA: test


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

INDEX_NAME: PRIMARY

SEQ_IN_INDEX: 1

COLUMN_NAME: username

COLLATION: A

CARDINALITY: 90000

SUB_PART: NULL

PACKED: NULL

NULLABLE:

INDEX_TYPE: BTREE

COMMENT:

1 row in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.STATISTICS are as follows:

• TABLE_CATALOG: Always NULL.

• TABLE_SCHEMA: Name of the database in which the table resides.

• TABLE_NAME: Name of the table on which the index operates.

• NON_UNIQUE: Either 0 or 1. Indicates whether the index can contain duplicate values.

Note that NON_UNIQUE returns a numeric Boolean representation, as opposed to YES

or NO.

• INDEX_SCHEMA: Name of the database in which the index is housed. It’s always the same

• INDEX_NAME: Name of the index within the schema.

• SEQ_IN_INDEX: Shows the position of this column within the index key, starting at

• COLUMN_NAME: Name of the column in the index key.

• COLLATION: The column’s collation. Will either be A for an ascending index order, or NULL

as TABLE_SCHEMA.

position 1.

for descending.

• CARDINALITY: The number of unique values contained in this column for this index key.

• SUB_PART: If a prefix on a character field was used in the creation of the index, SUB_PART

will show the number of characters that the index column uses; otherwise NULL.

• PACKED: Either 0, 1, or DEFAULT depending on whether the index is packed. See Chapter 5

for more information about MyISAM key packing.

• NULLABLE: Either YES or NO, indicating whether the column can contain NULL values.

• INDEX_TYPE: Any of BTREE, RTREE, HASH, or FULLTEXT.

• COMMENT: Any comment used during creation of the index; otherwise blank.

The STATISTICS view has a wealth of information about the columns used in your indexes.

We’ll be using this table in the following examples to get a feel for the selectivity of your

indexes, so stay tuned.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

■Note The SHOW INDEX command most closely resembles the output from a SELECT * FROM ➥

INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = 'table_name';.

INFORMATION_SCHEMA.ROUTINES

The INFORMATION_SCHEMA.ROUTINES view details information about the stored procedures and

user-defined functions created on your system. Listing 21-7 shows the output of DESCRIBE

and a simple SELECT on the view.

Listing 21-7. INFORMATION_SCHEMA.ROUTINES

mysql> DESCRIBE INFORMATION_SCHEMA.ROUTINES;

+--------------------+---------------+------+-----+---------------------+-------+

| Field              | Type          | Null | Key | Default             | Extra |

+--------------------+---------------+------+-----+---------------------+-------+

| SPECIFIC_NAME      | varchar(64)   | NO   |     |                     |       |

| ROUTINE_CATALOG    | varchar(4096) | YES  |     | NULL                |       |

| ROUTINE_SCHEMA     | varchar(64)   | NO   |     |                     |       |

| ROUTINE_NAME       | varchar(64)   | NO   |     |                     |       |

| ROUTINE_TYPE       | varchar(9)    | NO   |     |                     |       |

| DTD_IDENTIFIER     | varchar(64)   | YES  |     | NULL                |       |

| ROUTINE_BODY       | varchar(8)    | NO   |     |                     |       |

| ROUTINE_DEFINITION | longtext      | NO   |     |                     |       |

| EXTERNAL_NAME      | varchar(64)   | YES  |     | NULL                |       |

| EXTERNAL_LANGUAGE  | varchar(64)   | YES  |     | NULL                |       |

| PARAMETER_STYLE    | varchar(8)    | NO   |     |                     |       |

| IS_DETERMINISTIC   | varchar(3)    | NO   |     |                     |       |

| SQL_DATA_ACCESS    | varchar(64)   | NO   |     |                     |       |

| SQL_PATH           | varchar(64)   | YES  |     | NULL                |       |

| SECURITY_TYPE      | varchar(7)    | NO   |     |                     |       |

| CREATED            | datetime      | NO   |     | 0000-00-00 00:00:00 |       |

| LAST_ALTERED       | datetime      | NO   |     | 0000-00-00 00:00:00 |       |

| SQL_MODE           | longtext      | NO   |     |                     |       |

| ROUTINE_COMMENT    | varchar(64)   | NO   |     |                     |       |

| DEFINER            | varchar(77)   | NO   |     |                     |       |

+--------------------+---------------+------+-----+---------------------+-------+

20 rows in set (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.ROUTINES \G

*************************** 1. row ***************************

SPECIFIC_NAME: test_proc1

ROUTINE_CATALOG: NULL

ROUTINE_SCHEMA: test

ROUTINE_NAME: test_proc1

ROUTINE_TYPE: PROCEDURE


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

DTD_IDENTIFIER: NULL

ROUTINE_BODY: SQL

ROUTINE_DEFINITION: BEGIN

SELECT COUNT(*) INTO param1 FROM http_auth;

END

EXTERNAL_NAME: NULL

EXTERNAL_LANGUAGE: NULL

PARAMETER_STYLE: SQL

IS_DETERMINISTIC: NO

SQL_DATA_ACCESS: CONTAINS SQL

SQL_PATH: NULL

SECURITY_TYPE: DEFINER

CREATED: 2005-04-10 13:21:58

LAST_ALTERED: 2005-04-10 13:21:58

SQL_MODE:

ROUTINE_COMMENT:

DEFINER: root@localhost

1 row in set (0.00 sec)

The listing shows a simple test procedure we’ve created in the test schema for illustration

purposes. If you’re unfamiliar with stored procedures, please refer to Chapter 9.

The fields contained in INFORMATION_SCHEMA.ROUTINES are as follows:

• SPECIFIC_NAME: The name of the stored procedure or function.

• ROUTINE_CATALOG: Always NULL.

• ROUTINE_SCHEMA: The name of the database to which the procedure is tied.

• ROUTINE_NAME: Same as SPECIFIC_NAME.

• ROUTINE_TYPE: Either PROCEDURE or FUNCTION.

• DTD_IDENTIFIER: For functions, returns the complete data type definition of the func-

tion, otherwise NULL for procedures.

• ROUTINE_BODY: Shows the language in which the procedure is written. Currently, only the

value SQL appears, but in future versions of MySQL, other extension languages may be

used to write procedures.

• ROUTINE_DEFINITION: For procedures, shows either the whole procedure definition, or

for long procedures, a truncated part of the definition.

• EXTERNAL_NAME: Always NULL, because all stored procedures in MySQL are kept internal

to the database.

• EXTERNAL_LANGUAGE: Again, always NULL.

• PARAMETER_STYLE: Currently, only the value SQL appears for this column.

• IS_DETERMINISTIC: Either YES or NO. Shows whether the stored procedure or function

will return the same value for the same passed input parameters.

• SQL_DATA_ACCESS: Any of NO SQL, CONTAINS SQL, READS SQL DATA, or MODIFIES SQL DATA.

See Chapter 9 for an explanation of these various values.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• SQL_PATH: Always NULL.

• SECURITY_TYPE: Either DEFINER or INVOKER, depending on what type of security model

was used during creation. Again, for more information check out Chapter 9.

• CREATED: Timestamp of when the procedure or function was created.

• LAST_ALTERED: Timestamp of the last alteration to the procedure or function.

• SQL_MODE: Shows the sql_mode server variable setting that was in effect at the time the

procedure was created. This is done to ensure that the procedure is always run under

the same mode as when it was created.

• ROUTINE_COMMENT: Any comment issued at procedure creation time.

• DEFINER: User who created the procedure in user@host format.

There’s no SHOW command equivalent for the data contained in INFORMATION_SCHEMA.

ROUTINES. However, the mysql.proc system table contains all the information available in

the view.

INFORMATION_SCHEMA.VIEWS

The INFORMATION_SCHEMA.VIEWS view details information about the views created on the server.

Listing 21-8 shows a DESCRIBE and a simple SELECT displaying a test view created for illustra-

tion purposes. For more information on views, check out Chapter 10.

Listing 21-8. INFORMATION_SCHEMA.VIEWS

mysql> DESCRIBE INFORMATION_SCHEMA.VIEWS;

+-----------------+---------------+------+-----+---------+-------+

| Field           | Type          | Null | Key | Default | Extra |

+-----------------+---------------+------+-----+---------+-------+

| TABLE_CATALOG   | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA    | varchar(64)   | NO   |     |         |       |

| TABLE_NAME      | varchar(64)   | NO   |     |         |       |

| VIEW_DEFINITION | longtext      | NO   |     |         |       |

| CHECK_OPTION    | varchar(8)    | NO   |     |         |       |

| IS_UPDATABLE    | varchar(3)    | NO   |     |         |       |

+-----------------+---------------+------+-----+---------+-------+

6 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.VIEWS \G;

*************************** 1. row ***************************

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: UserPass

CHECK_OPTION: NONE

IS_UPDATABLE: YES

1 row in set (0.04 sec)

VIEW_DEFINITION: select `test`.`http_auth`.`username` AS `username`, \

`test`.`http_auth`.`pass` AS `pass` from `test`.`http_auth`


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

The fields contained in INFORMATION_SCHEMA.VIEWS are as follows:

• TABLE_CATALOG: Always NULL.

• TABLE_SCHEMA: Database on which the view operates.

• TABLE_NAME: Name of the view.

• VIEW_DEFINITION: Complete definition of the view.

• CHECK_OPTION: Either NONE, LOCAL, or CASCADE, depending on the value of the WITH CHECK ➥

OPTION done during view creation. See Chapter 10 for details.

• IS_UPDATABLE: Either YES or NO, depending on whether the view supports updating.

As you can see, Listing 21-8 shows a simple view, called UserPass, in the test schema,

which simply outputs the username and password columns from the http_auth table. The

INFORMATION_SCHEMA.VIEWS view provides useful information about whether the view is updat-

able and its checking options. There is no equivalent SHOW command, though the mysql.views

system table stores all the basic information displayed here.

INFORMATION_SCHEMA.CHARACTER_SETS

The INFORMATION_SCHEMA.CHARACTER_SETS view shows the available character sets on the data-

base server. Listing 21-9 shows a DESCRIBE and limited SELECT on the view.

Listing 21-9. INFORMATION_SCHEMA.CHARACTER_SETS

mysql> DESCRIBE INFORMATION_SCHEMA.CHARACTER_SETS;

+----------------------+-------------+------+-----+---------+-------+

| Field                | Type        | Null | Key | Default | Extra |

+----------------------+-------------+------+-----+---------+-------+

| CHARACTER_SET_NAME   | varchar(64) | NO   |     |         |       |

| DEFAULT_COLLATE_NAME | varchar(64) | NO   |     |         |       |

| DESCRIPTION          | varchar(60) | NO   |     |         |       |

| MAXLEN               | bigint(3)   | NO   |     | 0       |       |

+----------------------+-------------+------+-----+---------+-------+

4 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.CHARACTER_SETS LIMIT 5;

+--------------------+----------------------+--------------------------+--------+

| CHARACTER_SET_NAME | DEFAULT_COLLATE_NAME | DESCRIPTION              | MAXLEN |

+--------------------+----------------------+--------------------------+--------+

| dec8               | dec8_swedish_ci      | DEC West European        |      1 |

| cp850              | cp850_general_ci     | DOS West European        |      1 |

| hp8                | hp8_english_ci       | HP West European         |      1 |

| koi8r              | koi8r_general_ci     | KOI8-R Relcom Russian    |      1 |

| latin1             | latin1_swedish_ci    | ISO 8859-1 West European |      1 |

+--------------------+----------------------+--------------------------+--------+

5 rows in set (0.00 sec)


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

The fields contained in INFORMATION_SCHEMA.CHARACTER_SETS are as follows:

• CHARACTER_SET_NAME: Name of the character set.

• DEFAULT_COLLATION_NAME: Name of the default collation for this character set. See the

following section, “INFORMATION_SCHEMA.COLLATIONS.”

• DESCRIPTION: Description of the character set.

• MAXLEN: Shows the number of bytes used to store a single character in the set.

This view isn’t the most useful in the world, but the extension field MAXLEN can come in

handy when you want to get a list of character sets needing more than 1 byte to store characters.

■Note The SHOW CHARACTER SET command contains equivalent information to the INFORMATION_

SCHEMA.CHARACTER_SETS view.

INFORMATION_SCHEMA.COLLATIONS

The INFORMATION_SCHEMA.COLLATIONS view lists the collations available to the current user.

Listing 21-10 shows a DESCRIBE and a simple SELECT from the view.

Listing 21-10. INFORMATION_SCHEMA.COLLATIONS

mysql> DESCRIBE INFORMATION_SCHEMA.COLLATIONS;

+--------------------+-------------+------+-----+---------+-------+

| Field              | Type        | Null | Key | Default | Extra |

+--------------------+-------------+------+-----+---------+-------+

| COLLATION_NAME     | varchar(64) | NO   |     |         |       |

| CHARACTER_SET_NAME | varchar(64) | NO   |     |         |       |

| ID                 | bigint(11)  | NO   |     | 0       |       |

| IS_DEFAULT         | varchar(3)  | NO   |     |         |       |

| IS_COMPILED        | varchar(3)  | NO   |     |         |       |

| SORTLEN            | bigint(3)   | NO   |     | 0       |       |

+--------------------+-------------+------+-----+---------+-------+

6 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.COLLATIONS LIMIT 5;

+------------------+--------------------+----+------------+-------------+---------+

| COLLATION_NAME   | CHARACTER_SET_NAME | ID | IS_DEFAULT | IS_COMPILED | SORTLEN |

+------------------+--------------------+----+------------+-------------+---------+

| dec8_swedish_ci  | dec8               |  3 | Yes        |             |       0 |

| dec8_bin         | dec8               | 69 |            |             |       0 |

| cp850_general_ci | cp850              |  4 | Yes        |             |       0 |

| cp850_bin        | cp850              | 80 |            |             |       0 |

| hp8_english_ci   | hp8                |  6 | Yes        |             |       0 |

+------------------+--------------------+----+------------+-------------+---------+

5 rows in set (0.00 sec)


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

The fields contained in INFORMATION_SCHEMA.COLLATIONS are as follows:

• COLLATION_NAME: Name of the collation.

• CHARACTER_SET_NAME: Name of the character set to which the collation applies.

• ID: A numeric identifier for the collation.

• IS_DEFAULT: Either YES or NO, indicating whether this collation is the server default for

this character set.

this collation.

collation.

• IS_COMPILED: Either YES or blank. Indicates whether the server has been compiled with

• SORTLEN: Shows the number of bytes needed in memory to perform sorting on the

■Note The SHOW COLLATIONS command is most equivalent to a SELECT * FROM INFORMATION_

SCHEMA.COLLATIONS.

INFORMATION_SCHEMA.COLLATION_CHARACTER_

SET_APPLICABILITY

The INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY view shows the relation

between character sets and collations. Listing 21-11 shows a DESCRIBE and a simple SELECT

from the view.

Listing 21-11. INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY

mysql> DESCRIBE INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY;

+--------------------+-------------+------+-----+---------+-------+

| Field              | Type        | Null | Key | Default | Extra |

+--------------------+-------------+------+-----+---------+-------+

| COLLATION_NAME     | varchar(64) | NO   |     |         |       |

| CHARACTER_SET_NAME | varchar(64) | NO   |     |         |       |

+--------------------+-------------+------+-----+---------+-------+

2 rows in set (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.COLLATION_CHARACTER_SET_APPLICABILITY

-> LIMIT 5;

+------------------+--------------------+

| COLLATION_NAME   | CHARACTER_SET_NAME |

+------------------+--------------------+

| dec8_swedish_ci  | dec8               |

| dec8_bin         | dec8               |

| cp850_general_ci | cp850              |

| cp850_bin        | cp850              |

| hp8_english_ci   | hp8                |

+------------------+--------------------+

5 rows in set (0.00 sec)


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

This view isn’t terribly useful, and merely represents the first two columns of the

INFORMATION_SCHEMA.COLLATIONS view.

INFORMATION_SCHEMA.SCHEMA_PRIVILEGES

The INFORMATION_SCHEMA.SCHEMA_PRIVILEGES table houses the database privileges on the

server. This view is not part of the ANSI standard, and is provided so that a common interface

can be used to gather information from the mysql.db system table for privileges associated

with the database. Because MySQL tracks a separate level of permission at the database level,

this view was added as a complement to the TABLE_PRIVILEGES and COLUMN_PRIVILEGES stan-

dard views. Listing 21-12 shows a DESCRIBE and a simple SELECT from the view.

Listing 21-12. INFORMATION_SCHEMA.SCHEMA_PRIVILEGES

mysql> DESCRIBE INFORMATION_SCHEMA.SCHEMA_PRIVILEGES;

+----------------+---------------+------+-----+---------+-------+

| Field          | Type          | Null | Key | Default | Extra |

+----------------+---------------+------+-----+---------+-------+

| GRANTEE        | varchar(81)   | NO   |     |         |       |

| TABLE_CATALOG  | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA   | varchar(64)   | NO   |     |         |       |

| PRIVILEGE_TYPE | varchar(64)   | NO   |     |         |       |

| IS_GRANTABLE   | varchar(3)    | NO   |     |         |       |

+----------------+---------------+------+-----+---------+-------+

5 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.SCHEMA_PRIVILEGES LIMIT 5;

+---------+---------------+--------------+----------------+--------------+

| GRANTEE | TABLE_CATALOG | TABLE_SCHEMA | PRIVILEGE_TYPE | IS_GRANTABLE |

+---------+---------------+--------------+----------------+--------------+

| ''@'%'  | NULL          | test         | SELECT         | NO           |

| ''@'%'  | NULL          | test         | INSERT         | NO           |

| ''@'%'  | NULL          | test         | UPDATE         | NO           |

| ''@'%'  | NULL          | test         | DELETE         | NO           |

| ''@'%'  | NULL          | test         | CREATE         | NO           |

+---------+---------------+--------------+----------------+--------------+

5 rows in set (0.01 sec)

The fields contained in INFORMATION_SCHEMA.SCHEMA_PRIVILEGES are as follows:

• GRANTEE: Shows the 'user'@'host' format for the user having this database access.

• TABLE_CATALOG: Always NULL.

• TABLE_SCHEMA: Shows the database for which the user has been granted access.

• PRIVILEGE_TYPE: Any of the standard privileges on a MySQL system dealing with

database-level permissions.

assigning access permissions.

• IS_GRANTABLE: Either YES or NO. Indicates whether the WITH GRANT OPTION was used in


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

The advantage of using this view over the mysql.db system table is that the SCHEMA_

PRIVILEGES view shows a normalized version of the grant information, with each privilege

provided in a separate row entry. However, unfortunately the User and Host columns of the

mysql.db table are combined in the view as the GRANTEE column. There’s no equivalent SHOW

command for this operation.

INFORMATION_SCHEMA.USER_PRIVILEGES

Like the previous view, INFORMATION_SCHEMA.USER_PRIVILEGES is not part of the ANSI standard.

It shows information pertaining to the global privileges of the system users. Listing 21-13

shows a DESCRIBE and a simple SELECT from the view.

Listing 21-13. INFORMATION_SCHEMA.USER_PRIVILEGES

mysql> DESCRIBE INFORMATION_SCHEMA.USER_PRIVILEGES;

+----------------+---------------+------+-----+---------+-------+

| Field          | Type          | Null | Key | Default | Extra |

+----------------+---------------+------+-----+---------+-------+

| GRANTEE        | varchar(81)   | NO   |     |         |       |

| TABLE_CATALOG  | varchar(4096) | YES  |     | NULL    |       |

| PRIVILEGE_TYPE | varchar(64)   | NO   |     |         |       |

| IS_GRANTABLE   | varchar(3)    | NO   |     |         |       |

+----------------+---------------+------+-----+---------+-------+

4 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_PRIVILEGES LIMIT 5;

+--------------------+---------------+----------------+--------------+

| GRANTEE            | TABLE_CATALOG | PRIVILEGE_TYPE | IS_GRANTABLE |

+--------------------+---------------+----------------+--------------+

| 'root'@'localhost' | NULL          | SELECT         | YES          |

| 'root'@'localhost' | NULL          | INSERT         | YES          |

| 'root'@'localhost' | NULL          | UPDATE         | YES          |

| 'root'@'localhost' | NULL          | DELETE         | YES          |

| 'root'@'localhost' | NULL          | CREATE         | YES          |

+--------------------+---------------+----------------+--------------+

5 rows in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.USER_PRIVILEGES are as follows:

• GRANTEE: Again, the 'user'@'host' format for the privileged user.

• TABLE_CATALOG: Always NULL.

• PRIVILEGE_TYPE: Any of the MySQL standard global privilege types.

• IS_GRANTABLE: Either YES or NO. Was this user given the right to assign similar privileges

using the WITH GRANT OPTION during creation?


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

Again, the advantage here is that privileges are normalized to appear as separate row

entries. There’s no SHOW command equivalent, but the information appearing in the view

comes from the mysql.user system table, which stores the information in a different, non-

normalized layout.

INFORMATION_SCHEMA.TABLE_PRIVILEGES

The INFORMATION_SCHEMA.TABLE_PRIVILEGES view is an ANSI standard view. It displays informa-

tion about the user’s table-level MySQL privileges. Listing 21-14 shows a DESCRIBE and a simple

SELECT for a mock user having limited access to the http_auth table in the test schema.

Listing 21-14. INFORMATION_SCHEMA.TABLE_PRIVILEGES

mysql> DESCRIBE INFORMATION_SCHEMA.TABLE_PRIVILEGES;

+----------------+---------------+------+-----+---------+-------+

| Field          | Type          | Null | Key | Default | Extra |

+----------------+---------------+------+-----+---------+-------+

| GRANTEE        | varchar(81)   | NO   |     |         |       |

| TABLE_CATALOG  | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA   | varchar(64)   | NO   |     |         |       |

| TABLE_NAME     | varchar(64)   | NO   |     |         |       |

| PRIVILEGE_TYPE | varchar(64)   | NO   |     |         |       |

| IS_GRANTABLE   | varchar(3)    | NO   |     |         |       |

+----------------+---------------+------+-----+---------+-------+

6 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES

-> LIMIT 2 \G

*************************** 1. row ***************************

GRANTEE: 'mkruck'@'localhost'

*************************** 2. row ***************************

GRANTEE: 'mkruck'@'localhost'

TABLE_CATALOG: NULL

TABLE_SCHEMA: ToyStore

TABLE_NAME: Customer

PRIVILEGE_TYPE: SELECT

IS_GRANTABLE: NO

TABLE_CATALOG: NULL

TABLE_SCHEMA: ToyStore

TABLE_NAME: Customer

PRIVILEGE_TYPE: INSERT

IS_GRANTABLE: NO

2 rows in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.TABLE_PRIVILEGES are as follows:

• GRANTEE: Again, the user in a 'user'@'host' format.

• TABLE_CATALOG: Always NULL.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

• TABLE_SCHEMA: Name of the database housing the table.

• TABLE_NAME: Name of the table.

• PRIVILEGE_TYPE: Any of the MySQL table-level privileges available to the user.

• IS_GRANTABLE: Either YES or NO, depending on whether the WITH GRANT OPTION was used

in assignment of privileges.

Like the previous privilege views, there’s no equivalent SHOW command. The view repre-

sents a normalized perspective of the mysql.tables_priv system table, and is a combination

of results returned by SHOW GRANTS and SHOW FULL COLUMNS.

INFORMATION_SCHEMA.COLUMN_PRIVILEGES

Finally, the INFORMATION_SCHEMA.COLUMN_PRIVILEGES view is an ANSI standard view that shows

grant information at the column level. Listing 21-15 shows a DESCRIBE and a simple SELECT

from the view.

Listing 21-15. INFORMATION_SCHEMA.COLUMN_PRIVILEGES

mysql> DESCRIBE INFORMATION_SCHEMA.COLUMN_PRIVILEGES;

+----------------+---------------+------+-----+---------+-------+

| Field          | Type          | Null | Key | Default | Extra |

+----------------+---------------+------+-----+---------+-------+

| GRANTEE        | varchar(81)   | NO   |     |         |       |

| TABLE_CATALOG  | varchar(4096) | YES  |     | NULL    |       |

| TABLE_SCHEMA   | varchar(64)   | NO   |     |         |       |

| TABLE_NAME     | varchar(64)   | NO   |     |         |       |

| COLUMN_NAME    | varchar(64)   | NO   |     |         |       |

| PRIVILEGE_TYPE | varchar(64)   | NO   |     |         |       |

| IS_GRANTABLE   | varchar(3)    | NO   |     |         |       |

+----------------+---------------+------+-----+---------+-------+

7 rows in set (0.00 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES \G

*************************** 1. row ***************************

GRANTEE: 'test_user2'@'localhost'

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

COLUMN_NAME: uid

PRIVILEGE_TYPE: UPDATE

IS_GRANTABLE: NO

TABLE_CATALOG: NULL

TABLE_SCHEMA: test

TABLE_NAME: http_auth

*************************** 2. row ***************************

GRANTEE: 'test_user2'@'localhost'


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

COLUMN_NAME: username

PRIVILEGE_TYPE: UPDATE

IS_GRANTABLE: NO

2 rows in set (0.00 sec)

The fields contained in INFORMATION_SCHEMA.COLUMN_PRIVILEGES are as follows:

• GRANTEE: The user in 'user'@'host' format.

• TABLE_CATALOG: Always NULL.

• TABLE_SCHEMA: Name of the database housing the table.

• TABLE_NAME: Name of the table.

• COLUMN_NAME: Name of the column.

• PRIVILEGE_TYPE: Any of the MySQL column-level privileges available to the user.

• IS_GRANTABLE: Either YES or NO, depending on whether the WITH GRANT OPTION was used

in assignment of privileges.

Again, the results from the view show a mixed combination of the results from SHOW GRANTS

and SHOW FULL COLUMNS, but in a normalized output. Internally, the view is pulling from the

mysql.columns_priv system table.

Usage Examples

Now that you’re familiar with the INFORMATION_SCHEMA views, we’re going to take you a step

further than simple SELECTs, and create some examples that should highlight the power and

flexibility of this new interface. We’ll work through the following examples:

• How to gather selectivity numbers on indexes

• How to summarize table sizes by engine

Example 1: Gathering Selectivity Numbers on Indexes

In the first part of the book, you learned about the importance of knowing the selectivity of

your indexes, and you should understand how a low selectivity may lead to poor performance

of certain queries using your indexes. In this example, we’ll create a SQL script that looks at

the INFORMATION_SCHEMA views and outputs the selectivity numbers for each of your indexes.

The goal of our script is as follows:

• Limit results only to indexes with a selectivity lower than 1.0. Index selectivity of 1.0

means that the index is unique. We’re not interested in identifying unique indexes, as

they’re generally not performance problems.

• Sort the results based on the lowest selectivity to the highest. Remember, the selectivity

of an index can be viewed as the number of unique values in the index divided by the

total number of entries in the index.

Listing 21-16 shows our script.


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

Listing 21-16. ShowIndexSelectivity.sql

SELECT

t.TABLE_SCHEMA

, t.TABLE_NAME

, s.INDEX_NAME

, s.COLUMN_NAME

, s.SEQ_IN_INDEX

, (

SELECT MAX(SEQ_IN_INDEX)

FROM INFORMATION_SCHEMA.STATISTICS s2

WHERE s.TABLE_SCHEMA = s2.TABLE_SCHEMA

AND s.TABLE_NAME = s2.TABLE_NAME

AND s.INDEX_NAME = s2.INDEX_NAME

) AS "COLS_IN_INDEX"

, s.CARDINALITY AS "CARD"

, t.TABLE_ROWS AS "ROWS"

, ROUND(((s.CARDINALITY / IFNULL(t.TABLE_ROWS, 0.01)) * 100), 2) AS "SEL %"

FROM INFORMATION_SCHEMA.STATISTICS s

INNER JOIN INFORMATION_SCHEMA.TABLES t

ON s.TABLE_SCHEMA = t.TABLE_SCHEMA

AND s.TABLE_NAME = t.TABLE_NAME

WHERE t.TABLE_SCHEMA != 'mysql'

AND t.TABLE_ROWS > 10

AND s.CARDINALITY IS NOT NULL

AND (s.CARDINALITY / IFNULL(t.TABLE_ROWS, 0.01)) < 1.00

ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME, s.INDEX_NAME, "SEL %" \G

Here we see the true power of the INFORMATION_SCHEMA interface. This would have been

impossible to do with a single SQL SELECT before. Instead, to get the same information, we

would have had to use a scripting language to make multiple calls to SHOW INDEX and SHOW ➥

TABLE STATUS, combining the results into a table format. In the ShowIndexSelectivity script,

we use a correlated scalar subquery to find the total number of columns in the index (see

Chapter 8). We then join the STATISTICS and TABLES views to get all the information we need,

and use a calculated column to output the selectivity percentage for the Index part.

Listing 21-17 shows the output of our script when run against a small sample database

containing some Job (as in Career) data tables.

Listing 21-17. Output from ShowIndexSelectivity

mysql> source ShowIndexSelectivity.sql

*************************** 1. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: Job

INDEX_NAME: EmployerExpiresOn

COLUMN_NAME: Employer

SEQ_IN_INDEX: 1

COLS_IN_INDEX: 2


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

CARD: 31

ROWS: 56895

SEL %: 0.05

*************************** 2. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: Job

INDEX_NAME: EmployerExpiresOn

COLUMN_NAME: ExpiresOn

SEQ_IN_INDEX: 2

COLS_IN_INDEX: 2

CARD: 49

ROWS: 56895

SEL %: 0.09

*************************** 3. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: Job

INDEX_NAME: ExpiresOnLocation

COLUMN_NAME: Location

SEQ_IN_INDEX: 2

COLS_IN_INDEX: 2

CARD: 28447

ROWS: 56895

SEL %: 50.00

*************************** 4. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: Job

INDEX_NAME: ExpiresOnLocation

COLUMN_NAME: ExpiresOn

SEQ_IN_INDEX: 1

COLS_IN_INDEX: 2

CARD: 38

ROWS: 56895

SEL %: 0.07

... omitted

*************************** 13. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: EmployerRegion

INDEX_NAME: PRIMARY

COLUMN_NAME: Employer

SEQ_IN_INDEX: 1

COLS_IN_INDEX: 2

CARD: 9

ROWS: 495

SEL %: 1.82

*************************** 14. row ***************************

TABLE_SCHEMA: jobs

TABLE_NAME: JobSeekerJob


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

INDEX_NAME: PRIMARY

COLUMN_NAME: JobSeeker

SEQ_IN_INDEX: 1

COLS_IN_INDEX: 3

CARD: 7687

ROWS: 23062

SEL %: 33.33

14 rows in set (0.47 sec)

■Tip In Listing 21-17, you see an example of using the MySQL client source command, which simply

takes a filename parameter and executes the SQL source in the file.

It’s important to recognize here that the STATISTICS.CARDINALITY field contains the num-

ber of unique entries for the current column and all columns in the index of a lower ordinal

position. This means that the value returned for the second column in a three-part index

includes the total number of unique tuples, or entries, for all combinations of the first and

second index part. This is tracked in this way because you can only use an index if all parts

of the index to the left of the current column are used in a WHERE or ON condition.

In the preceding results, what have we identified for the Job table? It seems that the

EmployerExpiresOn index, which is a two-part index comprised of the Employer and ExpiresOn

columns of the Job table, has extremely low selectivity for both parts of the index keys. This

query has shown us an index that, more than likely, the optimizer won’t use, because the

distribution of values is so sparse.

Example 2: Summarizing Table Sizes by Engine

In our second example, we want to display a report that does the following:

• Summarizes the total size, in megabytes, of all our database tables, grouped by storage

engine.

• Shows a running total size. We’ll use our knowledge of running totals from Chapter 8.

Listing 21-18 shows the EngineStorageSummary.sql script.

Listing 21-18. EngineStorageSummary.sql

SELECT

t1.ENGINE

, t1.SIZE_IN_MB / (1024 * 1024) AS "ENGINE MB"

, SUM(t2.SIZE_IN_MB) / (1024 * 1024) AS "Total MB"

FROM

(

SELECT ENGINE, SUM(DATA_LENGTH) AS "SIZE_IN_MB"

FROM INFORMATION_SCHEMA.TABLES

WHERE ENGINE IS NOT NULL


C H A P T E R   2 1   ■ M YS Q L   D ATA   D I C T I O N A RY

GROUP BY ENGINE

) as t1

INNER JOIN

(

SELECT ENGINE, SUM(DATA_LENGTH) AS "SIZE_IN_MB"

FROM INFORMATION_SCHEMA.TABLES

WHERE ENGINE IS NOT NULL

GROUP BY ENGINE

) as t2

ON t1.ENGINE >= t2.ENGINE

GROUP BY t1.ENGINE;

Listing 21-19. Results of EngineStorageSummary.sql

mysql> source EngineStorageSummary.sql

+--------+-----------+----------+

| ENGINE | ENGINE MB | Total MB |

+--------+-----------+----------+

| InnoDB | 4.51563   | 4.51563  |

| MEMORY | 0.00000   | 4.51563  |

| MyISAM | 23.55081  | 28.06643 |

+--------+-----------+----------+

3 rows in set (0.10 sec)

Here, we’ve demonstrated the use of running sum calculations by joining two identical

derived tables using the >= operator. The outermost SELECT statement simply divides the sum

and the running sum by the (1024 * 1024) constant to produce the storage needed in terms of

megabytes. Listing 21-19 shows the result on our test system.

Note that the MEMORY engine doesn’t take up any storage space; everything is in RAM.

Although these are simple examples of what can be done with the INFORMATION_SCHEMA

views, we hope they illustrate the power and flexibility of this new standards interface.

Summary

In this final chapter, you’ve learned about one of the newest features of the MySQL 5 server:

INFORMATION_SCHEMA. You were introduced to some of the advantages of using this virtual

database for reviewing metadata about your database objects, most notably the benefits of

standardization and the ability to use SELECT to view metadata. We detailed the fields available

in each of the views in INFORMATION_SCHEMA. Afterwards, we demonstrated how valuable the

virtual database interface can be through two examples that wouldn’t previously have been

possible in a single SELECT statement.

Because this is a new feature, be sure to check http://www.mysql.com in case new

columns or views become available. We hope that you’ll take some time to experiment with

the INFORMATION_SCHEMA views, and create some of your own scripts summarizing the meta-

data stored in MySQL.


Index

■Symbols

= ANY syntax, 288

>= (greater-than or equal-to operator), 344

■Numbers

0(1) order, 45

0(log n) order, 46

0(n) order, 45

0(xΠ) order, 46

0(nx) order, 46

1:1 relational connectivity, 26

1:N relational connectivity, 26

13-bit heap number, and InnoDB record

16-bit next-key pointer, and InnoDB record

structure, 169

structure, 169

■A

ab (ApacheBench), 212–216

abstract syntax tree, defined, 136

access

access control and privilege verification,

510–516

authenticating users, 511–513

connection parameters, default, 513

host Grant table, 515–516

overview of, 510

verifying user privileges, 513–515

access denied for user messages, 656–657

access types, and EXPLAIN command,

262–274

ALL access type, 274

const access type, 263

eq_ref access type, 264

index access type, 272–273

index_merge access type, 267

index_subquery access type, 268–269

overview of, 262

range access type, 269–272

ref access type, 265

ref_or_null access type, 266–267

unique_subquery access type, 267–268

network access, locking down, 542

physical access to servers, securing, 546

remote access, adding, 543–544

views, and limited access, 420

access and grant management subsystem,

131–133

account schema, properly normalized, 260

accounts

account privileges, controlling, 549

anonymous, removing, 540

new user, adding, 524–526

removing, 528–529

replication accounts, creating, 598

shell accounts, access to, 543

ACID

ACID-compliant multistatement

transaction control, InnoDB, 166

ACID test for transaction compliancy,

72–76

adaptive hash index, defined, 61

Add Host dialog box, 520

adjacency list model, 313

Advanced PHP debugger (APD) extension,

229–234

Advanced PHP Programming (Sams

Publishing, 2004), 234

Aggregated Totals, Finding (code listing),

composite aggregation, defined, 19

defined, 18–19

aggregation

algorithms

algorithm attributes, and creating views,

424–425

binary search algorithms, 50

defined, 44

MERGE algorithm, 440

aliases, views as, 426

ALL access type, 274

AllFusion Component Modeler, 22

AllFusion ERwin Data Modeler, 28–29

ALTER ROUTINE privilege, and function

permissions, 401

ALTER VIEW Statement (code listing), 438

ANALYSE( ) procedure, and selection of data

types, 186–187

anomalies, defined, 90

ANSI

ANSI expressions, and subqueries, 288

ANSI style, vs. Theta style, SQL, 236

ANY expressions, 288

Apache

ApacheBench (ab), 212–216

Apache’s VirtualHost directive, 542


■I N D E X

APD

API

APD Trace Output Using pprofp

(code listing), 233

profiling PHP applications and, 231–233

setting up, 230–231

buffer management API, defined, 41

handler API, 118–121

subsystems and, 112

application developers, team roles, 4–12

applications

replication and performance, 589

security, and access, 551

testing ability to deal with change, 192

architecture. See system architecture

ARCHIVE storage engine, 176

ArgoUML, 24–25

arguments

function arguments, 18

operation arguments, 19

array column types, 184

asensitive cursors, defined, 407

asynchronous vs. synchronous replication,

587–588

atomicity

defined, 26

in transaction processing, 73

auto-incrementing primary key value, 185

autocommit

basics of, 77–81

example of, 93–94

averages, generating, 344–346

■B

B-tree layouts, indexes

basics of, 57–59

MyISAM, 161–162

backups

Backup ID, Finding (code listing), 642

example of database backup, 559–560

protecting, 546

reasons for, 555–556

replication and, 590

binary logs for up-to-date tables, 581–582

of clusters, 641–642

MySQL tools for, 560–581. See also

InnoDB, creating backups of InnoDB

files; mysqldump; mysqlhotcopy

MySQL Administrator, backup utility,

577–581

planning for, 556–559

/backup/shop Directory (code listing), 570

backward-compatibility, and views, 420

Bailing, Derek, 212

base function libraries, 114

baseline model, 30–31

before_customer_delete Trigger, Creating

(code listing), 451–452

BEGIN. . .END Block with Labels

(code listing), 386

BEGIN statements

creating database functions and, 386

stored procedures and, 359

Beginning MYSQL Database Design and

Optimization (Apress, 2004), 9, 179

benchmarking, 189–234

defined, 190

guidelines, 193–198

benchmarks, changing and rerunning,

changed variables, isolating, 195

data sets, using real, 195–196

determining averages, 197

performance standards, setting,

proactive outlook, 194–195

programs and query cache, turning off,

193–194

results, saving, 198

overview of, 189–190

vs. profiling, 190

tools, 198–217. See also Super Smack,

MySQL

ApacheBench (ab), 212–216

httperf, 216–217

MyBench, 212

overview of, 198–201

uses for, 190–193

load limits, determining, 191–192

performance comparisons, 191

problem areas, finding potential,

192–193

change, 192

Berkeley DB storage engine, 36

BETWEEN operator, 269–270, 316

binaries. See prebuilt binaries, for installing

MySQL

binary log (binlog)

basics of, 87

binlog-do-db option, 605

binlog-ignore db option, 605

general query log and, 227

<machine>-bin.index and, 597

replication and, 592–593

for up-to-date tables, 581–582

binary search, 49–51

Bison, 136

BitKeeper, 481

bitmap, defined, 156

blocks, data, 40

backup and restoration, 555–583

testing application’s ability to deal with


■I N D E X

BLOCK_TEMPERATURE variable, 123

blueprint, database, 30–31

Boolean values, and selection of data types,

record cache, 121–122

table cache, 125–127

query cache, 139–140

Bourke, Tony, 201

buffers. See also caching, memory

management subsystem and

buffer and cache allocation configuration

options, 493

buffer management API, defined, 41

defined, 121

InnoDB

buffer pool, 42, 170

doublewrite buffer, 170–172

internal buffers, 170

log buffer, 170

key buffer system, MyISAM, 162

bugs, reporting, 667

build types, 472

business analysts, and team roles, 5–8

business process errors, and triggers, 445

business requirements, analyzing, 3–38

concepts and models, 13–31. See also

modeling approaches

textual object models, 13–15

database blueprint, 30–31

database management systems, 32–35

MySQL, advantages of, 33–35

Oracle, 33

PostgreSQL, 33

SQL Server, 32

environments for database applications,

35–37

team roles, 4–13

application developers, 4–12

business analysts, 5–8

customers, 4–5

database administrators, 11

database designers, 8–11

interface designers, 12

project managers, 12–13

■C

C and C++ programming terms, 108

caching

options, 493

key cache, MyISAM, 161

memory management subsystem and,

121–128

heap table cache, 128

hostname cache, 127

join buffer cache, 128

key cache, 122–125

other caches, 128

privilege cache, 127–128

calculated columns, storing, 379

calculate_total( ) Function, Using

(code listing), 382

call trees, and APD, 230

cardinality, defined, 26

Cartesian product, 253–254

CASCADING keyword, 432–433

cascading levels of access, 435

CASE construct, 364

CASE statements

CASE Statement (code listing), 364

CASE Statement in a Function

(code listing), 390

CASE Statement with Condition Checks

(code listing), 364, 391

creating database functions and, 390

CASE tools, 25

Category table, 312, 314

category tree, diagram of, 314

Celko, Joe, 313

CHANGE MASTER command

core replication options and, 601

managing replication and, 609–610

CHANGE MASTER Statement (code listing),

609–610

CHAR, using with MyISAM, 185

character fields, and string data, 181

characteristics

for creating stored procedures, 358

used in creating stored functions, 385

check options, 432–433

checkpointing

basics of, 84–88

InnoDB, 172–173

(code listing), 317

classes

Child Nodes Under a Parent Node, Finding All

class diagrams, UML, 17–20

class encapsulation, defined, 351

class methods, identifying, 15

identifying, 14

in SQL query execution and parsing, 137

WITH GRANT OPTION clause, 506

IDENTIFIED BY clause, 516

Client Configuration in select-key.smack

(code listing), 204–205

client configuration options, 488

client issues, troubleshooting

MySQL server not responding, 658–659

packet length too big messages, 659–660

server has gone away messages, 660–661

client/server communication, 130–131

buffer and cache allocation configuration

clauses, user administration


■I N D E X

clustered and non-clustered index

Sample Options from mybackup.cnf for

initial configuration and startup, 627–634

mysqlhotcopy, 570

management client, checking processes

Benchmarking and Profiling

client-side cursors, 406

client source command, 697

CLOSE statements, and creating cursors, 413

clustering, 617–644

background, 618–619

backing up and restoring, 641–642

basics of, 618–619

cluster processes

management client, 636

management server daemon, 634–635

storage node daemon, 635

clustering keys

choice of, 65

defined, 56

selection, 65–66

configuration file options, 636–639

implementing, 619–626

limitations of MySQL cluster, 625–626

node arrangement, 621–623

nodes, 620–621

nodes, calculating number of, 624

indexes and

organization, 55–57

clustered index page format, InnoDB,

management node configuration,

with, 630–634

627–629

SQL node configuration, 629–630

storage nodes configuration, 629

installing MySQL cluster, 627

log files and, 643–644

management client, 640–641

security of, 644

single user mode command, 641

Cockburn, Alistair, 8

code. See also source code and

documentation

overoptimizing application code, 218

SQL

formatting, 236–237

specific and consistent coding, 237–238

code listings (by chapter)

Backup and Restoration

Applying Log Files to InnoDB Data Files,

575–576

Backup Using innobackup, 576

Contents of the backup Directory, 575

Contents of the innobackup Backup

Directory, 576–577

Creating a New Database with

mysqlhotcopy, 571

Creating the Complete Configuration

File for ibbackup, 577

crontab Entries to Automate Backup,

ibbackup Command and Arguments,

Limiting the mysqlbinlog Output, 582

Listing of the /backup/shop Directory,

Moving MySQL to Backed-Up Data Files,

Output from mysqlhotcopy, 570

Output of Backup Directory, 568

Output of mysqldump for the customer

Output of mysqldump for the cust_order

Table, 560

Table, 568

Restoring a Single Table, 569

Restoring MyISAM Data Files with a

Wildcard Character, 572

Sample Options from a Live my.cnf for

ibbackup, 574

ibbackup, 575

Simple Backup with mysqlhotcopy, 570

Using a Regular Expression with

APD Trace Output Using pprofp, 233

Client Configuration in select-

key.smack, 204–205

Dictionary Configuration Section in

select-key.smack, 207–208

Excerpt from ./test-connect, 201

Excerpt from the General Query Log,

Executing Super Smack for the First

228–229

Time, 202

EXPLAIN for finduser1.php, 223

EXPLAIN Output from SELECT

Statement in finduser2.php, 225

finduser1.php, 213–214

finduser3.php, 231–232

Main Execution Object in select-

key.smack, 210–211

Output from httperf, 216–217

Output from mysqldumpslow, 226

Query Object Definition in select-

key.smack, 209

215–216

Running ApacheBench and the Output

Results for finduser1.php, 214–215

Sample Excerpt from RUN-mysql-

Linux_2.6.10_1.766_FC3_i686, 200

Second Client Object Definition in

select-key.smack, 210

Applying the Log File to Data Files,

Results for finduser2.php (REGEXP),


SHOW STATUS Command Example,

Essential SQL

■I N D E X

SHOW FULL PROCESSLIST Results,

221–222

222–223

Table Section Definition in select-

key.smack, 205

Cluster

Cluster Restore with Schema Create, 642

Command to Enter Single user Mode,

Command to Exit Single User Mode, 641

Command to Start the Cluster

Management Daemon, 628

Command to Start the Cluster Storage

Node Daemon, 629

Create a Table in the Cluster, 631

Creating a Table with Unavailable

Database Nodes, 633

Example Calculation of Required

Memory, 624

Finding the Backup ID, 642

Formula for Calculating Required

Memory, 624

Output from the Cluster SHOW

Command, 630–631

Output from the Cluster SHOW

Command with Disconnected Nodes,

632–633

Output from the Cluster SHOW

Command with Reconnected Nodes,

633–634

Records in the Formerly Failing Node,

Sample Error from the Management

Daemon, 629

Sample Management Node

Configuration, 628

Sample Output from a Cluster Log File,

Sample Output from a Node Log File,

Sample Storage Node Configuration, 629

SELECT Data from the Other SQL Node,

Start the Cluster Management Client,

Start the SQL Node of the Cluster, 630

Starting a Cluster Backup, 642

Cursors

city_list( ) Function, 409–410

login_archived( ) Procedure, 414–415

Record Counts After Calling

archive_login( ), 417

Record Counts Before Calling

archive_login( ), 416

Running login_archive( ), 416–417

Using the city_list( ) Function, 410

Adding an Index on CustomerOrder, 271

Another Example of an Outer Join, 250

Complex Scalar Subquery Showing

Average Category Unit Prices, 285

Corrected Output Using

COUNT(table.column) and IFNULL( ),

246–247

Corrected SQL Demonstrating the Outer

Join ON Clause Filter, 252

Create Script for the Sample Schema,

240–241

Creating 2004 Summary Data and

Selecting December’s Data, 255–256

Current Year’s Data Set, 255

Example of a Columnar Subquery, 287

Example of a Correlated Scalar

Subquery, 287

Example of a Cross Join, 253–254

Example of a Derived Table Query, 294

Example of a More Complex Scalar

Subquery, 283

Example of a Multiple Inner Join,

Example of a Natural Join, 261

Example of a NOTE EXISTS Subquery,

Example of a Simple Scalar Subquery,

243–244

289–290

280–281

Example of Columnar Subquery

with = ANY syntax, 288

Hint Forces a Different Access

Strategy, 278–280

Example of the const Access Type, 263

Example of the eq_ref Access Type, 264

Example of the index Access Type, 273

Example of the index_subquery Access

Type, 268–269

Example of the range Access Type with

the BETWEEN Operator, 269–270

Example of the range Access Type with

the IN Operator, 270

Example of the ref Access Type, 265

Example of the ref_or_null Access Type,

Example of the STRAIGHT_JOIN Hint,

Example of the unique subquery Access

Type, 267–268

Example of the USING Keyword,

261–262

Example of Using EXISTS in a

Correlated Subquery, 289

Sample Configuration for the SQL Node,

Example of How the IGNORE INDEX


■I N D E X

Inefficient PHP Code to Find Customers

Output of SHOW CREATE FUNCTION,

Inner Join Fails to Get All Categories,

Output of SHOW FUNCTION STATUS,

Join Order Different from the Written

REPEAT Statement, 393

Sample Listing from a Customer Order

Listing 7-43 Rewritten As an Outer Join,

Table, 378, 382–383

398–399

Listing 7-52 Rewritten Using LEFT JOIN

Functions, 397–398

No Usable Index, Even with a range Type

Calculated in Function, 379–380

Essential SQL (continued)

EXPLAIN for the Scalar Subquery in

Listing 7-39, 281–282

EXPLAIN from Listing 7-53, 291

EXPLAIN Output from Listing 7-43, 286

EXPLAIN Output of Listing 7-57,

First Report Attempt with an Inner Join,

294–295

244–245

Getting Product IDs Purchased More

Than Once, 292

Without Orders, 249–250

247–248

SELECT, 275

284–285

287–288

Listing 7-48 Rewritten As an Inner Join,

and IS NULL, 290

Query, 270–271

Outer Join, 250

Proper Set-Based Approach Using an

Removing Static Date Column, 257–258

Second Report Attempt with an Outer

Slight Adaptation of the Query in Listing

Join, 245–246

7-10, 251

Smaller Possible Range of Values, 272

Subquery of Aggregated Correlated Data

Using NOT EXISTS, 292–293

Temporary Storage for Percentage

Differences, 253

UNION Query Merging Two Previous

Resultsets, 256–257

UNION Query to Find System User

Information, 259

Updated Category Listing, 248–249

Using a Derived Table to Sum, Then

Average Across Results, 296

Using LIMIT with a Derived Table,

BEGIN. . .END Block with Labels, 386

CASE Statement in a Function, 390

CASE Statement with Condition Checks,

296–297

Functions

382, 402

Declaring a Condition and Handler, 388

Function to Calculate Rush Shipping

Charges, 396

Function to Calculate Shipping, 395–396

Function to Calculate Tax, 395

Function to Calculate Total Cost, 397

IF Statement, 389

LOOP Statement with ITERATE, 392–393

LOOP Statement with LEAVE, 391–392

Output from SELECT Using Created

Functions, 398

Output from SELECT Using the

calculate_total( ) Function, 383

Output of Function Data from

mysql.proc Table, 400–401

Sample Listing of Orders with

Calculated Total, 378–379

SELECT Statement Using Created

SELECT Statement with Total

SELECT Statement with Total

Calculated in SQL, 379

Simple Calculation Directly in Query,

Simple Calculation Using Function, 402

Using the calculate_total( ) Function,

WHILE Statement, 393

Index Concepts

CREATE TABLE Statements for Similar

MyISAM and InnoDB Tables, 56–57

MySQL Data Dictionary

EngineStorageSummary.sql, 697–698

INFORMATION_SCHEMA.CHARACTER_

SETS, 687–688

INFORMATION_SCHEMA.COLLATION_

CHARACTER_SET_APPLICABILITY,

INFORMATION_SCHEMA.COLLATIONS,

INFORMATION_SCHEMA.COLUMN_

PRIVILEGES, 693–694

INFORMATION_SCHEMA.COLUMNS,

688–689

678–680

INFORMATION_SCHEMA.KEY_

COLUMN_USAGE, 681–682

INFORMATION_SCHEMA.ROUTINES,

INFORMATION_SCHEMA.SCHEMA_

PRIVILEGES, 690

INFORMATION_SCHEMA.SCHEMATA,

CREATE Statement for calculate_total( ),

684–686


■I N D E X

INFORMATION_SCHEMA.STATISTICS,

682–683

INFORMATION_SCHEMA.TABLE_

CONSTRAINTS, 676–677

/sql/sql_select.cc mysql_select( ), 147

/sql/sql_select.cc sub_select ( ), 148–149

st_net Struct Definition, 129

st_table Struct (Abridged), 125–126

INFORMATION_SCHEMA.TABLE_

Replication

INFORMATION_SCHEMA.USER_

Snapshot, 600

Results of EngineStorageSummary.sql,

Output from SHOW MASTER STATUS,

PRIVILEGES, 692–693

INFORMATION_SCHEMA.TABLES,

PRIVILEGES, 691

INFORMATION_SCHEMA.VIEWS,

Output from ShowIndexSelectivity,

674–676

686–687

695–697

ShowIndexSelectivity.sql, 695

MySQL Installation and Configuration

Sample my.cnf File for mysql_multi, 495

Sample my.cnf File with Groups, 487

MySQL System Architecture

Constants Defined in sql_acl.h, 132

handler Class Definition (Abridged),

119–120

my_b_read Macro, 122

/myisam/mi_scan.c mi_scan( ), 151

/myisam/mi_scan_init( ), 150

MYSQL_LOG Class Definition, 133–134

Query_cache_block Struct Definition

(Abridged), 140

/sql/handler.h handler::ha_rnd_init( ),

/sql/mysqld.cc create_new_thread( ),

init( ), 150

142–143

sockets( ), 142

/sql/mysqld.cc main( ), 141

/sql/records.cc rr_sequential( ), 150–151

/sql/sql/records.cc init_read_record ( ),

144–145

/sql/sql_parse.cc do_command( ), 144

/sql/sql_parse.cc handle_one_

connection( ), 143

/sql/sql_parse.cc mysql_execute_

command( ), 145–146

/sql/sql_parse.cc mysql_parse( ), 145

/sql/sql_select.cc do_select( ), 148

/sql/sql_select.cc handle_select( ),

/sql/sql_select.cc JOIN:exec( ), 147

/sql/sql_select.cc join_init_read_record( ),

146–147

Clause, 610

SQL Scenarios

CHANGE MASTER Statement, 609–610

Create a Snapshot of the Data, 599

Create Slave Tables from Master

DELETE Statement to Test Binary Log,

LAST Statement in Binary Log, 593

Lock Tables and Find Binary Log

Position, 599

Output from SHOW SLAVE HOSTS, 607

Output from SHOW SLAVE STATUS,

607–608

Release Tables Lock, 599

Sample master.info File, 595

Sample relay-log.info File, 596

Set up Slave for Replication with

CHANGE MASTER, 600

Starting the I/O Thread, 610

Starting the SQL Thread, 610

Starting the SQL Thread with the UNTIL

Adding a Non-Unique Index to Speed

Category Table Data, 314

Changing the Report Order and

Generating Running Averages, 346

Checking the Metadata Status, 326

Combining Two Queries for a Distance

Creating a New Table with the Unique

Creating a Running (Cumulative) Sum

Records, 306–307

Column, 345–346

Determining How Many Duplicate URLs

Determining the Converted Radian

Values, 330

Distances from a Specific Zip Code to All

Known Zip Codes, 334

EXPLAIN from Listing 8-5, 302–303

EXPLAIN of Listing 8-2 on a 4.1.9 Server,

EXPLAIN of Listing 8-2 on a 5.0.4 Server,

EXPLAIN of the Distance Query, 333

EXPLAIN Output from Listing 8-47,

300–301

337–338

/sql/ha_myisam.cc ha_myisam::rnd_

Up Queries, 305

/sql/mysqld.cc handle_connections_

to Store Report, 343

/sql/sql_parse.cc dispatch_command( ),

Exist in the Data Set, 305


■I N D E X

SQL Scenarios (continued)

The Same Query on a Larger Table,

EXPLAIN Output from Listing 8-51,

327–328

341–342

339–340

Node, 317

315–316

334–335

EXPLAIN Results from Listing 8-49,

Finding Aggregated Totals, 320

Finding All Child Nodes Under a Parent

Sample Table Schema for Storing

Advertisements, 326

Simple OR Condition, 300

StoreLocation Table Definition, 336

Two Simple Reports Showing Identical

Counts, 308

Finding All Parent Nodes, 318

Finding the Level of a Node in the Tree,

UNION Query Resolves the Problem, 302

Using a Cross Join Rather Than User

Finding ZCTAs Within a Specific Radius,

Using a Derived Table for an OR

Gathering Coordinate Information for

Using GROUP BY to Get Unique URL

Variables, 332–333

Condition, 303

Records, 306

Inserting a New Node and Updating the

Creating a MERGE Table from Two

Zip Codes, 331–332

Getting Sales for Products Within a Node

of a Tree, 319

Getting the Total Depth of the Tree, 316

Identifying Orphaned Records with an

Outer Join, 309

Initial Design for the ZCTA Table, 329

Initial Schema for the Duplicate Data

Scenario, 304–305

Metadata, 322–323

Loading the New Radian Values,

330–331

Location Table Definition, 300

Mismatched Reports Due to a Missing

Parent Record, 308–309

Multitable DELETE Statement to

Remove Orphaned Records, 310

Non-Correlated Subquery to Find

StoreLocation Records Within Zip

Radius, 336–337

Ordering Results from Nearest to

Farthest, 335–336

Plugging the User Variables into the

Distance Formula, 332

Removing a Node, 325

Removing the Derived Table in Favor of

a Standard Inner Join, 341

Retrieving a Node and All Its Children,

Retrieving All Sports Gear Categories

and Subcategory IDs, 318–319

Retrieving Total Sales for Each Product,

Verifying That the Delete Statement

Removed the Orphaned Records, 310

Verifying the New Node Insertion, 324

Storage Engines and Data Types

Aggregated Results from the MERGE

Table, 175

Creating a MERGE Table from Monthly

Log Tables, 174–175

Identical Tables, 173–174

Creating an InnoDB Table with a

Foreign Key Constraint, 164–165

Making a MEMORY Table Use a B-Tree

A Simple MyISAM web Traffic Log Table,

Index, 176

Using PROCEDURE ANALYSE( ) to Find

Data Type Suggestions, 186–187

Stored Procedures

Calling a Single-Statement Procedure,

354–355

367–368

Calling a Stored Procedure from PHP,

Calling a Stored Procedure with

Parameters from PHP, 368

CASE Statement, 364

CASE Statement with Condition Checks,

Creating a Multistatement Stored

Procedure, 355–356

Creating a Single-Statement Procedure,

Declaring a Condition and Handler,

Returning a Single Random Banner

362–363

Record, 327

Getting OUT Parameters from a Stored

Returning a Single Random Record from

Procedure, 366–367

a Larger Table, 328

Revised Query to Use a Single Derived

Table, 338–339

Sales Rollup Report by Category,

320–321

IF Statement, 363

LOOP Statement with LEAVE, 365

Loop with ITERATE Statement, 365

Output from a Stored Procedure Called

in PHP, 367–368


Output of SELECT from the mysql.proc

User Administration

Table, 370–371

Querying the columns_priv Grant Table

Output of SHOW CREATE PROCEDURE,

Directly, 509

Output of SHOW PROCEDURE STATUS,

508–509

■I N D E X

Creating the before_customer_update

Views

369–370

REPEAT Statement, 366

WHILE Statement, 365

Triggers

Complete cust_order Insert Trigger, 458

Complete cust_order Update Trigger,

459, 460

Creating the before_customer_delete

Trigger, 451–452

Trigger, 449

Current cust_order Record, 460–461

Delete Trigger for Performance Testing,

Description of the customer_audit Table,

Description of the cust_order Table, 456

Inserting into the cust_order Table with

an Invalid Discount, 458

Limiting the Discount Field to 15%, 458

Limiting the Increase in

discount_percent, 460

Output from cust_order Table with a

Limited Increase, 461

Output of cust_order Table After Insert,

Records in the customer Table, 448

Records in the customer Table After

Updating, 450

After Deletions, 452

Records in the customer_audit Table

After Updating, 451

Trigger to Calculate the Total, 456–457

Trigger to Calculate the Total with a

Discount Check, 457

Limit, 461

Updating customer Records, 450

Troubleshooting

egrep of Error Log, 663

Entries in Log for Initial Startup, 647

Entries in Log for Shutdown, 647

Entries in Log for Startup, 646

General Query Log Entries, 648–649

Output from mysqladmin version, 662

Output from SHOW PROCESSLIST, 651

Running MySQL Without a Startup

Script, 664

Slow Query Log Entries, 650

Uptime from MySQL Client, 662

Querying the user Grant Table Directly,

Revoking Table-Level Privileges and

Granting Column-Level Privileges,

SHOWS GRANTS Output, 508

user Grant Table, 511

Using the CURRENT_USER( ) Function

to Determine Active Entry, 513

Using the USAGE Privilege to Change

Global User Restriction Variables, 518

Adding ORDER BY to the Joined Table

View, 428–429

ALTER VIEW Statement, 438

Creating a Simple View, 423

Creating a UNION View with a Data

Source, 431

Creating a View with Check Options, 432

Creating a View with Joined Tables, 427

Creating a View with Specified Column

Names, 426

Creating a View with UNION, 430–431

Creating an Updatable View, 434

Illegal Update of a View with Check

Options, 432–433

Output from the Altered View, 439

Output of a UNION View with a Data

Output of a View with a GROUP BY

Source, 431

Clause, 429

Output of DESCRIBE all_customers, 436

Output of Selecting from the View

Created with UNION, 431

Output of SHOW CREATE VIEW, 436

Output of the View with Joined Tables,

Records in customer Table, 422

Records in the customer_region3 View,

Sample Customer Database from

434–435

Region 1, 430

Selecting from a View, 423

Selecting from the View with Specified

Column Names, 426

The ship_summary.frm Data Dictionary

Using a GROUP BY Clause to Create a

File, 437

View, 429

Using HAVING with GROUP BY to

Create a View, 429

Records in the customer_audit Table

Output of a View with a HAVING Clause,

Update with discount_percent Increase


■I N D E X

Daemon (code listing), 628

configuration smack files, 204–211

column privilege scope, 504–505

columnar subqueries, 287–293

columns

calculated columns, storing, 379

column names, and creating views, 426

COLUMNS view, 680

Creating a Running (Cumulative) Sum

Column (code listing), 345–346

matching column types, 65

Seconds_Behind_Master column, 609

text columns and benchmarking, 196

command line

options

mysqldumpslow, 227

pprofp, 232

user accounts, managing from, 516–519

Command to Enter Single user Mode

(code listing), 641

Command to Exit Single User Mode

(code listing), 641

Command to Start the Cluster Management

Command to Start the Cluster Storage Node

Daemon (code listing), 629

commands. See also specific commands

profiling and

EXPLAIN command, 223–225

SHOW FULL PROCESSLIST command,

219–222

COMMENT characteristic

creating stored functions and, 385

stored procedures and, 358

communication

client/server communication, 130–131

communication model, 16

network management and

communication subsystem, 128–131

companies, hosting, 35

component model, 16

composite aggregation, defined, 19

compression

compressed record format, MyISAM,

158–159

of data, 62–64

44–46

computational complexity, and data access,

computer options in management server

configuration, 637

concurrency

example, 93–94

isolation and concurrency, implementing,

88–101

isolation levels, 90–92

locking resources, 88–90

standards, 194

conditions

database functions, creating and, 388

stored procedures and

handler conditions, 361–362

self-defined conditions, 362

config.ini, 636–639

Configuration File, Creating Complete for

ibbackup (code listing), 577

configuration of MySQL, 485–493

configuration files, location of, 485–486

configuration groups, 486–487

Configuration Wizard, 475

introduction to, 469

options, 487–493

buffer and cache allocation, 493

client, 488

engine-specific, 491

logging, 490

replication, 492

server, 488–490

server SSL, 493

defined, 201

dictionary configuration section, 207–208

first client configuration section, 204–205

main section, 210–211

query configuration section, 209

second client configuration section, 210

table configuration section, 205–207

connection parameters, default, 513

persistent and non-persistent, Super

Smack, 211

troubleshooting

can’t connect through socket errors,

653–654

can’t connect to host errors, 655

too many connections error, 658

connectivity

limited, and replication, 590

relational, 26

consistent state, atomic operations, 73–74

const access type, 263

Constants Defined in sql_acl.h (code listing),

consultants, for MySQL support, 668

contrived load generators, 192

core replication options, 601–602

correlated subqueries

basics of, 286–287

values and, 269

COUNT( ) function

outer joins and, 246

summarizing across trees and, 319

crash-me script, 198

CREATE DATABASE statement, 631

CREATE FUNCTION statement, 381

SHOW STATUS command, 222–223

connections


■I N D E X

CREATE ROUTINE privilege, 401

CREATE statement

CREATE Statement for calculate_total( )

(code listing), 382, 402

creating views and, 423–424

stored procedures, creating and, 357–358

triggers, defining with, 452–453

CREATE TABLE Statements for Similar

MyISAM and InnoDB Tables

(code listing), 56–57

CREATE USER command, 517

create version ID

defined, 100

transaction requests and, 101

CREATE VIEW privilege, 440

critical error entries, 648

critical sections, defined, 116

cross joins

basics of, 253–254

Cross Join, Using Rather Than User

Variables (code listing), 332–333

CSV storage engine, 177

currency data, storing, 179

Current Year’s Data Set (code listing), 255

CURRENT_USER( ) Function, Using to

Determine Active Entry (code listing),

cursors, 405–418

creating, 408–413

CLOSE statements, 413

DECLARE statements, 410–412

FETCH statements, 413

OPEN statements, 412

database cursor basics, 405–407

in MySQL, 407–408

using, 413–417

customer object methods, 15

customer Records, Updating (code listing),

customer_audit Table After Deletions, Records

in (code listing), 452

customer_audit Table After Updating, Records

in (code listing), 451

Customer_audit Table, Description of

(code listing), 449

customers, and team roles, 4–5

cust_order, and triggers (code listings)

cust_order, Complete Record, 460–461

cust_order, Complete Update Trigger), 459,

cust_order Insert, Complete Trigger, 458

cust_order Table, Description of, 456

cust_order Table, Inserting into with an

Invalid Discount, 458

cust_order Table, Output from with a

Limited Increase, 461

cust_order Table, Output of After Insert, 459

■D

daisy chain of replicated machines, 614–615

data. See also hierarchical data; replication

access to, controlling, 542–543

aggregating, and MySQL outer joins,

244–247

caches. See caching, memory

management subsystem and

data elements of objects and actions, 17

flushing data, defined, 74

inconsistent data, defined, 9–10

indexes and. See also retrieval of data

methods

clustered vs. non-clustered data, 55–57

compression of data, 62–64

computational complexity, 44–46

data pages, 42–43, 54–55

invalidated index data, 55

record data changes, 55

integrity of, 9–10

knowledge of, and security, 534

numeric data and selection of data types,

179–180

resolving corruption of, 666–667

storage of, 40–43

currency data, 179

data blocks and, 40

data pages, 42–43

hard disks and, 40–41

image data, 185

memory and, 40–41

outside of databases, 185

persistent data, 40–41

RAM and, 41

secondary storage, defined, 40

security and, 551–553

storage space for data pages, 54–55

volatile, 41–42

Data Definition Language (DDL) statements,

data dictionary, 669–698

INFORMATION_SCHEMA

benefits of, 670–671

described, 669

INFORMATION_SCHEMA views, 671–694

INFORMATION_SCHEMA.CHARACTER_

SETS view, 687–688

INFORMATION_SCHEMA.COLLATION_

CHARACTER_SET_APPLICABILITY

view, 689–690

INFORMATION_SCHEMA.COLLATIONS

INFORMATION_SCHEMA.COLUMNS

view, 688–689

view, 678–680

INFORMATION_SCHEMA.KEY_

COLUMN_USAGE view, 680–682


■I N D E X

data dictionary (continued)

data types. See also storage engines and

Data Encryption Standard (DES) functions,

INFORMATION_SCHEMA.ROUTINES

view, 684–686

INFORMATION_SCHEMA.SCHEMA_

PRIVILEGES view, 690–691

INFORMATION_SCHEMA.SCHEMATA

INFORMATION_SCHEMA.STATISTICS

view, 673

view, 682–684

INFORMATION_SCHEMA.TABLE_

CONSTRAINTS view, 676–677

INFORMATION_SCHEMA.TABLE_

PRIVILEGES view, 692–693

INFORMATION_SCHEMA.TABLES

view, 674–676

INFORMATION_SCHEMA.USER_

PRIVILEGES view, 691–692

INFORMATION_SCHEMA.VIEWS view,

686–687

overview of, 671–672

The ship_summary.frm Data Dictionary

File (code listing), 437

usage examples, 694–698

selectivity numbers on indexes,

gathering, 694–697

table sizes by engine, summarizing,

697–698

data files

backup and restoration and

Applying Log Files to InnoDB Data Files

(code listing), 577

Applying the Log File to Data Files

(code listing), 575–576

Moving MySQL to Backed-Up Data Files

(code listing), 576, 577

Restoring MyISAM Data Files with a

Wildcard Character (code listing),

data file permissions, checking, 540

InnoDB data files, 574

log files and

Log File, Applying to Data Files

(code listing), 575–576

Log Files, Applying to InnoDB Data Files

(code listing), 577

Restoring MyISAM Data Files with a

Wildcard Character (code listing),

data members, identifying, 14

data pages

indexes and, 42–43, 54–55

InnoDB organization of, 167–170

data types

unmatching, 384

database administrators, and team roles, 11

database architects, 8–11

database blueprint, 30–31

database designers, and team roles, 8–11

database functions. See functions

database management systems, 32–35

MySQL, advantages of, 33–35

Oracle, 33

PostgreSQL, 33

SQL Server, 32

database privilege scope, 501–503

databases

backups, 559–560

cursors, 405–407

load and replication speed, 612

naming conventions, 30–31

normalization of, 9

replication

backup requirements and, 558

speed of, 612

security of. See security

storing data outside of, 185

DBDesigner4, 29–30

DDL (Data Definition Language) statements,

deadlocks, 99–100

debug build type, 472

debuggers, and profilers, 217

DECIMAL, 186

DECLARE statements, 359–366

CASE construct, 364

conditions and handlers, 360–363, 388

cursors, creating and, 410–412, 413

database functions, creating and, 387

IF statements, 363

ITERATE statements, 365

LOOP and LEAVE statements, 364–365

REPEAT statements, 366

variables and, 359–360

WHILE statements, 365

default connection parameters, 513

default permissions, 498

defragmenting, defined, 42

DELETE operations, 101

DELETE statements (code listings)

DELETE Statement (Multitable) to Remove

Orphaned Records, 310

DELETE Statement to Test Binary Log, 593

DELETE Statement, Verifying That it

Removed the Orphaned Records, 310

Delete Trigger for Performance Testing

data sets, and benchmark tests, 195–196

(code listing), 464


■I N D E X

data dictionary file, 437, 439

dictionary configuration section, Super

ENUM

Smack, 207–208

directories

Directory Contents, innobackup Backup

environments for database applications,

delete version ID

defined, 100

transaction requests and, 101

deleting. See removing

demarcation, and transaction wrappers,

76–77

deployment diagrams, UML, 20–21

deployment model, 16

derived tables

basics of, 293–297

Derived Table, Removing in Favor of a

Standard Inner Join (code listing),

UNION query and, 303

DES (Data Encryption Standard) functions,

developer tools package, Unix, 481

development source tree, for installing on

Unix, 481–483

diagnostic techniques, vs. profilers, 217

diagrams, UML

class diagrams, 17–20

deployment diagrams, 20–21

dictionaries

(code listing), 576–577

directory structure, MySQL, 471

InnoDB directory layout, 166–167

MyISAM storage engine directory layout,

155–156

security, and access to, 547–548

top-level, 106–107

dirty reads, defined, 90

Discount Field, Limiting to 15% (code listing),

data

distances. See also geographic coordinate

Distances from a Specific Zip Code to All

Known Zip Codes (code listing), 334

distributors, defined, 586

documentation. See also source code and

documentation

MySQL, 109–110

on security policy and plan, 538–539

Doxygen, 109

DROP function, 401

DROP TRIGGER statement, 462–463

DROP USER command, 518

DROP VIEW command, 439

dumps, defined, 217

Duncan, John David, 121

duplicate entries, 303–307

durability of transactions, 76

dynamic record format, MyISAM, 157–158

■E

E-R diagramming. See entity-relationship

approach

efficiency, relational database groups, 8–9

egrep of Error Log (code listing), 663

encryption

basics of, 551–553

encrypted file systems, 548

END statements

creating database functions and, 386

stored procedures, 359

engines. See storage engines and data types

enterprise-level deployment diagrams, 21

Enterprise Manager and Query Analyzer,

SQL Server, 32

entity-relationship approach

E-R diagramming, 25–27

E-R diagramming tools, 27–30

AllFusion ERwin Data Modeler, 28–29

DBDesigner4, 29–30

ENUM column types, replacing, 186

ENUM data, and selection of data types,

35–37

eq_ref access type, 264

errors

error numbers, 360

replication, and Last_Error message,

608–609

Sample Error from the Management

Daemon (code listing), 629

troubleshooting

can’t connect to host errors, 655

critical error entries, 648

errors logs, 646–648

MySQL server not responding, 658–659

packet length too big messages,

server has gone away messages,

659–660

660–661

socket connection errors, 653–654

too many connections error, 658

Essentials download, 475

examples. See locking, locking and isolation

levels, examples

exclusive locks, 89–90

EXECUTE privilege, and function

permissions, 401

EXISTS expressions, and subqueries, 288–293


■I N D E X

EXPLAIN command

access types and, 262–274

ALL access type, 274

const access type, 263

eq_ref access type, 264

index access type, 272–273

index_merge access type, 267

index_subquery access type, 268–269

overview of, 262

range access type, 269–272

ref access type, 265

ref_or_null access type, 266–267

unique_subquery access type, 267–268

profiling and, 223–225

query profiling and, 65

using on query of views, 442

EXPLAIN for finduser1.php (code listing), 223

EXPLAIN for the Scalar Subquery in

Listing 7-39 (code listing), 281–282

EXPLAIN of Listing 8-2 on a 4.1.9 Server

(code listing), 300–301

EXPLAIN of Listing 8-2 on a 5.0.4 Server

(code listing), 301

EXPLAIN of the Distance Query (code listing),

EXPLAIN Output from SELECT Statement in

finduser2.php (code listing), 225

■F

FastTrack UML 2.0 (Apress, 2004), 8, 21

FEDERATED storage engine, 177–178

Feist, Dietrich, 503

FETCH statements, 413

fields

character fields and string data, 181

internal in MySQL, 437

FILE privilege, controlling, 550

files

configuration files, location of, 485–486

configuration smack files, 204–211

dictionary configuration section,

first client configuration section,

207–208

204–205

main section, 210–211

query configuration section, 209

second client configuration section, 210

table configuration section, 205–207

defined, 155

encrypted file systems, 548

file configuration options, and clustering,

636–639

InnoDB file layout, 166–167

lexical generation and parsing

implementation files, 138

log files

clustering and, 643–644

securing, 547

MyISAM storage engine file layout,

155–156

options files, defined, 485

replication and

master.info file, 595–596

relay-log.info file, 596–597

security, and access to, 547–548

socket files, protecting, 547

.TRG file, 447

finduser1.php (code listing), 213–214

finduser3.php (code listing), 231–232

firewalls, adding, 548

first client configuration section, Super

Smack, 204–205

fixed record formats, MyISAM, 156

flow constructs, 389

flow controls

SQL 2003 standard, 363

triggers and

flow control statements, 456

IF. . .THEN. . .ELSE flow control syntax,

FLUSH LOGS SQL statement, 581

flushing data, defined, 74

for loops, and binary searches, 50

FOR UPDATE, 99

FORCE INDEX hints, 277

foreign key constraints

InnoDB and

creating tables with, 164

for enforcing, 179

InnoDB storage engine and, 10

MyISAM and, 163

in transaction processing, 72

foreign keys

enforcement, InnoDB, 164–165

triggers and, 445

formats, MyISAM

compressed record, 158–159

dynamic record, 157–158

fixed record, 159

fragmentation, minimizing, MyISAM, 158

“The Full-Text Stuff That We Didn’t Put in the

Manual” by Peter Gulutzan, 163

FULLTEXT layouts

indexes, 61–62

MyISAM, 162–163

(API)

handler API, 118–121

subsystems and, 112

function application programming interface


■I N D E X

function libraries

described, 114

implementation through, 115–116

Function to Calculate Rush Shipping Charges

Function to Calculate Shipping (code listing),

(code listing), 396

395–396

Function to Calculate Tax (code listing), 395

Function to Calculate Total Cost

(code listing), 397

functional business requirements, 6–7

functions, 375–403

in access control subsystem, 132

COUNT( ) function, 246, 319

creating, 382–394

BEGIN and END statements, 386

CASE statements, 390

characteristics, 385

conditions and handlers, 388

DECLARE statements, 387

example (customer order), 382–383

flow constructs, 389

IF statements, 389

input parameters, 384

ITERATE statements, 392

LOOP and LEAVE statements, 391–392

naming functions, 383–384

REPEAT statements, 393–394

return values, 384

variables, 387–388

WHILE statements, 393

Data Encryption Standard (DES)

functions, 552

executing (examples), 394–398

function permissions, 401

IFNULL( ) function, 248

managing, 398–401

multi_key_cache_search( ) function, 123

MYSQL functions, 380–381

overview of, 375

performance of, 402–403

REGEXP function, 213

REPEAT function, 321

sending and receiving network packets

functions, 131

statement execution unit, 139

stored functions vs. stored procedures,

sub_select( ) function, 148

SUM( ) SQL function, 246, 319

time( ) function, 611

vs. triggers, 380

usefulness of, 376

user-defined and native functions, 381

vs. views, 378–380

fuzzy checkpointers, 173

■G

\G switch, and mysql client utility, 263

gen-data

gen-data-f option formatting tokens,

205–206

test sets, populating with, 206–207

general query log

profiling and, 227–229

troubleshooting and, 648–649

generalization, defined, 19

geographic coordinate data, 328–343

distance calculation formula, 329–331

distances between two points, 331–334

zip codes within radius, determining,

334–343

Geographic Information System (GIS),

defined, 328

global isolation levels, 98

global privileges

global privilege scope, 499–501

overriding of other privileges, 526

global variables, 387

grant management. See access and grant

management subsystem

GRANT OPTION privilege, 506

GRANT statement, 501

GRANT syntax, 549

grant tables

basics of, 497

in-memory grant tables, 519

querying, 508–509

updgrading MySQL and, 499

granularity of locks, 88–89

greater-than or equal-to operator (>=), 344

GROUP BY Clause, Using to Create a View

GROUP BY, Using to Get Unique URL Records

(code listing), 429

(code listing), 306

groups

configuration groups, 486–487

mysql groups, using, 540

Gulutzan, Peter, 163

■H

handler Class Definition (Abridged)

(code listing), 119–120

handler statements

Condition and Handler, Declaring (code

listing), 362–363, 388

creating cursors and, 411–412

handlers

database functions, creating and, 388

DECLARE statements and, 360–363

/sql/handler.h handler::ha_rnd_init( )

(code listing), 150


■I N D E X

Hassell, Jonathan, 547

HAVING, Using with GROUP BY to Create a

indexes, 39–67

handlers (continued)

storage engine abstraction subsystem

and, 117–121

handler API, 118–121

key classes and files for handlers, 118

stored procedures and, 360–363

handles, defined, 116

hard disks, and data storage, 40–41

Hardening Linux (Apress, 2005), 547

Hardening Windows (Apress, 2004), 547

hardware

remote hardware, protecting, 546

replication and, 612

hash layouts, indexes, 60–61

hash function, defined, 60

hash tables, defined, 60

View (code listing), 429

headers, defined, 43

heap table cache, 128

hierarchical data, 311–326

nested set model, 313–315

nodes and

finding above specific nodes, 317–318

finding depth of, 311–313

finding under specific parents, 317

inserting into trees, 322–324

removing from trees, 324–326

overview of, 311–313

storage of, 9

summarizing across trees, 318–322

host

can’t connect to host errors, 655

host connections, restricting, 548

host values, defined, 511

host Grant table, 515–516

hosting, off-site, and physical security, 546

hostname cache, 127

Hruby, Pavel, 23

httperf, 216–217

Huffman trees (or encoding)

basics of, 62–64

MyISAM and, 159

human-readable traces, and profilers, 217

■I

I/O Thread, Starting (code listing), 610

ibbackup (InnoDB Hot Backup)

basics of, 574–576

working with InnoDB data files and, 574

ibdata1 file, 573

IDENTIFIED BY clause, 516

IF statements

creating database functions and, 389

DECLARE statements and (stored

procedures), 363

IFNULL( ) function, 246, 248

IGNORE INDEX hint, 277–280

Illegal Update of a View with Check Options

(code listing), 432–433

implicit commit transaction processing

commands, 81

in-memory grant tables, 518–519

IN operator, 270

IN parameters, stored procedures, 357

inconsistent reads, defined, 91

index access type, 272–273

indexed sequential access method (ISAM),

52. See also MyISAM storage engine

choices, MyISAM storage engine, 161–163

compression, 62–64

data access and indexes, 44–55. See also

retrieval of data methods

computational complexity, 44–46

data, clustered vs. non-clustered, 55–57

data storage, 40–43

data pages, 42–43

hard disks and, 40–41

memory and, 40–41

volatile, 40–41

general strategies, 64–66

Index, Adding a Non-Unique to Speed Up

Queries (code listing), 305

(code listing), 271

index blocks, defined, 155

Index Merge optimization, 301

index operations, 52–55

memory, 54

number of operations, 52

record data changes, 55

scan vs. seek, 53

selectivity, 53–54

storage space for data pages, 54–55

index optimization and replication of

data, 591–592

layouts, 57–62

B-tree layouts, 57–59

FULLTEXT layouts, 61–62

hash layouts, 60–61

R-tree layouts, 59

secondary indexes, defined, 56

selectivity numbers on, 694–697

views and, 440

index_merge access type, 267

index_subquery access type, 268–269

info files, and replication, 595–597

High Performance MySQL (O’Reilly, 2004),

Index, Adding on CustomerOrder


■I N D E X

INFORMATION_SCHEMA interface

benefits of, 670–671

described, 669

viewing triggers and, 461–462

views, 671–694

InnoDB storage engine, 164–173

ACID-compliant multistatement

transaction control, 166

checkpointing and recovery processes,

172–173

INFORMATION_SCHEMA.CHARACTER_

SETS view, 687–688

data page organization, 167–170

doublewrite buffer and log format,

INFORMATION_SCHEMA.COLLATION_

170–172

CHARACTER_SET_APPLICABILITY

view, 689–690

INFORMATION_SCHEMA.COLLATIONS

file and directory layout, 166–167

foreign key constraints and, 10

foreign key relationships, enforcement

INFORMATION_SCHEMA.COLUMNS

view, 688–689

view, 678–680

of, 164–165

internal buffers, 170

row-level locking, 165

INFORMATION_SCHEMA.KEY_

COLUMN_USAGE view, 680–682

INFORMATION_SCHEMA.ROUTINES

view, 684–686

INOUT parameters, stored procedures, 357

input

algorithm input, defined, 44

input parameters, and database functions,

INFORMATION_SCHEMA.SCHEMA_

PRIVILEGES view, 690–691

INFORMATION_SCHEMA.SCHEMATA

insensitive cursors, defined, 407

INSERT operations, 101

installation of MySQL, 469–485

INFORMATION_SCHEMA.STATISTICS

development source tree, 477–483

view, 673

view, 682–684

INFORMATION_SCHEMA.TABLE_

CONSTRAINTS view, 676–677

INFORMATION_SCHEMA.TABLE_

PRIVILEGES view, 692–693

INFORMATION_SCHEMA.TABLES

view, 674–676

INFORMATION_SCHEMA.USER_

PRIVILEGES view, 691–692

686–687

overview of, 671–672

inline tables, 184

inline views, 293–297

inner joins

Inner Join Fails to Get All Categories

(code listing), 247–248

Inner Join, First Report Attempt with

(code listing), 244–245

Inner Join, Listing 7-48 Rewritten as

(code listing), 287–288

MySQL, 242–244

INNER keyword, 237–238

innobackup, 576–577

InnoDB

controlled environments and, 36

creating backups of InnoDB files, 573–577

innobackup, using, 576–577

InnoDB Hot Backup (ibbackup),

manually backing up and restoring,

574–576

573–574

default isolation mode, 92

installing from development source tree

on Unix, 481–483

LDPATH, finding libraries with, 481

source tarball, manually installing on

Unix, 477–481

existing installations, 470

Installation Wizard, 475

introduction to, 469

multiple database servers, running on

MySQL cluster, installing, 627

post-installation setup, 484–485

prebuilt binaries, installing, 470–476

build types, 472

directory structure, MySQL, 471

Mac OS X packages, 476

manual installation, 473–474

operating systems, supported, 471–472

RPM package files, 475–476

Windows installer, 475

starting and stopping MySQL, 483–484

uninstalling, 494–495

upgrading, 493–494

interface designers, and team roles, 12

interface prototypes, caution on, 12

internal buffers, InnoDB, 170

IO CACHE structure, 121–122

IP addresses, for connection control, 548

IS NULL, Listing 7-52 Rewritten Using

(code listing), 290

ISAM (indexed sequential access method),

52. See also MyISAM storage engine

INFORMATION_SCHEMA.VIEWS view,

single machines, 495–496


■I N D E X

isolation

basics of, 75

isolation and concurrency, implementing,

88–101. See also locking, locking and

isolation levels, examples

isolation levels, 90–92

locking resources, 88–90

ITERATE statements

creating database functions and, 392

DECLARE statements and, stored

procedures, 365

■J

join buffer cache, 128

joins, 238–262. See also outer joins

cross joins, 253–254

inner joins, 242–244

join hints, 274–280

IGNORE INDEX hint, 277–280

STRAIGHT_JOIN hint, 274–277

USE INDEX and FORCE INDEX hints,

natural joins, 260–261

sample schema overview, 238–242

self joins, 248

UNION joins, 254–260

USING keyword, 261–262

■K

key buffer system, MyISAM, 162

key cache

basics of, 122–125

MyISAM, 161

key classes, and files for handlers, 118

key selectivity, and benchmarking, 196

key_buffer_size configuration variable, 123

keys. See also clustering, clustering keys;

foreign key constraints

MySQL outer joins and

aggregating data when not all are

present, 244–247

non-existent keys, finding in

relationships, 249–250

valid NULL column keys, 247–249

keywords

CASCADING keyword, 432–433

INNER keyword, 237–238

ON keyword of the GRANT statement, 501

LOCAL keyword, 432

NEW keyword, 446

OLD keyword, 446

REFERENCING keyword, 453, 456

RETURNS keyword, 384

SONAME keyword and, 381

UNION ALL keywords, 258

USING keyword, 261–262

■L

LAMP-based applications, 10

LANGUAGE characteristic, and stored

LAST Statement in Binary Log (code listing),

functions, 385

Last_Error message, 608–609

layouts. See indexes, layouts

LDPATH, finding libraries with, 481

LEAVE and LOOP statements

creating database functions and, 391–392

DECLARE statements and, 364–365

LEFT JOIN

coding and, 237

LEFT JOIN and IS NULL, Listing 7-52

Rewritten Using  (code listing), 290

lexical generation and parsing

implementation files, 138

libraries. See also function libraries

OpenSSL libraries, 550

licensing, for MySQL products, 34

LIMIT clause, 257

LIMIT statements, 428

Limiting the Increase in discount_percent

(code listing), 460

Linux

Hardening Linux (Apress, 2005), 547

Sample Excerpt from RUN-mysql-

Linux_2.6.10_1.766_FC3_i686

(code listing), 200

listings. See code listings (by chapter)

Live my.cnf for ibbackup, Sample Options

from (code listing), 574

load

database load and replication speed, 612

load generators, 192

load limits, determining with

benchmarking, 191–192

LOAD DATA FROM MASTER command, 599

Loading the New Radian Values

(code listing), 330–331

LOCAL keyword, 432

local variables, 387

Location Table Definition (code listing), 300

LOCK IN SHARE MODE command clause,

Lock Tables and Find Binary Log Position

example, 99

(code listing), 599

locking

lock granularity, 88–89

locking and isolation levels, examples,

92–100

autocommit and concurrent

transactions, 93–94

deadlocks, transactions, 99–100

isolation level effects, 94–98


■I N D E X

FOR UPDATE and LOCK IN SHARE

MODE command clauses, 94–98

locking resources, 88–90

locking tables, and triggers, 450

row-level locks, InnoDB, 165

security and

locking down network access, 542

locking up server, 541–542

table-level locks, MyISAM storage engine,

160–161

log buffer, InnoDB, 170

Log, Entries in for Initial Startup

(code listing), 647

Log, Entries in for Shutdown (code listing), 647

Log, Entries in for Startup (code listing), 646

log management subsystem, 133–135

log serial number (LSN), InnoDB, 172

log-slave-updates option, 615

logging. See also logs

basics of, 82–83

InnoDB log format, 170–172

log files

contained in clusters, 643–644

Log File, Applying to Data Files

(code listing), 575–576

Log Files, Applying to InnoDB Data Files

(code listing), 577

securing, 547

log-slave-updates option, 615

logging configuration options, 490

MyISAM for, 178

logical data representation, 42–43

logical model, 16

logical state, of databases, 74

login

Running login_archive( ) (code listing),

414–415

416–417

logs. See also logging

binary logs for up-to-date tables, 581–582

profiling and

general query log, 227–229

slow query log, 225–227

replication and

binary log (binlog), 592–593

relay log, 594

relay-log.info file, 596–597

troubleshooting and

error logs, 646–648

general query log, 648–649

slow query log, 650

lookups, of record data, 51, 52

LOOP statements

LOOP and LEAVE statements

creating database functions and,

391–392

DECLARE statements and, 364–365

LOOP Statement with ITERATE

(code listing), 392–393

LOOP Statement with LEAVE (code listing),

Loop with ITERATE Statement (code listing),

365, 391–392

LSN (log serial number), InnoDB, 172

■M

M:N relational connectivity, 26

Mac OS X packages

installing MySQL and, 476

startup and shutdown, 484

<machine>-bin.index, 597

machine-readable traces, 217

mailing lists, for MySQL support, 668

Main Execution Object in select-key.smack

(code listing), 210–211

main section, Super Smack, 210–211

management client, and clustering, 640–641

management nodes

basics of, 621

Sample Management Node Configuration

(code listing), 628

many-to-many relational connectivity, 26

mapping permissions, 538–539

master database, defined, 587

master.info file, 595–596, 601

max binary package, 627

max build type, 472

memory

index operations and, 54

MEMORY storage engine, 175–176

MEMORY Table, Making it Use a B-Tree

nodes and, 624

RAM, and data storage, 41

required

Required Memory, Calculating, Formula

for (code listing), 624

Required Memory, Example of

Calculation of (code listing), 624

MERGE algorithm, 440

merge or multimaster replication

defined, 587

merge vs. one-way replication, 588–589

MERGE storage engine, 173–175

MERGE table

MERGE Table, Aggregated Results from

(code listing), 175

MERGE Table, Creating from Monthly Log

Tables (code listing), 174–175

MERGE Table, Creating from Two Identical

Tables (code listing), 173–174

login_archived( ) Procedure (code listing),

Index (code listing), 176


■I N D E X

merging

metadata

algorithms, 424–425

of customers, example, 71

defined, 669

Inserting a New Node and Updating the

Metadata (code listing), 322–323

mutexes

Metadata Status, Checking (code listing),

using SELECT statements to retrieve,

mybackup.cnf for ibbackup, Sample Options

multiplicity, defined, 18

multistatement stored procedures, creating,

multithreaded environments, defined, 115

multiversion concurrency control (MVCC),

355–356

100–101

defined, 116

described, 90

from (code listing), 575

MyBench, 212

my_b_read Macro (code listing), 122

my.cnf file

my.cnf File, Sample for mysql_multi

(code listing), 495

my.cnf, Sample File with Groups

(code listing), 487

storage node configuration and, 639

.MYI file structure, 159–160

MyISAM Simple web Traffic Log Table

(code listing), 174

MyISAM storage engine, 154–163

file and directory layout, 155–156

index choices, 161–163

limitations of, 163

logical data representation and, 42

.MYI file structure, 159–160

/myisam/mi_scan.c mi_scan( )

(code listing), 151

/myisam/mi_scan_init( ) (code listing), 150

mysqlhotcopy and backup, 569

record formats, 156–159

/sql/ha_myisam.cc ha_myisam::rnd_init( )

(code listing), 150

table-level locking, 160–161

tables, backing up, 573

myisampack utility

log compression and, 174

tables and, 159

advantages of, 33–35

binary log (binlog), 87

client, and calling stored procedures,

366–367

cursors in, 407–408

data dictionary. See data dictionary

functions, 380–381

inconsistent data and, 10

joins, 238–262. See also outer joins

inner joins, 242–244

sample schema overview, 238–242

licensing for, 34

MySQL AB, 35

mysql client utility, and \G switch, 263

mysql groups, 540

670–671

methods, identifying class methods, 15

Microsoft

SQL Server

introduction to, 32

isolation mode of, 92

triggers and, 446

Visio, 23

Windows

configuration files, 486

Hardening Windows (Apress, 2004), 547

startup and shutdown, 483

Windows Essential download, 475

Windows installer, for installing MySQL,

minimalist node arrangement, 622–623

modeling approaches, 15–30

E-R diagramming, 25–27

E-R diagramming tools, 27–30

access for E-R diagramming, 27

AllFusion ERwin Data Modeler, 28–29

DBDesigner4, 29–30

UML, 16–21

class diagrams, 17–20

deployment diagrams, 20–21

UML modeling software, 21–25

AllFusion Component Modeler, 22

ArgoUML, 24–25

SmartDraw7 Technical Edition, 24

Visio, 23

requirements. See also modeling

approaches

textual object models, 13–15

monitoring variables, 127

Mosberger, David, 216

Moving MySQL to Backup-Up Data Files

(code listing), 576

multi_key_cache_search( ) function, 123

multiple variables, and stored procedures,

multiple database servers, running on single

machines, 495–496

multiple fields, indexing, 65

Multiple Inner Join, Example (code listing),

243–244

models and concepts of business

MySQL. See also configuration of MySQL


■I N D E X

OR conditions prior to MySQL 5.0,

with (code listing), 570

MYSQL Query Browser, 372

MySQL versions 5.0.4 and 5.0.x, and

cursors, 406

300–303

stored procedures in. See also stored

procedures

basics of, 353–354

handlers and, 361–362

subsystem organization, 112–113

support options, 668

triggers in. See also triggers

basics of, 446–448

MySQL 5.0.6 and 5.0.x and, 463–465

upgrading, and grant tables, 499

views in, 421–422. See also views

MySQL Administrator

backup utility, 577–581

making backups with, 578–580

restoring with, 580–581

running remotely, 543

user administration and, 519–529

connecting to server, 520–521

new user accounts, adding, 524–526

removing accounts, 528–529

user administration, navigating,

user privileges, viewing and editing,

521–523

526–528

mysqladmin

mysqladmin version, Output from

(code listing), 662

processlist script, 651

version command, 662

mysqlbinlog Output, Limiting (code listing),

mysqlbinlog tool, 582

mysqld

options in management server

configuration file, 637

/sql/mysqld.cc main( ) (code listing), 141

mysqldump, 561–569

backing up with, 561–567

clusters and, 642

common options, 562–567

example of backup and restore, 567–569

example using, 559–560

restoring with, 567

for snapshots, 598–599

mysqldumpslow

command-line options, 227

Output from mysqldumpslow

(code listing), 226

mysqlhotcopy, 569–573

backing up with, 569–572

mysqlhotcopy, Output from (code listing),

mysqlhotcopy, Simple Backup with

(code listing), 570

mysqlhotcopy, Using a Regular Expression

mysqlhotcopy, Creating a New Database

with (code listing), 571

replication and, 599

restoring with, 572–573

mysqli extensions, 367–368

MYSQL_LOG Class Definition (code listing),

133–134

mysql.proc Table, Output of SELECT from

(code listing), 370–371

mysqlsnapshot tool

described, 556

replication and, 599

mysql.sock file, 547, 652

mysql.tables_priv system table, 693

Mytop script, 229

■N

Nagios, 652

NAME parameter, and views, 425

namespaces, trigger namespace, 447

naming

functions, 383–384

naming conventions, databases, 30–31

stored procedures

basics of, 357

naming variables in, 360

triggers, 453–454

view names, 425–426

native functions, adding, 381

natural joins, 260–261

nbd_mgm daemon, 636

NDB Cluster storage engine

backing up and, 560

basics of, 178

controlled environments and, 36

described, 617

as storage engine, 619

ndbd daemon

cluster processes and, 635

options, 638–639

ndb_mgm client commands, 640–641

ndb_mgmd daemon

cluster processes and, 634–635

options, 638

nested set model, 312, 313–315

network management and communication

subsystem, 128–131

network packets, 131

networks

disabling networking, 540

locking down network access, 542

network traffic, securing, 541

replication speed and, 612

security of, 548–549


■I N D E X

NEW keyword, 446

nodes

clustering and

arrangement of, 621–623

basics of, 620–621

calculating number of, 624

defined, 620

finding above specific nodes, 317–318

finding depth of, 311–313

finding under specific parents, 317

inserting into trees, 322–324

Node, Finding the Level of in the Tree

(code listing), 315–316

node log files, 643

removing from trees, 324–326

SELECT Data from the Other SQL Node

(code listing), 632

summarizing across trees and, 318–319

non-clustered index organization, 55–57

non-persistent connections, and Super

Smack, 211

nonrepeatable reads, defined, 91

[NOT] DETERMINISTIC characteristic, 385

NOT EXISTS expressions, 288–293

NOT EXISTS Subquery, Example

(code listing), 289–290

NULL

use of, 186

valid NULL column keys, 247–249

■O

“O” notation, 44–46

object modeling, defined, 15

off-site hosting, and physical security, 546

OLAP Analysis Services (SQL Server), 32

OLD keyword, 446

ON clause, 250–253

ON keyword, of the GRANT statement, 501

one-to-many relational connectivity, 26

one-to-one relational connectivity, 26

one-way encryption, 551–552

one-way vs. merge replication, 588–589

OPEN statements, 412

OpenSSL libraries, 550

operating systems

MySQL, adding to startup, 485

process list, 652

security of, 547

supported by prebuilt binaries, 471–472

operators

IN Operator (code listing), 270

BETWEEN operator, 269–270

>= operator, and running sums, 344

optimization. See also system architecture,

query execution exercise

of query engine, 138

Optimizer component, 111

options files, defined, 485

OR conditions

prior to MySQL 5.0, 300–303

Using a Derived Table for an OR Condition

(code listing), 303

OR statements, and UNION query, 344–346

Oracle

isolation mode of, 92

overview of, 33

ORDER BY clause

ORDER BY, Adding to the Joined Table View

(code listing), 428–429

UNION statements and, 257

views and, 428

orphaned records

defined, 9–10

identifying and removing, 303, 307–311

OUT parameters, 357, 366–367

outer joins, 244–253

ON clause and, 250–253

IFNULL( ) function and, 246, 248

keys and

aggregating data when not all are

present, 244–247

non-existent keys, finding in

relationships, 249–250

valid NULL column keys, 247–249

relevant code listings

Listing 7-43 Rewritten as Outer Join

(code listing), 284–285

Outer Join Example (code listing), 250

Outer Joins, Identifying Orphaned

Records with (code listing), 309

overflow pointers, defined, 157

overoptimizing application code, 218

■P

Pachev, Sasha, 201

package encapsulation, defined, 351

packet length too big messages, 659–660

pages

data storage and, 42–43

page directories, and master list of data

pages, 167

page-level locks, 89

parameters

for benchmarking test scripts, 199–201

connection parameters, default, 513

creating database functions and input

IN, OUT, INOUT and stored procedures,

NAME parameter and views, 425

setting for stored procedures, 357

parent nodes, finding, 317–318

Example of the range Access Type with the

parameters, 384


■I N D E X

parents

finding nodes under specific parents, 317

parent-child relationship example, 164

parent tables, creating, 164

parsing. See also query parsing, optimization,

and execution subsystem

basics of, 136

passwords

requiring, 549

root user passwords, setting, 540

path enumeration model, 313

performance

benchmarking and

comparison of performance, 191

setting standards, 193–194

clustering, and nodes, 624

of triggers, 463–465

of views, 440–442

permissions

data file permissions, checking, 540

function permissions, 401

mapping, 538–539

stored procedures and, 372–373

triggers and, 463

troubleshooting, 657

views and, 440

persistent connections, and Super Smack,

persistent data storage, 40–41

phantom reads, defined, 91

PHP applications

Advanced PHP Programming

(Sams Publishing, 2004), 234

basics of, 216

calling procedures from, 367–368

PHP debugger, 229–234

profiling with APD, 231–233

relevant code listings

Calling a Stored Procedure from PHP,

367–368

Calling a Stored Procedure with

Parameters from PHP, 368

EXPLAIN for finduser1.php

(code listing), 223

EXPLAIN Output from SELECT

Statement in finduser2.php

(code listing), 225

finduser1.php, 213–214

finduser3.php, 231–232

Inefficient PHP Code to Find Customers

Without Orders, 249–250

Running ApacheBench and the Output

Results for finduser1.php, 214–215

physical model, 16

physical state, databases, 74

PostgreSQL

isolation mode of, 92

overview of, 33

pprofp command-line options, 232

prebuilt binaries, for installing MySQL,

470–476

build types, 472

directory structure, 471

Mac OS X packages, 476

manual installation, 473–474

operating systems, supported, 471–472

RPM package files, 475–476

Windows installer, 475

private scope, defined, 18

privilege cache, 127–128

privileges

access control and privilege verification,

510–516

authenticating users, 511–513

connection parameters, default, 513

host Grant table, 515–516

overview of, 510

verifying user privileges, 513–515

account privileges, controlling, 549

basics of, 497–509

controlling

FILE privilege, 550

PROCESS privilege, 550

SUPER privilege, 550

editing user privileges, 526–528

function permissions and, 401

granting all, 507

granting and revoking, 498

scope levels, 498–506

basics of, 498–499

column privilege scope, 504–505

database privilege scope, 501–503

global privilege scope, 499–501

GRANT OPTION privilege, 506

routine privilege scope, 505–506

table privilege scope, 504

temporary tables, permissions for, 503

USAGE privilege, 517–518

user privileges, 507–509, 513–515, 526–528

problem domains, 5–6

problems. See also errors; troubleshooting

finding potential with benchmarking,

Output from a Stored Procedure Called

192–193

in PHP, 367–368

Results for finduser2.php (REGEXP),

proc table, 354

PROCEDURE ANALYSE( ), Using to Find Data

215–216

Type Suggestions (code listing),

186–187


■I N D E X

Product IDs Purchased More Than Once,

508–509

Getting (code listing), 292

Revised Query to Use a Single Derived

processes

access to, and security, 547–548

process-based design, vs. thread-based

design, 114

process, defined, 114

process list, 652

PROCESS privilege, controlling, 550

process, thread, and resource

management, 114–117

Profiler tool (SQL Server), 32

profiling

vs. benchmarking, 190

defined, 190

guidelines, 218

overview of, 189

profiler, defined, 217

profilers vs. diagnostic techniques, 217

tools, 219–234. See also Zend advanced

PHP debugger extension

EXPLAIN command, 223–225

general query log, 227–229

Mytop script, 229

SHOW FULL PROCESSLIST command,

219–222

SHOW STATUS command, 222–223

slow query log, 225–227

uses for, 217–218

programming terms, C and C++, 108

programs

monitoring, and troubleshooting, 652

turning off for benchmark tests, 197

project boundary, 7

project managers, and team roles, 12–13

prototyping, 12

public scope, defined, 18

■Q

queries

EXPLAIN command, using on query of

views, 442

grant tables, querying, 508–509

query abstraction, and views, 420

query engine optimization, 138

query execution exercise. See system

architecture, query execution

exercise

query profiling and EXPLAIN command,

query structuring, 66

relevant code listings

Example of a Derived Table Query, 294

Excerpt from the General Query Log,

228–229

General Query Log Entries, 648–649

No Usable Index, Even with a range Type

Query, 270–271

Queries, Combining Two for a Distance

to Store Report, 343

Query_cache_block Struct Definition

Querying the columns_priv Grant Table

(Abridged), 140

Directly, 509

Querying the user Grant Table Directly,

Table, 338–339

Simple Calculation Directly in Query,

UNION Query Merging Two Previous

Resultsets, 256–257

SELECT COUNT(*) queries, MyISAM, 178

troubleshooting and

general query log, 648–649

slow query log, 650

Query Analyzer, SQL Server, 32

query barrels, defined, 201

Query Browser, MySQL, 372

query cache

basics of, 139–140

turning off, 197

query configuration section, Super Smack,

query parsing, optimization, and execution

subsystem, 135–139

execution, 139

optimization, 138

parsing, 136–138

■R

R-tree layouts, indexes

basics of, 59

MyISAM, 162

radians, and distance calculation, 329, 330

RAM, and data storage, 41

range access type, 269–272

reactive attitudes, 195

READ COMMITTED isolation level, 90–91

read cursors, defined, 407

read locks

READ LOCAL locks, MyISAM, 160

READ locks, MyISAM, 161

shared, 89

READ UNCOMMITTED isolation level, 90

READ_RECORD struct, 148

realistic load generators, 192

record cache, 121–122

records

composition of, 47

finding within zip radius, 336–337

InnoDB record structure, 169


■I N D E X

Identifying Orphaned Records with an

advantages of replicating, 589–591

MyISAM

compressed record format, 158–159

dynamic record format, 157–158

fixed record formats, 159

orphaned records

defined, 9–10

identifying and removing, 303, 307–311

random records, retrieving, 326–328

record cache, 121–122

record data

changes, 55

lookups, 51, 52

record formats

InnoDB, 168–169

MyISAM storage engine, 156–159

record size, and replication speed, 612

REDO log records, 84, 86

relevant code listings

Creating a New Table with the Unique

Records, 306–307

Outer Join, 309

Mismatched Reports Due to a Missing

Parent Record, 308–309

Multitable DELETE Statement to

Remove Orphaned Records, 310

Non-Correlated Subquery to Find

StoreLocation Records Within Zip

Radius, 336–337

Record Counts After Calling

archive_login( ), 417

Record Counts Before Calling

archive_login( ), 416

Records in customer Table, 422, 448

Records in the customer Table After

Records in the customer_region3 View,

Updating, 450

434–435

Records in the Formerly Failing Node, 634

Returning a Single Random Banner

Record, 327

Returning a Single Random Record from

a Larger Table, 328

Using GROUP BY to Get Unique URL

Records, 306

Verifying That the Delete Statement

Removed the Orphaned Records, 310

recovery processes

InnoDB, 172–173

REDO log records and, 86

transaction processing and, 84

UNDO log records and, 86

REDO log records

basics of, 84

recovery process and, 86

ref access type, 265

REFERENCING keyword, 453, 456

ref_or_null access type, 266–267

REGEXP function, 213

relay log, and replication, 594

relay-log.info file, and replication, 596–597

remote hardware, protecting, 546

removing

Removing a Node (code listing), 325

triggers, 462–463

views, 439

REPEAT function, 321

REPEAT statements

creating cursors and, 412

creating database functions and, 393–394

DECLARE statements and, 366

REPEAT Statement (code listing), 366, 393

REPEATABLE READ isolation level, 91

replicated databases, and backup

requirements, 558

replication, 585–616

application performance, 589

geographic diversity, 590

limited connectivity, 590

redundancy and backup, 590

storage engine and index optimization,

591–592

configuration options, 492, 601–605

core options, 601–602

determining what to replicate, 605

startup replication options, 602–605

disadvantages of, 591

examples, 613–616

daisy chain of replicated machines,

614–615

multiple slaves, 613–614

simple replication, 613

fundamentals of, 585–586

implementation of, 592–597

binary log, 592–593

info files, 594

master.info file, 595–596

process of replication, 594

relay log, 594

relay-log.info file, 596–597

initial setup, 597–600

adjusting configuration, 597–598

replication account, creating, 598

schema and data snapshot, 598–600

start replication, 600

monitoring and managing, 606–611

CHANGE MASTER command, 609–610

RESET SLAVE statement, 611

SHOW MASTER STATUS statement, 606

SHOW SLAVE HOSTS command,

606–607


■I N D E X

replication(continued)

SHOW SLAVE STATUS command,

607–609

START SLAVE command, 610

STOP SLAVE statement, 610–611

one-way vs. merge, 588–589

planning for, 591–592

replication performance, 611–612

synchronous vs. asynchronous, 587–588

terminology of, 586–587

RESET MASTER command, 581

RESET SLAVE statement, 611

response times, and performance standards,

restarts, unexpected, troubleshooting,

665–666

restoration. See also backup and restoration

Restoring a Single Table (code listing), 569

Restoring MyISAM Data Files with a

Wildcard Character (code listing),

using replication for, 590

retrieval of data methods, 46–52

basics of, 46–49

binary search, 49–51

index sequential access method, 52

Retrieving a Node and All Its Children

(code listing), 317

Retrieving All Sports Gear Categories and

Subcategory IDs (code listing),

318–319

Retrieving Total Sales for Each Product

(code listing), 344

return values, and creating database

functions, 384

RETURNS keyword, 384

RIGHT JOIN, and consistent coding, 237

robust node arrangement, 622, 623

ROLLBACK command, 77

rollback, defined, 77

rollups, defined, 319

root user passwords, setting, 540

routine privilege scope, 505–506

routines, 381

row and tabular subqueries, 293

rows

number of, and benchmarking, 196–197

row-level locks

described, 89

InnoDB, 164, 165

RPM package files, and installation, 475–476

run-all-tests script, 199

Russell, Chad, 9, 179

■S

SANS Institute, security of, 537

scalability, 11

scalar subqueries, 280–285

scan operations

data retrieval and, 42

index operations and, 53

Schlossnagle, George, 234

scope creep, defined, 5

scope, defined, 498

scope levels, 498–506

basics of, 498–499

column privilege scope, 504–505

database privilege scope, 501–503

global privilege scope, 499–501

GRANT OPTION privilege, 506

routine privilege scope, 505–506

table privilege scope, 504

temporary tables, permissions for, 503

Scott, Kendall, 8, 21

scripts

crash-me script, 198

parameters for benchmarking test scripts,

199–201

run-all-tests script, 199

Script, Creating for the Sample Schema

(code listing), 240–241

searching, binary, 49–51

second client configuration section, Super

Smack, 210

Seconds_Behind_Master column, 609

sections. See configuration smack files

Secure Sockets Layer (SSL)

server SSL configuration options, 493

SSL-encrypted client connections,

543–544

security, 533–554

of clustering, 644

plans and policies, developing, 536–539

documentation, maintaining, 538–539

incidents, using, 538

problems, reasons for, 534–535

securing whole systems, 545–553

access to files, directories, and

processes, 547–548

application access, 551

data storage and encryption, 551–553

network security, 548–549

operating system security, 547

servers, securing physical access to, 546

user access, controlling, 549–550

security quick list, 540–541

setting up, example, 541–545

controlling access to data, 542–543

locking down network access, 542

locking up server, 541–542

remote access, adding, 543–544

servers, adding, 544–545

threats, locating, 535

views and, 420


■I N D E X

seek vs. scan, and index operations, 53

segments, defined, 167

SELECT COUNT(*) queries, MyISAM, 178

SELECT statements

relevant code listings

SHOW INDEX command, 677, 684

SHOW MASTER STATUS Output

(code listing), 606

SHOW MASTER STATUS statement, 606

SHOW PROCEDURE STATUS command,

Output from SELECT Using Created

369–370

Functions, 398

Output from SELECT Using the

calculate_total( ) Function, 383

SELECT Statement Using Created

Functions, 397–398

SELECT Statement with Total

Calculated in Function, 379–380

SELECT Statement with Total

Calculated in SQL, 379

to retrieve metadata, 670–671

transaction requests and, 101

views and, 426–431

joining tables, 427–430

unioned tables, 430–431

selectivity, and index operations, 53–54

self joins, 248

semaphores, 90

SERIALIZABLE isolation level, 92

server-side cursors, 406

servers

adding, when setting up security, 544–545

connecting to with MySQL Administrator,

520–521

locking up, 541–542

securing physical access to, 546

server configuration options, 488–490

server statistical variables, 124–125

troubleshooting

server has gone away messages,

660–661

server not responding, 658–659

session variables, 387

SET data, and selection of data types, 184

shared locks, 89

shell accounts, controlling access to, 543

SHOW COLLATIONS command, 689

SHOW commands, vs.

INFORMATION_SCHEMA, 671

SHOW CREATE FUNCTION, Output from

(code listing), 400

SHOW CREATE PROCEDURE statement, 370

SHOW CREATE VIEW command, 436–437

SHOW DATABASES command, 673

SHOW FULL COLUMNS command, 680

SHOW FULL PROCESSLIST command,

219–222

SHOW FULL PROCESSLIST Results

(code listing), 221–222

SHOW FUNCTION STATUS, Output from

(code listing), 398–399

SHOW GRANTS statement, 507–508

SHOW PROCESSLIST command, 650, 651

SHOW SLAVE HOSTS command, 606–607

SHOW SLAVE HOSTS Output (code listing),

SHOW SLAVE STATUS command

master.info file and, 595

replication and, 607–609

SHOW SLAVE STATUS Output

(code listing), 607–608

SHOW STATUS Command Example

(code listing), 222–223

SHOW TABLE STATUS command, 55, 676

ShowIndexSelectivity.sql (code listing), 695

SHOWS GRANTS Output (code listing), 508

shutdown, troubleshooting

problems with, 664–665

server crashes, 662–663

shutdown log entries, 647

simple node arrangement, 621–622

single-statement stored procedures, creating,

354–355

skip-networking configuration, 540

slaves

log-slave-updates option, 615

multiple slaves and replication, 613–614

slave database, defined, 587

Slave for Replication with CHANGE

MASTER, Set up (code listing), 600

slave state descriptions, 608–609

Slave Tables from Master Snapshot,

Creating (code listing), 600

tests in a single-slave environment, 611

slots, record, 43

slow query log

profiling and, 225–227

Slow Query Log Entries (code listing), 650

troubleshooting and, 650

SmartDraw7 Technical Edition, 24

SME (subject matter expert), customer as, 4

snapshots

defined, 587

scheme and data, 598–600

sockets

software

socket connection errors, 653–654

socket files, protecting, 547

UML modeling software, 21–25

AllFusion Component Modeler, 22

ArgoUML, 24–25

SmartDraw7 Technical Edition, 24

Visio, 23


■I N D E X

software (continued)

web software, commercial development,

SQL nodes

35–36

SONAME keyword, 381

source code and documentation, 106–110

C and C++ programming terms, 108

Doxygen, 109

MySQL documentation, 109–110

TEXI and texi2html viewing, 110

top-level directories, 106–107

source tarball, installing on Unix, 477–481

source tree development for installation,

477–483

installing from development source tree

on Unix, 481–483

LDPATH, finding libraries with, 481

source tarball, manually installing on

Unix, 477–481

source_type variable, Super Smack, 208

spatial data, and selection of data types, 183

splitting, defined, 57

SQL, 235–297

code formatting, 236–237

coding, specific and consistent, 237–238

derived tables, 293–297

EXPLAIN and access types, 262–274

ALL access type, 274

const access type, 263

eq_ref access type, 264

index access type, 272–273

index_merge access type, 267

index_subquery access type, 268–269

overview of, 262

range access type, 269–272

ref access type, 265

ref_or_null access type, 266–267

unique_subquery access type, 267–268

join hints, 274–280

IGNORE INDEX hint, 277–280

STRAIGHT_JOIN hint, 274–277

USE INDEX and FORCE INDEX hints,

cross joins, 253–254

inner joins, 242–244

natural joins, 260–261

sample schema overview, 238–242

UNION joins, 254–260

USING keyword, 261–262

overview of, 235

SQL 2003 standard

DDL and, 358

described, 353

flow controls, 363

triggers and, 447, 453

UNDO handler type, 363

views and, 421

basics of, 620

configuration, 639

SQL Node, Sample Configuration for

(code listing), 630

Start the SQL Node of the Cluster

(code listing), 630

SQL SECURITY characteristics

creating stored functions and, 385

stored procedures and, 372

SQL Thread, Starting (code listing), 610

SQL Thread, Starting with the UNTIL

Clause (code listing), 610

SQLSTATE values, 362

subqueries, 280–293

columnar subqueries, 287–293

correlated subqueries, 286–287

row and tabular subqueries, 293

scalar subqueries, 280–285

Theta style vs. ANSI style, 236

SQL scenarios, 299–347

duplicate entries, identifying and

removing, 303–307

geographic coordinate data, calculating

distances with, 328–343

distance calculation formula, 329–331

distances between two points, 331–334

zip codes within a radius, 334–343

hierarchical data, 311–326

nested set model, 313–315

nodes, finding above specific nodes,

nodes, finding depth of, 311–313

nodes, finding under specific parents,

317–318

nodes, inserting into trees, 322–324

nodes, removing from trees, 324–326

overview of, 311–313

summarizing across trees, 318–322

OR conditions prior to MySQL 5.0,

300–303

orphaned records, identifying and

random records, retrieving, 326–328

running sums and averages, generating,

344–346

SQL Server

introduction to, 32

isolation mode of, 92

triggers and, 446

SSL (Secure Sockets Layer)

543–544

stakeholders

backup and, 557

customer as, 5

server SSL configuration options, 493

SSL-encrypted client connections,

MySQL joins, 238–262. See also outer joins

removing, 303


■I N D E X

standard build type, 472

START SLAVE command

core replication options and, 601

managing replication and, 610

startup

starting and stopping MySQL, 483–484

startup replication options for

configuration

troubleshooting

problems starting server, 663–664

startup log entries, server, 646–647

state model, 16

statement execution unit, 139

statements. See specific statements

static Huffman encoding, defined, 64

statistics, index

ANALYZE TABLE command and, 65

defined, 54

Stephens, Jon, 9, 179

st_net Struct Definition (code listing), 129

stop lists, defined, 516

STOP SLAVE statement, 610–611

stopping servers. See shutdown,

troubleshooting

storage engine abstraction subsystem,

117–121

handler API, 118–121

key classes and files for handlers, 118

storage engines and data types, 153–188

ARCHIVE storage engine, 176

CSV storage engine, 177

data type choices, 179–187

Boolean values, 184

general data type guidelines, 185–187

numeric data considerations, 179–180

SET and ENUM data considerations,

spatial data considerations, 183

storing data outside databases, 185

string data considerations, 181–182

temporal data considerations, 182–183

engine-specific configuration options, 491

EngineStorageSummary.sql (code listing),

697–698

178–179

FEDERATED storage engine, 177–178

guidelines for choosing storage engines,

index optimization and replication of

data, 591–592

InnoDB, 164–173

ACID-compliant multistatement

transaction control, 166

checkpointing and recovery processes,

data page organization, 167–170

doublewrite buffer and log format,

172–173

170–172

file and directory layout, 166–167

foreign key relationships, enforcement

of, 164–165

internal buffers, 170

row-level locking, 165

MEMORY storage engine, 175–176

MERGE storage engine, 173–175

MyISAM storage engine, 154–163

file and directory layout, 155–156

index choices, 161–163

limitations of, 163

.MYI file structure, 159–160

record formats, 156–159

table-level locking, 160–161

NDB Cluster storage engine

described, 178, 617

engine=NDBCLUSTER statement, 625

as storage engine, 619

overview of, 154

storage engine defined, 153

storage nodes, 620, 629

storage of data, 40–43

currency data, 179

data pages, 42–43

hard disks and, 40–41

image data, 185

memory and, 40–41

outside of databases, 185

persistent, 40–41

RAM and, 41

secondary storage, defined, 40

security and, 551–553

storage space for data pages, 54–55

volatile, 41–42

stored functions. See also functions

vs. stored procedures, 377

Stored Procedure, Output from Called in PHP

(code listing), 367–368

stored procedures, 349–373

advantages and disadvantages of, 350–352

building, 354–366. See also DECLARE

statements

BEGIN and END statements, 359

CREATE statement, 357–358

multistatement procedures, 355–356

naming procedures, 357

procedure body, 358

single-statement procedures, 354–355

fundamentals, 349–350

handler types and conditions, 361–362

managing, 369–372

altering and removing, 371

editing, 371–372

viewing, 369–371

missing statements in MySQL stored

procedures, 373

in MySQL, 353–354


■I N D E X

stored procedures (continued)

system architecture, 105–151

official standard, 353

opening cursors within, 412, 413

permissions, 372–373

SQL 2003 standard and

DDL and, 358

flow controls, 363

SQL 2003 standard described, 353

triggers and, 447, 453

UNDO handler type, 363

views and, 421

vs. stored functions, 377

using, 366–368

access and grant management subsystem,

131–133

caching and memory management

subsystem, 121–128

hostname cache, 127

key cache, 122–125

other caches, 128

privilege cache, 127–128

record cache, 121–122

table cache, 125–127

log management subsystem, 133–135

network management and

calling procedures from MySQL client,

communication subsystem, 128–131

366–367

calling procedures from PHP, 367–368

tips for, 352

overview of, 111–114

process, thread, and resource

management, 114–117

STRAIGHT_JOIN hint, 274–277

string data, 181–182

structs

defined, 107

READ_RECORD struct, 148

st_table Struct (Abridged) (code listing),

125–126

subject matter expert (SME), customer as, 4

subqueries, 280–293

columnar subqueries, 287–293

correlated subqueries, 286–287

row and tabular subqueries, 293

scalar subqueries, 280–285

sub_select( ) function, 148

subsystem, defined, 112

SUM( ) SQL function

outer joins and, 246

summarizing across trees and, 319

sums

generating, 344–346

Using a Derived Table to Sum, Then

Average Across Results (code listing),

SUPER privilege, 550

Super Smack, MySQL, 201–211

configuration smack files, 204–211

dictionary configuration section,

first client configuration section,

207–208

204–205

query cache, 139–140

query execution exercise (code listings),

140–151

/myisam/mi_scan.c mi_scan( ), 151

/myisam/mi_scan.c mi_scan_init( ), 150

/sql/ha_myisam.cc ha_myisam::rnd_

/sql/handler.h handler::ha_rnd_init( ),

/sql/mysqld.cc create_new_thread( ),

init( ), 150

142–143

/sql/mysqld.cc handle_connections_

sockets( ), 142

/sql/mysqld.cc main( ), 141

/sql/records.cc init_read_record ( ), 149

/sql/records.cc rr_sequential( ), 150–151

/sql/sql_parse.cc dispatch_command( ),

144–145

/sql/sql_parse.cc do_command( ), 144

/sql/sql_parse.cc handle_one_

connection( ), 143

/sql/sql_parse.cc mysql_execute_

command( ), 145–146

/sql/sql_parse.cc mysql_parse( ), 145

/sql/sql_select.cc do_select( ), 148

/sql/sql_select.cc handle_select( ),

/sql/sql_select.cc JOIN:exec( ), 147

/sql/sql_select.cc join_init_read_record( ),

146–147

main section, 210–211

query configuration section, 209

second client configuration section, 210

table configuration section, 205–207

/sql/sql_select.cc mysql_select( ), 147

/sql/sql_select.cc sub_select ( ), 148–149

query parsing, optimization, and

execution subsystem, 135–139

running, 202–203

superclasses, avoiding, 15

symbolic links, preventing, 548

synchronous vs. asynchronous replication,

587–588

execution, 139

optimization, 138

parsing, 136–138

source code and documentation, 106–110

C and C++ programming terms, 108


■I N D E X

Doxygen for source code analysis, 109

MySQL documentation, 109–110

TEXI and texi2html viewing, 110

top-level directories, 106–107

storage engine abstraction subsystem,

117–121

handler API, 118–121

key classes and files for handlers, 118

system catalog. See data dictionary

systems

securing whole systems, 545–553

application access, 551

data storage and encryption, 551–553

files, directories, and processes, access

to, 547–548

network security, 548–549

operating system security, 547

servers, securing physical access to, 546

user access, controlling, 549–550

system version ID, defined, 100

■T

table cache, 125–127

table handlers, defined, 154

table-level locks

described, 89

MyISAM storage engine, 160–161

table privilege scope, 504

table types, defined, 154

tables

binary logs for up-to-date tables, 581–582

derived tables, 293–297

basics of, 293–297

UNION query and, 303

grant tables

basics of, 497

querying, 508–509

updgrading MySQL and, 499

INFORMATION_SCHEMA tables. See

INFORMATION_SCHEMA interface

joining, and views, 427–430

multitable deletes, 310–311

relevant code listings

Create a Table in the Cluster, 631

Creating a Table with Unavailable

Database Nodes, 633

Revoking Table-Level Privileges and

Granting Column-Level Privileges,

Table Schema for Storing

Advertisements, 326

Table Section Definition in select-

key.smack, 205

retrieving random records from, 326–328

sizes by engine, summarizing, 697–698

table configuration section, Super Smack,

table fragmentation, minimizing in

205–207

MyISAM, 158

temporary, permissions for, 503

tmp table, copying to, 220

triggers and

locking tables, 450

specifying for activation, 455

unioned, and views, 430–431

tablespace, defined, 166–167

tabular subqueries, 293

team environments, and coding style, 238

team roles, 4–13

application developers, 4–12

business analysts, 5–8

customers, 4–5

database administrators, 11

database designers, 8–11

interface designers, 12

project managers, 12–13

temporal data, and data types, 182–183

temptable algorithms, 425

terminology, of replication, 586–587

Term::ReadKey Perl module, and Mytop, 229

test sets, populating with gen-data, 206–207

TEXI, viewing, 110

texi2html, viewing, 110

text columns and data sets, 196

THD class, 117

Theta style, vs. ANSI style, SQL, 236

threads

about, 114

I/O Thread, Starting (code listing), 610

multithreaded environments, defined, 115

/sql/mysqld.cc create_new_thread( )

(code listing), 142–143

SQL threads, and replication, 610

thread-based vs. process-based design,

114–115

thread list, 650–651

thread-specific data (TSD), 116

user connection threads, and THD

objects, 117

time( ) functions, and replication, 611

timestamps, 182–183

tmp table, copying to, 220

tokens, gen-data-f option formatting, Super

Smack, 205–206

tools

benchmarking

ApacheBench (ab), 212–216

httperf, 216–217

MyBench, 212

CASE tools, 25


■I N D E X

tools (continued)

downloading Graph visualization toolkit,

ACID test for transaction compliancy,

E-R diagramming tools, 27–30

AllFusion ERwin Data Modeler, 28–29

DBDesigner4, 29–30

information on open-source tools, 13

MySQL Administrator GUI tool, 519–529

connecting to server, 520–521

new user accounts, adding, 524–526

removing accounts, 528–529

user administration, navigating,

user privileges, viewing and editing,

521–523

526–528

MySQL tools for backup and restoration,

560–581. See also InnoDB, creating

backups of InnoDB files;

mysqldump; mysqlhotcopy

MySQL Administrator, backup utility,

577–581

mysqlbinlog tool, 582

mysqlsnapshot tool, 556

Nagios, 652

Profiler tool (SQL Server), 32

profiling, 219–234. See also Zend advanced

PHP debugger extension

EXPLAIN command, 223–225

general query log, 227–229

Mytop script, 229

SHOW FULL PROCESSLIST command,

219–222

SHOW STATUS command, 222–223

slow query log, 225–227

replication and

mysqlhotcopy, 599

mysqlsnapshot tool, 599

replication tools for downloading, 615

for troubleshooting, 646–652

error logs, 646–648

general query log, 648–649

monitoring programs, 652

operating system process list, 652

server thread list, 650–651

slow query log, 650

Unix developer tools package, 481

top-down SQL, 244

top utility, Mytop, 229

traces

defined, 217

human- and machine-readable, and

profilers, 217

traffic, security of, 548

transaction logs, defined, 82

transaction processing, 69–103

autocommit mode, 77–81

basics of, 70–76

72–76

banking example, 70–71

foreign key constraints, 72

transaction failures, 71–72

checkpointing, 84–88

history and background, 69–70

InnoDB for, 178

isolation and concurrency, implementing,

88–101. See also locking, locking and

isolation levels, examples

isolation levels, 90–92

locking resources, 88–90

multiversion concurrency control,

MVCC, 100–101

logging, 82–83

recovery process, 84

transaction control requirements,

identifying, 102–103

transaction wrappers and demarcation,

76–77

trees. See also hierarchical data

call trees and APD, 230

category tree

diagram of, 314

removing node from, 325

finding the depth of, 315–316

Getting the Total Depth of the Tree

(code listing), 316

inserting nodes into, 322

removing nodes from, 324–326

summarizing across, 318–322

tree-based index layouts, 57–59

Trees and Hierarchies in SQL for Smarties

(Morgan Kaufmann, 2004), 313

.TRG file, and triggers, 447

trigger namespace, 447

triggers, 443–465

advantages and disadvantages of, 444–446

creating, 448–456

activation time, 454

CREATE statement, 452–453

events for activation, specifying,

454–455

names, 453–454

tables to activate, specifying, 455

trigger body statements, 455–456

cursors and, 409

vs. functions, 380

modifying and removing, 462–463

in MySQL, 446–448

MySQL 5.0.6 and 5.0.x and, 463–465

overview of, 443–444

performance of, 463–465

permissions, 463


■I N D E X

can’t connect through socket errors,

UNION View with a Data Source,

using, 456–461

viewing, 461–462

views and, 427

troubleshooting, 645–668

bugs, reporting, 667

client issues

MySQL server not responding, 658–659

packet length too big messages,

server has gone away messages,

659–660

660–661

653–654

connection issues

can’t connect to host errors, 655

data corruption, resolving, 666–667

overview of, 645

restarts, unexpected, 665–666

shutdown

problems stopping server, 664–665

server crashes, 662–663

startup problems

support options, 668

toolkit for, 646–652

error logs, 646–648

general query log, 648–649

monitoring programs, 652

operating system process list, 652

server thread list, 650–651

slow query log, 650

user issues

656–657

access denied for user messages,

permission issues, 657

TSD (thread-specific data), 116

Turnbull, James, 547

two-way encryption, 552–553

type variable, Super Smack, 208

■U

ucasefirst ( ) function, 403

UDFs (user-defined functions), adding, 381

UML. See Unified Modeling Language (UML)

unattached records. See orphaned records

undefined algorithms, 425

UNDO handler type, 363

UNDO log records

basics of, 84

recovery process and, 86

Unified Modeling Language (UML), 16–21

class diagrams, 17–20

deployment diagrams, 20–21

UML modeling software, 21–25

AllFusion Component Modeler, 22

ArgoUML, 24–25

SmartDraw7 Technical Edition, 24

Visio, 23

uninstalling MySQL, 494–495

UNION ALL keywords, 258

UNION joins, 254–260

UNION query

OR statement and, 344–346

relevant code listings

UNION Query Merging Two Previous

Resultsets, 256–257

UNION Query Resolves the Problem, 302

UNION Query to Find System User

Information, 259

Creating, 431

unique_subquery access type, 267–268

Unix

configuration files, 486

manually installing tarball on, 473–474,

477–481

startup and shutdown, 483

unmatching data types, 384

updating

Creating an Updatable View (code listing),

UPDATE operations, and transaction

requests, 101

Update with discount_percent Increase

Limit (code listing), 461

Updated Category Listing (code listing),

248–249

upgrading MySQL, 493–494

URLs, Determining How Many Duplicates

Exist in the Data Set (code listing),

USAGE privilege, 517–518

use case model, 16

use cases, 7–8

USE INDEX and FORCE INDEX hints, 277

user administration, 497–531

access control and privilege verification,

510–516

authenticating users, 511–513

connection parameters, default, 513

host Grant table, 515–516

overview of, 510

verifying user privileges, 513–515

MySQL Administrator GUI tool, 519–529

connecting to server, 520–521

new user accounts, adding, 524–526

removing accounts, 528–529

user administration, navigating,

user privileges, viewing and editing,

521–523

526–528

practical guidelines for, 531


■I N D E X

user administration (continued)

privileges, 497–509. See also scope levels

isolating changed variables, 195

key_buffer_size configuration variable,

granting all privileges, 507

granting and revoking, 498

viewing user privileges, 507–509

user accounts, managing from command

line

adding, 516–517

changing, 518–519

host Grant table, 516–519

removing, 518

restricting, 517

user roles, 529–530

user connection threads, and THD objects,

user-defined functions (UDFs), adding, 381

user grant table, 511

users

authenticating, 511–513

host values and, 511

identifying, 511

MySQL Administrator and

new user accounts, adding, 524–526

removing accounts, 528–529

user administration, navigating,

user privileges, viewing and editing,

non-root user, running MySQL as, 540,

security, and controlling user access,

user accounts, managing from command

521–523

526–528

line

549–550

adding, 516–517

host Grant table, 516–519

removing, 518

restricting, 517

user issues, troubleshooting

access denied for user messages,

656–657

permission issues, 657

user roles, 529–530

username, defined, 511

verifying user privileges, 513–515

viewing user privileges, 507–509

USING keyword, 261–262

■V

VARCHAR, using with InnoDB, 185

variables

BLOCK_TEMPERATURE variable, 123

creating database functions and, 387–388

cursors and, 410–411

DECLARE statements and, 359–360

global variables, 387

local variables, 387

monitoring, 127

server statistical variables, 124–125

session variables, 387

Super Smack

source_type variable, 208

type variable, 208

triggers and, 456

User Variables, Plugging into the Distance

Formula (code listing), 332

viewing functions, 398–401

viewing triggers, 461–462

views, 419–442. See also

INFORMATION_SCHEMA, views

altering, 438–439

COLUMNS view, 680

creating, 422–433. See also SELECT

statements, views and

algorithm attributes, 424–425

check options, 432–433

column names, 426

CREATE statement, 423–424

view names, 425–426

displaying, 436–437

vs. functions, 378–380

in MySQL, 421–422

performance of, 440–442

permissions, 440

relevant code listings

Creating a Simple View, 423

Creating a View with Check Options, 432

Creating a View with Joined Tables, 427

Creating a View with Specified Column

Output of the View with Joined Tables,

Names, 426

Clause, 429

Clause, 430

Output from a View with GROUP BY

Output from a View with HAVING

Selecting from a View, 423

Selecting from the View with Specified

Column Names, 426

removing, 439

UNION view

Creating a View with UNION, 430–431

Output of a UNION View with a Data

Source, 431

Output of Selecting from the View

Created with UNION, 431

updated views, creating, 433–435

uses for, 419–421

views of views, defining, 435


■I N D E X

virtual fields, and views, 421

virtual tables, 293–297

VirtualHost directive, 542

Visio, 23

volatile data storage, 41–42

■W

web sites

downloading from

developer tools package, 481

Graph visualization toolkit, 109

httperf, 216

MySQL 5.0.2 Doxygen output, 109

MySQL Administrator GUI tool, 520

mysqlsnapshot tool, 556

noinstall.zip file, 474

replication tools, 615

sample security policies, 537

scripts for building alert systems, 606

source code, 106

Super Smack, 201

Term::ReadKey Perl module, 229

ZCTAs, 329

for further information

access privilege issues, 657

accounts, securing, 549

AllFusion Component Modeler, 22

ArgoUML, 24

benchmarks, non-MySQL-generated,

binaries, 471

binary log (binlog), 593

bug reports, 667

can’t connect to host errors, 655

Cluster, change history of, 625

cluster limitations and change history

documents, 626

clustering configuration file options,

clusters, 618, 622

commonly encountered issues

summary, 652

crash-me script, 198

crashing, 666

DBDesigner4, 29

Doxygen, 109

error codes, 388

error numbers, 360

file layouts for operating systems, 471

floating-point arithmetic, 180

foreign key constraints, 10

FULLTEXT options, 163

GIS data, 329

INFORMATION_SCHEMA view lists,

InnoDB flushing, 171

InnoDB parent record options, 165

LOAD DATA FROM MASTER command,

MaxDB, 529

merge replication, 589

MyBench, 212

myisampack utility, 159

MySQL Administrator, 529, 543, 580,

MySQL documentation, 350, 493

MYSQL Query Browser, 372

mysqlbinlog options, 582

mysqldump, 567

mysqlhotcopy, 572, 599

mysqlsnapshot tool, 599

Nagios, 652

native functions, documentation on,

ndbd options, 638

open-source tools, 13

permissions for tables, 503

PHP documentation, 368

privilege system, 655

query cache, 422

REGEXP function, 213

replication, 605

server connection failures, 654

server has gone away messages, 661

shutdown problems, 665

single-slave environments tests, 611

SmartDraw7 Technical Edition, 24

software to assist project managers, 13

SQL Server, 32

SQLSTATE values, 388

standard for stored procedures, 353

startup script, 664

storage engines, creating, 121

table maintenance, 666

timestamps, 183

too many connections errors, 658

trigger implementation, 448

trigger names, rules for legal, 453

VC++ documentation, 477

views, 435

virtual hosts, configuring, 542

Visio, 23

YACC, Bison and Lex, 136

InnoDB for web site session data, 179

web software commercial development,

35–36

WHERE clause, 253

while loops, and binary searches, 50

WHILE statements

creating database functions and, 393

DECLARE statements and (stored

procedures), 365


■I N D E X

Windows

configuration files, 486

Hardening Windows (Apress, 2004), 547

manually installing, 474

startup and shutdown, 483

Windows Essential download, 475

Windows installer, for installing MySQL,

WITH CHECK OPTION, 432–433

WITH GRANT OPTION clause, 506

Wizards

Configuration Wizard, 475

Installation Wizard, 475

write-ahead logging, 82–83

write cursors, defined, 407

write locks

described, 89–90

MyISAM, 161

Writing Effective Use Cases (Addison-Wesley,

2001), 8

■X

XML Metadata Interchange (XMI) formal,

and ArgoUML, 24

■Y

YACC, and parser generation, 136

■Z

Zaitsev, Peter, 171

Zawodny, Jeremy, 212, 229, 556

ZCTA Table, Initial Design for (code listing),

229–234

231–233

ZCTAs, Finding Within a Specific Radius

(code listing), 334–335

Zend advanced PHP debugger extension,

APD, profiling PHP applications with,

APD, setting up, 230–231

zip codes

determining within a radius, 334–343

gathering coordinate information for,

331–332


forums.apress.com

FOR PROFESSIONALS BY PROFESSIONALS™

JOIN THE APRESS FORUMS AND BE PART OF OUR COMMUNITY. You’ll find discussions that cover topics

of interest to IT professionals, programmers, and enthusiasts just like you. If you post a query to one of our

forums, you can expect that some of the best minds in the business—especially Apress authors, who all write

with The Expert’s Voice™—will chime in to help you. Why not aim to become one of our most valuable partic-

ipants (MVPs) and win cool stuff? Here’s a sampling of what you’ll find:

DATABASES

Data drives everything.

PROGRAMMING/BUSINESS

Unfortunately, it is.

Share information, exchange ideas, and discuss any database

programming or administration issues.

Talk about the Apress line of books that cover software

methodology, best practices, and how programmers interact with

the “suits.”

INTERNET TECHNOLOGIES AND NETWORKING

Try living without plumbing (and eventually IPv6).

WEB DEVELOPMENT/DESIGN

Ugly doesn’t cut it anymore, and CGI is absurd.

Talk about networking topics including protocols, design,

administration, wireless, wired, storage, backup, certifications,

trends, and new technologies.

Help is in sight for your site. Find design solutions for your

projects and get ideas for building an interactive Web site.

JAVA

We’ve come a long way from the old Oak tree.

SECURITY

Lots of bad guys out there—the good guys need help.

Hang out and discuss Java in whatever flavor you choose:

J2SE, J2EE, J2ME, Jakarta, and so on.

Discuss computer and network security issues here. Just don’t let

anyone else know the answers!

MAC OS X

All about the Zen of OS X.

TECHNOLOGY IN ACTION

Cool things. Fun things.

OS X is both the present and the future for Mac apps. Make

suggestions, offer up ideas, or boast about your new hardware.

It’s after hours. It’s time to play. Whether you’re into LEGO®

MINDSTORMS™ or turning an old PC into a DVR, this is where

technology turns into fun.

OPEN SOURCE

Source code is good; understanding (open) source is better.

WINDOWS

No defenestration here.

Discuss open source technologies and related topics such as

PHP, MySQL, Linux, Perl, Apache, Python, and more.

Ask questions about all aspects of Windows programming, get

help on Microsoft technologies covered in Apress books, or

provide feedback on any Apress Windows book.

HOW TO PARTICIPATE:

Click the New User link.

Go to the Apress Forums site at http://forums.apress.com/.

