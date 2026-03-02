/*
Query 5: Friendship Status Labels

Description:
  Retrieves all friendship records with a human-readable
  label describing the status and whether the two users
  can view each other's schedules. Uses CASE/WHEN to
  generate the label dynamically based on the status field.

Requirements satisfied:
  - Advanced query mechanism: SELECT CASE/WHEN
*/

SELECT
    u1.name         AS Requester,
    u2.name         AS Receiver,
    f.status        AS Status,
    f.requestedAt   AS RequestedOn,
    CASE f.status
        WHEN 'accepted' THEN 'Can view each other''s schedules'
        WHEN 'pending'  THEN 'Awaiting response — schedules hidden'
        WHEN 'declined' THEN 'Request declined — schedules hidden'
    END             AS ScheduleVisibility
FROM Friendship f
    JOIN User u1 ON u1.userID = f.requesterID
    JOIN User u2 ON u2.userID = f.receiverID
ORDER BY f.status, f.requestedAt;

-- ============================================================
-- Example Output:
--
-- Requester      | Receiver     | Status   | RequestedOn | ScheduleVisibility
-- ---------------|--------------|----------|-------------|-----------------------------
-- Alice Johnson  | Bob Smith    | accepted | 2024-08-15  | Can view each other's schedules
-- Alice Johnson  | Carol White  | accepted | 2024-08-16  | Can view each other's schedules
-- Bob Smith      | Carol White  | accepted | 2024-08-17  | Can view each other's schedules
-- ...
-- Alice Johnson  | David Lee    | pending  | 2024-09-01  | Awaiting response — schedules hidden
-- David Lee      | Alice Johnson| declined | 2024-09-05  | Request declined — schedules hidden
-- ============================================================
