/*
Query 6: Student Course Load Ranked by Term

Description:
  For each term, ranks students by how many courses they
  are registered for. Uses PARTITION BY to reset the ranking
  for each term independently, so the student with the most
  courses in Fall 2024 gets rank 1, and separately the student
  with the most courses in Spring 2025 gets rank 1, and so on.

Requirements satisfied:
  - Advanced query mechanism: PARTITION BY (window function)
*/

SELECT
    t.termName                          AS Term,
    u.name                              AS Student,
    u.schoolType                        AS SchoolType,
    COUNT(cr.courseID)                  AS CoursesRegistered,
    RANK() OVER (
        PARTITION BY t.termID
        ORDER BY COUNT(cr.courseID) DESC
    )                                   AS RankInTerm
FROM User u
    JOIN CourseRegistration cr  ON cr.userID = u.userID
    JOIN Course c               ON c.courseID = cr.courseID
    JOIN Term t                 ON t.termID = c.termID
GROUP BY t.termID, t.termName, u.userID, u.name, u.schoolType
ORDER BY t.termName, RankInTerm;

-- ============================================================
-- Example Output:
--
-- Term              | Student       | SchoolType | CoursesRegistered | RankInTerm
-- ------------------|---------------|------------|-------------------|------------
-- Fall 2024         | Alice Johnson | college    | 3                 | 1
-- Fall 2024         | Carol White   | college    | 3                 | 1
-- Fall 2024         | Bob Smith     | college    | 3                 | 1
-- Fall 2024         | Henry Park    | highschool | 1                 | 4
-- Spring 2025       | David Lee     | college    | 2                 | 1
-- 2024-2025 Year    | Emma Davis    | highschool | 3                 | 1
-- 2024-2025 Year    | Grace Kim     | highschool | 3                 | 1
-- 2024-2025 Year    | Frank Brown   | highschool | 3                 | 1
-- ============================================================
