Hackathon Management System
This project is a Hackathon Management System built using Oracle SQL. It allows organizers to manage hackathons, participants, and ticketing information. The system tracks event details, participant registrations, and payment statuses, while allowing for easy queries to view upcoming events and registered participants.

Features
Manage multiple hackathons.
Register and manage participants.
Organize event tickets and track payment status.
Update registration status (e.g., confirmed, pending, canceled).
Enforce capacity limits on hackathon events.
Database Schema
The system includes four key tables:

1. Hackathons
Manages the details of each hackathon, including name, dates, location, and capacity.

Column	Data Type	Description
hackathon_id	NUMBER(5)	Unique identifier for each hackathon
name	VARCHAR2(100)	Name of the hackathon
start_date	DATE	Starting date of the event
end_date	DATE	Ending date of the event
location	VARCHAR2(150)	Location of the event
capacity	NUMBER(5)	Maximum number of participants allowed
registration_fee	NUMBER(7,2)	Fee for registering for the event
2. Participants
Manages information about participants, including personal details and registration date.

Column	Data Type	Description
participant_id	NUMBER(5)	Unique identifier for each participant
first_name	VARCHAR2(50)	First name of the participant
last_name	VARCHAR2(50)	Last name of the participant
email	VARCHAR2(100)	Email address
phone_number	VARCHAR2(15)	Contact phone number
registration_date	DATE	Date of registration
3. Organizers
Tracks the details of hackathon organizers and their assigned roles.

Column	Data Type	Description
organizer_id	NUMBER(5)	Unique identifier for each organizer
first_name	VARCHAR2(50)	First name of the organizer
last_name	VARCHAR2(50)	Last name of the organizer
email	VARCHAR2(100)	Organizer email address
phone_number	VARCHAR2(15)	Organizer contact number
role	VARCHAR2(50)	Role of the organizer in the event
4. Tickets
Tracks ticket information, including participant registration status and payment status for specific hackathons.

Column	Data Type	Description
ticket_id	NUMBER(5)	Unique identifier for each ticket
hackathon_id	NUMBER(5)	Associated hackathon ID (foreign key)
participant_id	NUMBER(5)	Associated participant ID (foreign key)
registration_status	VARCHAR2(20)	Status of the registration (Pending, Confirmed, Cancelled)
payment_status	VARCHAR2(20)	Status of payment (Paid, Unpaid)
Key SQL Operations
1. List all upcoming hackathons:
sql
Copy code
SELECT * FROM Hackathons WHERE start_date > SYSDATE;
2. Find participants for a specific hackathon (e.g., hackathon_id = 101):
sql
Copy code
SELECT Participants.first_name, Participants.last_name, Tickets.registration_status
FROM Tickets
JOIN Participants ON Tickets.participant_id = Participants.participant_id
WHERE Tickets.hackathon_id = 101;
3. Display confirmed and paid participants:
sql
Copy code
SELECT Participants.first_name, Participants.last_name, Hackathons.name, Tickets.registration_status, Tickets.payment_status
FROM Tickets
JOIN Participants ON Tickets.participant_id = Participants.participant_id
JOIN Hackathons ON Tickets.hackathon_id = Hackathons.hackathon_id
WHERE Tickets.registration_status = 'Confirmed' AND Tickets.payment_status = 'Paid';
4. Cancel a registration:
sql
Copy code
UPDATE Tickets
SET registration_status = 'Cancelled'
WHERE ticket_id = 402;
Sample Data
Hackathons Table:
sql
Copy code
INSERT INTO Hackathons VALUES (101, 'AI Revolution Hackathon', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'TechPark, City', 200, 500);
INSERT INTO Hackathons VALUES (102, 'Blockchain Bonanza', TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_DATE('2024-11-12', 'YYYY-MM-DD'), 'Innovation Center, City', 150, 300);
Participants Table:
sql
Copy code
INSERT INTO Participants VALUES (201, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Participants VALUES (202, 'Jane', 'Smith', 'jane.smith@example.com', '098-765-4321', TO_DATE('2024-10-16', 'YYYY-MM-DD'));
Tickets Table:
sql
Copy code
INSERT INTO Tickets VALUES (401, 101, 201, 'Confirmed', 'Paid');
INSERT INTO Tickets VALUES (402, 102, 202, 'Pending', 'Unpaid');
How to Use
Create the schema using the SQL provided.
Insert sample data to populate the system.
Run queries to manage hackathons, participants, and ticket statuses.
Future Enhancements
Implement triggers to automate capacity checks and update payment statuses.
Add a web interface to allow participants and organizers to interact with the system.
Generate detailed reports for organizers.
