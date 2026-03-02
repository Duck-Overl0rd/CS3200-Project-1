/*
Query 4: Courses on Specific Days for a Given Term Type

Description:
  Finds all courses that meet on Monday/Wednesday or
  Monday/Wednesday/Friday AND belong to a semester term.
  Also filters to only include courses that have a section
  number OR a professor name specified.
  This demonstrates a complex search with multiple expressions
  and logical connectors (AND, OR).

Requirements satisfied:
  - Complex search criterion (multiple expressions with
    logical connectors AND / OR)
*/

SELECT
    c.courseName        AS Course,
    c.meetingDays       AS MeetingDays,
    c.meetingTime       AS MeetingTime,
    c.sectionNumber     AS Section,
    c.professorName     AS Professor,
    t.termName          AS Term,
    t.termType          AS TermType
FROM Course c
    JOIN Term t ON t.termID = c.termID
WHERE
    (c.meetingDays = 'Mon/Wed' OR c.meetingDays = 'Mon/Wed/Fri')
    AND t.termType = 'semester'
    AND (c.sectionNumber IS NOT NULL OR c.professorName IS NOT NULL)
ORDER BY c.meetingDays, c.meetingTime;

-- ============================================================
-- Example Output:
--
-- Course             | MeetingDays  | MeetingTime | Section      | Professor | Term      | TermType
-- -------------------|--------------|-------------|--------------|-----------|-----------|----------
-- Database Systems   | Mon/Wed/Fri  | 09:00       | CS3200-01    | NULL      | Fall 2024 | semester
-- Algorithms         | Mon/Wed      | 11:00       | CS3000-01    | NULL      | Fall 2024 | semester
-- Statistics         | Mon/Wed      | 14:00       | STAT2710-01  | Dr. Chen  | Fall 2024 | semester
-- Software Engineering| Mon/Wed/Fri | 10:00       | CS4500-01    | NULL      | Spring 25 | semester
-- ============================================================
