## The requirements document as a PDF.
[Click here for Requirements Document 1](<./Requirements Document for Project 1.pdf>)
<!-- [Click here to view the Requirements Document](./Requirements%20Document%20for%20Project%201.pdf) -->


## UML Class Diagram as an embedded JPG/PNG.
<!-- ![UML Diagram](./UML%20Diagram.png) -->
![UML Diagram](<./UML Diagram.png>)


## ERD as an embedded JPG/PNG and URL to its LucidChart diagram.
Link to the LucidChart diagram - https://lucid.app/lucidchart/81631362-3165-48f5-a24b-39fc76c45ca3/edit?viewport_loc=786%2C-281%2C4382%2C1850%2CHWEp-vi-RSFO&invitationId=inv_715c1a36-847b-4ee1-b464-716fcccf907b
![ERD Diagram](<./ERD Diagram.png>)


## Definition of relational schema with proof that it is in BCNF.
**Definition:** A relational schema is the logical structure, or schema, of a relational database. Defining how data is organized, stored, and related. It's a set of rules—specifying tables, columns, data types, and constraints (like primary keys)—without containing the actual data itself. It ensures data consistency and integrity.

In the context of my project, here is my relational schema:<br>
**User**( userID [PK], name, email, schoolName, schoolType )<br>
**Friendship**( friendshipID [PK], requesterID [FK], receiverID [FK], status, requestedAt )<br>
**Term**( termID [PK], termName, termType, startDate, endDate )<br>
**Course**( courseID [PK], courseName, meetingDays, meetingTime, sectionNumber, professorName, termID [FK] )<br>
**CourseRegistration**( registrationID [PK], userID [FK], courseID [FK], registeredAt )<br><br>

A relation is in BCNF if, for every functional dependency X -> Y, X is a superkey.<br>

**User** is in BCNF because userID is the primary key and a superkey. All the attributes depend solely on userID. And no partial or transitive dependencies exist.<br>

**Friendship** is in BCNF because friendshipID is the primary key and a superkey. requesterID and receiverID are foreign keys referencing **User** and don't determine any other attributes within this table. No partial or transitive dependencies exist either.<br>

**Term** is in BCNF because termID is the primary key and a superkey. All attributes depend solely on termID. (Note: duration is derived from startDate and endDate and is not stored as an attribute, so it introduces no dependency. No partial or transitive dependencies exist.)<br>

**Course** is in BCNF because courseID is the primary key and a superkey. termID is a foreign key referencing **Term**, but it does not determine any other attributes within this table. sectionNumber and professorName are optional attributes that depend only on the courses type (high school, or college), not on each other or any other attribute. No partial or transitive dependencies exist.<br>

**CourseRegistration** is in BCNF because registrationID is the primary key and a superkey. userID and courseID are foreign keys referencing User and Course, and don't determine any other attributes within this table. No partial or transitive dependencies exist.<br>

**Conclusion**<br>
Every functional dependency across all five relations has a superkey
on the left-hand side. Therefore, the entire ClassFriends relational
schema is in BCNF.


## SQL file (text file) with the table definitions and creation SQL statements that can be executed with SQLite3
![DB Browser Statements](<./DB Browser Statements.png>)

## SQL files for each one of the queries created on point 7, with clear documentation of what they achieve and examples of their outputs.
[My file for a Query on joining three tables (Query 1)](./Query%201.sql)<br>
[My file for a Query on a subquery (Query 2)](./Query%202.sql)<br>
[My file for a Query on GROUP BY with a HAVING clause (Query 3)](./Query%203.sql)<br>
[My file for a Query on complex search criterion (Query 4)](./Query%204.sql)<br>
[My file for a Query on an advanced query mechanism PARTITION (Query 5)](./Query%205.sql)<br>
[My file for a Query on an advanced query mechanism SELECT CASE/WHEN (Query 6)](./Query%206.sql)<br>

While stated in each of the files on what the query tries to achieve and examples of their output, each query has their real use case for the users of ClassFriends.<br>

* Query 1 — "What classes do I share with my friends?" Literally the core feature of ClassFriends. It's the most natural query in the whole project.<br>
* Query 2 — "Which users have an active social connection?" Useful for knowing who is actually using the friend system vs. who is isolated on the platform.<br>
* Query 3 — "Which courses have multiple students enrolled?" Directly useful for finding courses where friend groups are likely to overlap, which ties back to the parent/peer user stories.<br>
* Query 4 — "What courses are available on certain days for a given term type?" A practical schedule browsing query, like filtering classes by when they meet.<br>
* Query 5 — "What is the status of all my friend connections, and can I see their schedule?" Directly tied to your business rule that only accepted friends can view each other's schedules.<br>
* Query 6 — "Who has the heaviest course load in a given term?" Useful for the parent persona who wants to know how many classes their child is taking relative to others.

## The code of your basic application (Optional)
