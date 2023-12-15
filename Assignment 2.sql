--Creating the database
create database SISDB

use SISDB

--Creating tables inside the Database
create table Students(
Student_id int primary key,
first_name varchar(10),
last_name varchar(10),
date_of_birth date,
email varchar(25),
phone varchar(10)
)

create table Teachers(
teacher_id int primary key,
first_name varchar(10),
last_name varchar(10),
email varchar(25)
)

create table Courses(
course_id int primary key,
course_name varchar(25),
credits int,
teacher_id int,
foreign key (teacher_id) references Teachers(teacher_id)
)

create table Enrollments(
enrollment_id int primary key,
student_id int unique,
course_id int unique,
enrollment_date date,
foreign key (student_id) references Students(student_id),
foreign key (course_id) references Courses(course_id)
)

create table Payments(
payment_id int primary key,
student_id int unique,
amount varchar(10),
payment_date date,
foreign key (student_id) references Students(student_id)
)

--Inserting values into tables
insert into Students values(3,'Prakash','Bhise','2002-01-27','prakash@gmail.com','5246587563'),
(4,'Manali','Mane','2001-12-25','manali@gmail.com','8745696325'),(5,'Tejas','Singh','2001-05-12','tejas@gmail.com','8546854758'),
(6,'Jessica','Smith','2002-02-01','sjess@gmail.com','8933021005'),(7,'Aashish','Shinde','2001-06-30','aashish@gmail.com','8542154256'),
(8,'Rupesh','Shah','2001-01-22','rupesh@gmail.com','5475698001'),(9,'Akash','Saxena','2001-09-28','akashs@gmail.com','9905214012'),
(10,'Mitushi','Patil','2001-04-27','mpatil@gmail.com','7752360014')

insert into Teachers values(1,'Rasika','Jode','rasika@gmail.com'),(2,'Namdev','Gawade','ngawade@gmail.com'),
(3,'Tarannum','Sayyed','tarannum@gmail.com'),(4,'Vijay','Kshirsagar','vijay@gmail.com'),(5,'Monika','Ghatge','monikag@gmail.com'),
(6,'Dipali','Kanse','dipali@gmail.com'),(7,'Ganesh','Patil','gnpatil@gmail.com'),(8,'Jagdish','Sawant','jsawant@gmail.com'),
(9,'Viraj','Kadam','viraj@gmail.com'),(10,'Anuja','Desai','anuja@gmail.com')

insert into Courses values(1,'Database Systems',10,2),(2,'Software Engineering',10,3),(3,'Operating Systems',10,5),
(4,'Soft Skills',8,2),(5,'Linear Algebra',10,6),(6,'Computer Networks',10,7),(7,'Blockchain',8,1),(8,'Cloud Computing',8,7),
(9,'Big Data',8,10),(10,'Machine Learning',10,9)

insert into Enrollments values(1,3,1,'2023-01-15'),(2,5,6,'2023-01-12'),(3,7,6,'2022-12-28'),(4,3,10,'2023-01-05'),(5,6,9,'2022-12-30'),
(6,10,7,'2023-01-06'),(7,1,9,'2023-01-10'),(8,2,5,'2023-01-12'),(9,8,3,'2022-12-29'),(10,4,4,'2023-01-17')

insert into Payments values(1,3,'5000','2023-01-15'),(2,5,'5000','2023-01-12'),(3,7,'5000','2022-12-28'),(4,3,'5000','2023-01-05'),
(5,6,'3000','2022-12-30'),(6,10,'3000','2023-01-06'),(7,1,'3000','2023-01-10'),(8,2,'5000','2023-01-12'),(9,8,'5000','2022-12-29'),
(10,4,'3000','2023-01-17')


---DML Questions---
--Q. 1) Write an SQL query to insert a new student into the "Students" table with the following details:
insert into Students values(11,'John','Doe','1995-08-15','john.doe@example.com','1234567890')

--Q. 2) Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.
insert into Enrollments values(11,
(select Student_id from Students where first_name='John' and last_name='Doe'),
(select course_id from Courses where course_name='Blockchain'),
'2023-01-25')

--Q. 3) Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
update Teachers
set email='danuja@gmail.com'
where teacher_id=10

--Q. 4) Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course.
delete from Enrollments
where student_id=(select student_id from Students where first_name='John' and last_name='Doe') and
course_id=(select course_id from Courses where course_name='Blockchain')

--Q. 5) Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
update Courses
set teacher_id=(select teacher_id from Teachers where first_name='Rasika' and last_name='Jode')
where course_id=(select course_id from Courses where course_name='Machine Learning')

select * from Courses

--Q. 6) Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
ALTER TABLE Enrollments
DROP FK__Enrollmen__stude__403A8C7D

alter table Enrollments
add foreign key(student_id)
references Students(Student_id)
on delete cascade

ALTER TABLE Payments
DROP FK__Payments__studen__44FF419A

