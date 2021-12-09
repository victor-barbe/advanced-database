--Q1 : COMMIT AND ROLLBACK

--PART 1 : add a new department and display it
start transaction;
insert into dept values ('50' ,'MANAGMENT', 'LOS-ANGELES');
select * from DEPT;
--then rollback to see if it is still visible
rollback;
select * from dept;

--PART 2 : add a new department again and display
start transaction;
insert into dept values ('50' ,'MANAGMENT', 'LOS-ANGELES');
select * from DEPT;
--then commit and see if it is still visible
commit;
select * from dept;


--Q2 : CLIENT FAILURE

--PART 1 : add a new department without commiting and close the connection tab
start transaction;
insert into dept values ('60' ,'BRAINSTORMING', 'BUENOS AIRES');
select * from DEPT;
--Close the connexion tab, then open a connection tab and see if the changes are still here
start transaction;
select * from DEPT;

--PART 2 : add a new department without commiting and close with the task manager
start transaction;
insert into dept values ('80' ,'BRAINSTORMING', 'BUENOS AIRES');
select * from DEPT;
--Close MySQLWorkBench with the task manager and see if the changes are still here
start transaction;
select * from DEPT;


--Q3 : TRANSACTION ISOLATION

--PART 1 : ADDING A DEPARTMENT
--First we show the transaction isolation level
show variables like '%isolation%';

--Now from a first connection table we add a department without committing
start transaction;
insert into dept values ('60', 'BRAINSTORMING', 'NEW-MEXICO');
select * from DEPT;

--Now from a new connection tab we start a new transaction to see if the changes are visible
start transaction;
select * from dept;

--PART 2 / DELETING A DEPARTMENT
-- First we add permanently a department to the database
start transaction;
insert into dept values ('60', 'BRAINSTORMING', 'NEW-MEXICO');
commit;

--Now we delete it from a transaction without committing
start transaction;
delete from dept where DID = '60';
select * from dept;

--Now from an other transaction on an other connexion tab we look if the changes are visible
start transaction;
select * from dept;


--Q4 : ISOLATION LEVEL

-- PART 1 : ADDING A DEPARTMENT
--First we actualise transaction isolation level to READ UNCOMMITTED for both connexions
SET tx_isolation = 'READ-UNCOMMITTED';
show variables like '%isolation%';
--Then we add a new department from a table without committing
start transaction;
insert into dept values ('70', 'R&D', 'GRAY');
select * from dept;
--Then we try to see if the changes are visible in a transaction on READ-UNCOMMITTED isolation
start transaction;
select * from dept;

--PART 2 : DELETING A DEPARTMENT
--First we delete a department without committing the changes 
start transaction;
delete from dept where DID = '40';
select * from dept;
--Then we try to see if the department is still visible in a transaction on READ-UNCOMMITTED isolation
start transaction;
select * from dept;
--Q5 : ISOLATION LEVEL - CONTINUED

--First we actualise transaction isolation level to READ UNCOMMITTED
SET tx_isolation = 'SERIALIZABLE';
show variables like '%isolation%';
--Then we add a new department from a table without committing
start transaction;
insert into dept values ('80', 'Relation', 'RIO');
select * from dept;
--Then we try to see if the changes are visible in a transaction on serializable isolation
start transaction;
select * from dept;
--After we use the commit button on the 1st transaction and then go back to the 2nd which will start