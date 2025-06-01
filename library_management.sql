-- This system manages books, members, and book issuance/returns.

-- Create Library Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create table for members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- Create table for books
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    CopiesAvailable INT
);

-- Create table for issue records
CREATE TABLE IssueRecords (
    IssueID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert sample members
INSERT INTO Members VALUES (1, 'Anjali Sharma', 'anjali@gmail.com', '2023-01-15');
INSERT INTO Members VALUES (2, 'Ravi Kumar', 'ravi@gmail.com', '2023-02-20');

-- Insert sample books
INSERT INTO Books VALUES (101, 'Atomic Habits', 'James Clear', 'Self-help', 4);
INSERT INTO Books VALUES (102, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 2);
INSERT INTO Books VALUES (103, '1984', 'George Orwell', 'Dystopian', 3);

-- Insert sample issue records
INSERT INTO IssueRecords VALUES (201, 1, 101, '2023-03-01', '2023-03-15');
INSERT INTO IssueRecords VALUES (202, 1, 102, '2023-04-01', NULL);
INSERT INTO IssueRecords VALUES (203, 2, 103, '2023-05-01', '2023-05-18');

-- Queries:

-- 1. List all books
SELECT * FROM Books;

-- 2. Show which books are currently issued (ReturnDate is NULL)
SELECT Members.Name AS Member, Books.Title AS Book, IssueDate
FROM IssueRecords
JOIN Members ON IssueRecords.MemberID = Members.MemberID
JOIN Books ON IssueRecords.BookID = Books.BookID
WHERE ReturnDate IS NULL;

-- 3. Count how many times each book has been issued
SELECT Books.Title, COUNT(*) AS TimesIssued
FROM IssueRecords
JOIN Books ON IssueRecords.BookID = Books.BookID
GROUP BY Books.Title;

-- 4. Show members who borrowed more than one book
SELECT Members.Name, COUNT(*) AS TotalIssued
FROM IssueRecords
JOIN Members ON IssueRecords.MemberID = Members.MemberID
GROUP BY Members.Name
HAVING COUNT(*) > 1;