alter table Payments
add foreign key(student_id)
references Students(Student_id)
on delete cascade

delete from Students
where Student_id=10

select * from Enrollments

--Q. 7) Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
update Payments
set amount='5500'
where student_id='3'

---Join Questions---

--Q. 1) Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.
select s.Student_id, s.first_name, s.last_name, sum(p.amount) as amt
from Students s
join Payments p on s.Student_id=p.student_id
where s.student_id='3'
group by s.Student_id, s.first_name, s.last_name

--Q. 2) Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table
select c.course_name, count(e.student_id) as studentcount
from Courses c
join Enrollments e on c.course_id=e.course_id
group by c.course_name

--Q. 3) Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students 
--without enrollments
select s.Student_id, s.first_name, s.last_name
from Students s
left join Enrollments e on s.Student_id=e.student_id
where e.student_id is null

--Q. 4) Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the 
--"Enrollments" and "Courses" tables.
select s.Student_id, s.first_name, s.last_name, c.course_name
from Students s
join Enrollments e on s.Student_id=e.student_id
join Courses c on e.course_id=c.course_id

--Q. 5) Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table 
select t.teacher_id, t.first_name, t.last_name, c.course_name
from Teachers t
join Courses c on t.teacher_id=c.teacher_id

--Q. 6) Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.
select s.Student_id, s.first_name, s.last_name, c.course_name, e.enrollment_date
from Students s
join Enrollments e on s.Student_id=e.student_id
join Courses c on e.course_id=c.course_id

--Q. 7) Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.
select s.Student_id, s.first_name, s.last_name
from Students s
left join Payments p on s.Student_id=p.student_id
where p.student_id is null

--Q. 8) Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL 
--enrollment records.
select c.course_id, c.course_name
from Courses c
left join Enrollments e on c.course_id=e.course_id
where e.course_id is null

--Q. 9) Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
select s.Student_id, s.first_name, s.last_name, c.course_name
from Students s
join Enrollments e1 on s.Student_id=e1.student_id
join Enrollments e2 on (e1.student_id=e2.student_id and e1.course_id<>e2.course_id)
join Courses c on e2.course_id=c.course_id

--Q. 10) Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments
select t.teacher_id, t.first_name, t.last_name
from Teachers t
left join Courses c on t.teacher_id=c.teacher_id
where c.teacher_id is null


---Aggregate functions and Subqueries questions---

--Q. 1) Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.
select course_id, avg(studentcount) as avgcount
from
(select course_id, avg(student_id) as studentcount
from Enrollments
group by course_id) as a
group by course_id

--Q. 2) Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.
select student_id from Payments
where amount=(select max(amount) from Payments)

--Q. 3) Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.
select course_id, course_name
from Courses
where course_id in
(
select course_id
from Enrollments group by course_id
having count(student_id) =
(
select max(enrollmentcount) from
(
select count(student_id) as enrollmentcount
from Enrollments group by course_id
) as enrollmentcounts
)
)

--Q. 4) Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.
select teacher_id, first_name, last_name,
(
select sum(amount)
from Payments
where student_id in
(
select student_id
from Enrollments
where course_id in
(
select course_id
from Courses
where teacher_id=Teachers.teacher_id
)
)
) as paymentforteachers
from Teachers

--Q. 5) Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.
select Student_id, first_name, last_name
from Students
where
(select count(course_id) from Courses)=(select count(course_id) from Enrollments where student_id=Students.Student_id)

--Q. 6) Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
select teacher_id, first_name, last_name
from Teachers
where teacher_id not in(select teacher_id from Courses)

--Q. 7) Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
select avg(age) as averageage
from
(
select datediff(year,date_of_birth,getdate()) as age 
from Students
) as ageofeachstudent


--Q. 8) Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
select course_id, course_name
from Courses
where course_id not in
(select course_id from Enrollments)

--**
--Q. 9) Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments.


select s.Student_id, s.first_name, s.last_name, c.course_name, p.amount
from students s
join payments p on s.student_id=p.student_id
join Enrollments e on p.Student_id=e.student_id
join Courses c on e.course_id=c.course_id

--Q. 10) Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.
select Student_id, first_name, last_name
from Students
where Student_id in
(
select student_id
from Payments
group by student_id
having count(*)>1
)

--Q. 11) Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.
select s.Student_id, s.first_name, s.last_name, sum(amount) as amountpayment 
from Students s
join Payments p on s.Student_id=p.student_id
group by s.Student_id, s.first_name, s.last_name

--Q. 12) Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
select c.course_id, c.course_name, count(e.student_id) as studentcount
from Courses c
join Enrollments e on c.course_id=e.course_id
group by c.course_id, c.course_name

--Q. 13) Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average
select s.Student_id, s.first_name, s.last_name, avg(amount) as avgamount
from Students s
join Payments p on s.Student_id=p.student_id
group by s.Student_id, s.first_name, s.last_name

