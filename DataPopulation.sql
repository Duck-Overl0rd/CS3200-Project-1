-- ============================================================
-- ClassFriends: A Network to View Classes with Friends
-- Test Data
-- Database: SQLite3
-- ============================================================

-- ============================================================
-- Users (mix of highschool and college students)
-- ============================================================
INSERT INTO User (name, email, schoolName, schoolType) VALUES
    ('Alice Johnson',   'alice@email.com',   'Northeastern University',  'college'),
    ('Bob Smith',       'bob@email.com',     'Northeastern University',  'college'),
    ('Carol White',     'carol@email.com',   'Northeastern University',  'college'),
    ('David Lee',       'david@email.com',   'Northeastern University',  'college'),
    ('Emma Davis',      'emma@email.com',    'Lincoln High School',      'highschool'),
    ('Frank Brown',     'frank@email.com',   'Lincoln High School',      'highschool'),
    ('Grace Kim',       'grace@email.com',   'Lincoln High School',      'highschool'),
    ('Henry Park',      'henry@email.com',   'Lincoln High School',      'highschool');

-- ============================================================
-- Friendships (mix of accepted, pending, and declined)
-- ============================================================
INSERT INTO Friendship (requesterID, receiverID, status, requestedAt) VALUES
    -- Accepted friendships (can view each other's schedules)
    (1, 2, 'accepted',  '2024-08-15'),  -- Alice <-> Bob
    (1, 3, 'accepted',  '2024-08-16'),  -- Alice <-> Carol
    (2, 3, 'accepted',  '2024-08-17'),  -- Bob <-> Carol
    (3, 4, 'accepted',  '2024-08-18'),  -- Carol <-> David
    (5, 6, 'accepted',  '2024-08-20'),  -- Emma <-> Frank
    (5, 7, 'accepted',  '2024-08-21'),  -- Emma <-> Grace
    (6, 7, 'accepted',  '2024-08-22'),  -- Frank <-> Grace
    -- Pending friendships (awaiting response)
    (1, 4, 'pending',   '2024-09-01'),  -- Alice -> David (pending)
    (2, 4, 'pending',   '2024-09-02'),  -- Bob -> David (pending)
    (7, 8, 'pending',   '2024-09-03'),  -- Grace -> Henry (pending)
    -- Declined friendships
    (4, 1, 'declined',  '2024-09-05'),  -- David declined Alice's earlier request
    (8, 5, 'declined',  '2024-09-06');  -- Henry declined Emma's request

-- ============================================================
-- Terms (mix of semester and yearly)
-- ============================================================
INSERT INTO Term (termName, termType, startDate, endDate) VALUES
    ('Fall 2024',           'semester', '2024-09-01', '2024-12-15'),
    ('Spring 2025',         'semester', '2025-01-10', '2025-05-01'),
    ('2024-2025 School Year', 'yearly', '2024-09-01', '2025-06-15');

-- ============================================================
-- Courses
-- College courses: use sectionNumber
-- High school courses: use professorName
-- Some use both, some use neither
-- ============================================================
INSERT INTO Course (courseName, meetingDays, meetingTime, sectionNumber, professorName, termID) VALUES
    -- College courses (Fall 2024, termID=1) - primarily sectionNumber
    ('Database Systems',        'Mon/Wed/Fri',   '09:00',    'CS3200-01', NULL,               1),
    ('Database Systems',        'Tue/Thu',        '14:00',    'CS3200-02', NULL,               1),
    ('Algorithms',              'Mon/Wed',        '11:00',    'CS3000-01', NULL,               1),
    ('Linear Algebra',          'Tue/Thu',        '09:30',    'MATH2331-01', NULL,             1),
    -- College courses (Spring 2025, termID=2)
    ('Software Engineering',    'Mon/Wed/Fri',   '10:00',    'CS4500-01', NULL,               2),
    ('Operating Systems',       'Tue/Thu',        '13:00',    'CS3650-01', NULL,               2),
    -- High school courses (2024-2025 School Year, termID=3) - primarily professorName
    ('AP Calculus',             'Mon/Wed/Fri',   '08:00',    NULL,        'Mr. Thompson',     3),
    ('AP Biology',              'Mon/Wed/Fri',   '10:00',    NULL,        'Ms. Rodriguez',    3),
    ('English Literature',      'Tue/Thu',        '09:00',    NULL,        'Mrs. Johnson',     3),
    ('AP Physics',              'Tue/Thu',        '11:00',    NULL,        'Mr. Patel',        3),
    -- Courses with both sectionNumber and professorName
    ('Statistics',              'Mon/Wed',        '14:00',    'STAT2710-01', 'Dr. Chen',       1),
    ('AP Computer Science',     'Mon/Wed/Fri',   '13:00',    'CSA-01',    'Ms. Kim',          3);

-- ============================================================
-- CourseRegistration
-- College students register for college courses
-- High school students register for high school courses
-- ============================================================
INSERT INTO CourseRegistration (userID, courseID, registeredAt) VALUES
    -- Alice (userID=1) - college, Fall 2024
    (1, 1,  '2024-08-20'),  -- Database Systems 01
    (1, 3,  '2024-08-20'),  -- Algorithms
    (1, 11, '2024-08-20'),  -- Statistics
    -- Bob (userID=2) - college, Fall 2024
    (2, 1,  '2024-08-21'),  -- Database Systems 01 (shares with Alice)
    (2, 4,  '2024-08-21'),  -- Linear Algebra
    (2, 11, '2024-08-21'),  -- Statistics (shares with Alice)
    -- Carol (userID=3) - college, Fall 2024
    (3, 2,  '2024-08-22'),  -- Database Systems 02 (different section)
    (3, 3,  '2024-08-22'),  -- Algorithms (shares with Alice)
    (3, 4,  '2024-08-22'),  -- Linear Algebra (shares with Bob)
    -- David (userID=4) - college, Spring 2025
    (4, 5,  '2024-12-01'),  -- Software Engineering
    (4, 6,  '2024-12-01'),  -- Operating Systems
    -- Emma (userID=5) - highschool
    (5, 7,  '2024-08-25'),  -- AP Calculus
    (5, 8,  '2024-08-25'),  -- AP Biology
    (5, 12, '2024-08-25'),  -- AP Computer Science
    -- Frank (userID=6) - highschool
    (6, 7,  '2024-08-26'),  -- AP Calculus (shares with Emma)
    (6, 9,  '2024-08-26'),  -- English Literature
    (6, 10, '2024-08-26'),  -- AP Physics
    -- Grace (userID=7) - highschool
    (7, 7,  '2024-08-27'),  -- AP Calculus (shares with Emma and Frank)
    (7, 8,  '2024-08-27'),  -- AP Biology (shares with Emma)
    (7, 12, '2024-08-27'),  -- AP Computer Science (shares with Emma)
    -- Henry (userID=8) - highschool
    (8, 9,  '2024-08-28'),  -- English Literature (shares with Frank)
    (8, 10, '2024-08-28'),  -- AP Physics (shares with Frank)
    (8, 11, '2024-08-28');  -- Statistics (no friendship with college students)
