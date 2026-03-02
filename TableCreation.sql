-- ============================================================
-- ClassFriends: A Network to View Classes with Friends
-- SQL Data Definition Statements
-- Database: SQLite3
-- ============================================================

-- Drop tables if they already exist (order matters due to FK constraints)
DROP TABLE IF EXISTS CourseRegistration;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Term;
DROP TABLE IF EXISTS Friendship;
DROP TABLE IF EXISTS User;

-- ============================================================
-- Table: User
-- A student registered on the platform
-- ============================================================
CREATE TABLE User (
    userID      INTEGER PRIMARY KEY AUTOINCREMENT,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    schoolName  VARCHAR(100) NOT NULL,
    schoolType  TEXT NOT NULL CHECK(schoolType IN ('highschool', 'college'))
);

-- ============================================================
-- Table: Friendship
-- A friend request between two Users, tracking its status
-- ============================================================
CREATE TABLE Friendship (
    friendshipID    INTEGER PRIMARY KEY AUTOINCREMENT,
    requesterID     INTEGER NOT NULL,
    receiverID      INTEGER NOT NULL,
    status          TEXT NOT NULL CHECK(status IN ('pending', 'accepted', 'declined')),
    requestedAt     DATE NOT NULL,
    FOREIGN KEY (requesterID) REFERENCES User(userID),
    FOREIGN KEY (receiverID)  REFERENCES User(userID),
    -- Ensure a user cannot send a friend request to themselves
    CHECK (requesterID != receiverID),
    -- Ensure no duplicate friendship pairs
    UNIQUE (requesterID, receiverID)
);

-- ============================================================
-- Table: Term
-- An academic period, either semester or yearly
-- ============================================================
CREATE TABLE Term (
    termID      INTEGER PRIMARY KEY AUTOINCREMENT,
    termName    VARCHAR(100) NOT NULL,
    termType    TEXT NOT NULL CHECK(termType IN ('semester', 'yearly')),
    startDate   DATE NOT NULL,
    endDate     DATE NOT NULL,
    -- Ensure end date is after start date
    CHECK (endDate > startDate)
);

-- ============================================================
-- Table: Course
-- A class a student can register for within a term
-- ============================================================
CREATE TABLE Course (
    courseID        INTEGER PRIMARY KEY AUTOINCREMENT,
    courseName      VARCHAR(100) NOT NULL,
    meetingDays     VARCHAR(50)  NOT NULL,
    meetingTime     TIME         NOT NULL,
    sectionNumber   VARCHAR(20),
    professorName   VARCHAR(100),
    termID          INTEGER NOT NULL,
    FOREIGN KEY (termID) REFERENCES Term(termID)
);

-- ============================================================
-- Table: CourseRegistration
-- Links a User to a Course they are enrolled in
-- ============================================================
CREATE TABLE CourseRegistration (
    registrationID  INTEGER PRIMARY KEY AUTOINCREMENT,
    userID          INTEGER NOT NULL,
    courseID        INTEGER NOT NULL,
    registeredAt    DATE NOT NULL,
    FOREIGN KEY (userID)   REFERENCES User(userID),
    FOREIGN KEY (courseID) REFERENCES Course(courseID),
    -- Ensure a user cannot register for the same course twice
    UNIQUE (userID, courseID)
);
