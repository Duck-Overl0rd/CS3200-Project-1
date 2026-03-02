/*
Query 3: Courses With More Than One Student Enrolled

Description:
  Finds all courses that have more than one student enrolled,
  showing the course name, term, meeting details, and the
  total number of students registered. This is useful for
  identifying courses where friend groups are likely to overlap.

Requirements satisfied:
  - GROUP BY with HAVING clause
*/

SELECT
    c.courseName        AS Course,
    t.termName          AS Term,
    c.meetingDays       AS MeetingDays,
    c.meetingTime       AS MeetingTime,
    COUNT(cr.userID)    AS EnrolledStudents
FROM Course c
    JOIN CourseRegistration cr  ON cr.courseID = c.courseID
    JOIN Term t                 ON t.termID = c.termID
GROUP BY c.courseID, c.courseName, t.termName, c.meetingDays, c.meetingTime
HAVING COUNT(cr.userID) > 1
ORDER BY EnrolledStudents DESC, c.courseName;

-- ============================================================
-- Example Output:
--
-- Course             | Term        | MeetingDays  | MeetingTime | EnrolledStudents
-- -------------------|-------------|--------------|-------------|------------------
-- AP Calculus        | 2024-2025.. | Mon/Wed/Fri  | 08:00       | 3
-- AP Biology         | 2024-2025.. | Mon/Wed/Fri  | 10:00       | 2
-- AP Computer Science| 2024-2025.. | Mon/Wed/Fri  | 13:00       | 2
-- Algorithms         | Fall 2024   | Mon/Wed      | 11:00       | 2
-- Database Systems   | Fall 2024   | Mon/Wed/Fri  | 09:00       | 2
-- Statistics         | Fall 2024   | Mon/Wed      | 14:00       | 2
-- ============================================================
