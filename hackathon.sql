CREATE TABLE Hackathons (
    hackathon_id NUMBER(5) PRIMARY KEY,
    name VARCHAR2(100),
    start_date DATE,
    end_date DATE,
    location VARCHAR2(150),
    capacity NUMBER(5) CHECK (capacity > 0),
    registration_fee NUMBER(7,2) DEFAULT 0
);

CREATE TABLE Participants (
    participant_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    registration_date DATE DEFAULT SYSDATE
);

CREATE TABLE Organizers (
    organizer_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    phone_number VARCHAR2(15),
    role VARCHAR2(50)
);

CREATE TABLE Tickets (
    ticket_id NUMBER(5) PRIMARY KEY,
    hackathon_id NUMBER(5),
    participant_id NUMBER(5),
    registration_status VARCHAR2(20) DEFAULT 'Pending',
    payment_status VARCHAR2(20) DEFAULT 'Unpaid',
    CONSTRAINT fk_hackathon FOREIGN KEY (hackathon_id) REFERENCES Hackathons(hackathon_id),
    CONSTRAINT fk_participant FOREIGN KEY (participant_id) REFERENCES Participants(participant_id)
);

INSERT INTO Hackathons VALUES (101, 'AI Revolution Hackathon', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-03', 'YYYY-MM-DD'), 'TechPark, City', 200, 500);
INSERT INTO Hackathons VALUES (102, 'Blockchain Bonanza', TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_DATE('2024-11-12', 'YYYY-MM-DD'), 'Innovation Center, City', 150, 300);

INSERT INTO Participants VALUES (201, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Participants VALUES (202, 'Jane', 'Smith', 'jane.smith@example.com', '098-765-4321', TO_DATE('2024-10-16', 'YYYY-MM-DD'));

INSERT INTO Organizers VALUES (301, 'Alice', 'Johnson', 'alice.johnson@example.com', '987-654-3210', 'Event Manager');
INSERT INTO Organizers VALUES (302, 'Bob', 'Williams', 'bob.williams@example.com', '543-210-9876', 'Technical Lead');

INSERT INTO Tickets VALUES (401, 101, 201, 'Confirmed', 'Paid');
INSERT INTO Tickets VALUES (402, 102, 202, 'Pending', 'Unpaid');

SELECT * FROM Hackathons WHERE start_date > SYSDATE;

SELECT Participants.first_name, Participants.last_name, Tickets.registration_status
FROM Tickets
JOIN Participants ON Tickets.participant_id = Participants.participant_id
WHERE Tickets.hackathon_id = 101;

SELECT Participants.first_name, Participants.last_name, Hackathons.name, Tickets.registration_status, Tickets.payment_status
FROM Tickets
JOIN Participants ON Tickets.participant_id = Participants.participant_id
JOIN Hackathons ON Tickets.hackathon_id = Hackathons.hackathon_id
WHERE Tickets.registration_status = 'Confirmed' AND Tickets.payment_status = 'Paid';

UPDATE Tickets
SET registration_status = 'Cancelled'
WHERE ticket_id = 402;
