/*
Query 2: Users With At Least One Accepted Friend

Description:
  Finds all users who have at least one accepted friendship.
  Uses a subquery to first identify all userIDs that appear
  in an accepted friendship (either as requester or receiver),
  then retrieves the full user details for those IDs.

Requirements satisfied:
  - Subquery
*/

SELECT
    u.userID,
    u.name,
    u.email,
    u.schoolName,
    u.schoolType
FROM User u
WHERE u.userID IN (
    SELECT requesterID
    FROM Friendship
    WHERE status = 'accepted'
    UNION
    SELECT receiverID
    FROM Friendship
    WHERE status = 'accepted'
)
ORDER BY u.schoolType, u.name;

-- ============================================================
-- Example Output:
--
-- userID | name          | email             | schoolName               | schoolType
-- -------|---------------|-------------------|--------------------------|------------
-- 1      | Alice Johnson | alice@email.com   | Northeastern University  | college
-- 2      | Bob Smith     | bob@email.com     | Northeastern University  | college
-- 3      | Carol White   | carol@email.com   | Northeastern University  | college
-- 4      | David Lee     | david@email.com   | Northeastern University  | college
-- 5      | Emma Davis    | emma@email.com    | Lincoln High School      | highschool
-- 6      | Frank Brown   | frank@email.com   | Lincoln High School      | highschool
-- 7      | Grace Kim     | grace@email.com   | Lincoln High School      | highschool
-- ============================================================
