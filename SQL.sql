INSERT INTO Books (ISBN, Title, Author, Genre, PublishedYear, QuantityAvailable)
VALUES ('9781447294832', 'A Little Life', 'Hanya Yanagihara', 'Novel', 2015, 5);

INSERT INTO Users (FullName, EmailAddress, MembershipDate)
VALUES ('Yoshinori Kanemoto', 'YoshKNMT@gmail,com', 08/12/24);

INSERT INTO BookLoans (LoanID, UserID, BookISBN, LoanDate, ReturnDate, Status)
VALUES ('143', '143', '9781447294832', 08/12/24, 12/8/24, 'borrowed');

SELECT b.Title, b.Author, l.LoanDate, l.Status
FROM BookLoans l
JOIN Books b ON l.ISBN = b.ISBN
WHERE l.UserID = 143;

SELECT l.LoanID, u.FullName, b.Title, l.LoanDate, l.ReturnDate
FROM BookLoans l
JOIN Users u ON l.UserID = u.UserID
JOIN Books b ON l.ISBN = b.ISBN
WHERE l.Status = 'overdue';

INSERT INTO BookLoans(UserID, BookISBN, LoanDate, Status)
SELECT 143, '9781447294832', 12/8/24, 'borrowed'
WHERE EXISTS (
    SELECT 1
    FROM Books 
    WHERE BookISBN = '9781447294832'
    AND QuantityAvailable > 0
);

UPDATE Books
SET  QuantityAvailable = QuantityAvailable - 1
WHERE ISBN = '9781447294832'
AND QuantityAvailable > 0;

CREATE INDEX idx_overdue_loans ON BookLoans (Status, ReturnDate);