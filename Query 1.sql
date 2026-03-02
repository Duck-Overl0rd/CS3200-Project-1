/*
Query 1: Shared Courses Between Accepted Friends

Description:
  Given a specific user, this query finds all courses they
  share with each of their accepted friends. It joins User,
  Friendship, CourseRegistration, and Course together to
  compare schedules across accepted connections.

Requirements satisfied:
  - Joins at least three tables (User, Friendship,
    CourseRegistration, Course)
*/

SELECT
    u1.name             AS User,
    u2.name             AS Friend,
    c.courseName        AS SharedCourse,
    c.meetingDays       AS MeetingDays,
    c.meetingTime       AS MeetingTime,
    t.termName          AS Term
FROM Friendship f
    JOIN User u1            ON u1.userID = f.requesterID
    JOIN User u2            ON u2.userID = f.receiverID
    JOIN CourseRegistration cr1 ON cr1.userID = f.requesterID
    JOIN CourseRegistration cr2 ON cr2.userID = f.receiverID
    JOIN Course c           ON c.courseID = cr1.courseID
                           AND c.courseID = cr2.courseID
    JOIN Term t             ON t.termID = c.termID
WHERE f.status = 'accepted'
  AND u1.userID = 1  -- Change this ID to query for a different user
ORDER BY u2.name, c.courseName;

-- ============================================================
-- Example Output (userID = 1, Alice Johnson):
--
-- User           | Friend      | SharedCourse      | MeetingDays  | MeetingTime | Term
-- ---------------|-------------|-------------------|--------------|-------------|----------
-- Alice Johnson  | Bob Smith   | Database Systems  | Mon/Wed/Fri  | 09:00       | Fall 2024
-- Alice Johnson  | Bob Smith   | Statistics        | Mon/Wed      | 14:00       | Fall 2024
-- Alice Johnson  | Carol White | Algorithms        | Mon/Wed      | 11:00       | Fall 2024
-- ============================================================
