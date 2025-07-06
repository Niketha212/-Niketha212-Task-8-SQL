USE LibraryDB;

-- 🔁 Stored Procedure: Get books borrowed by a specific member
DELIMITER $$

CREATE PROCEDURE GetBorrowedBooksByMember(IN memberName VARCHAR(100))
BEGIN
    SELECT m.name, b.title, br.borrow_date, br.return_date
    FROM BorrowRecords br
    JOIN Members m ON br.member_id = m.member_id
    JOIN Books b ON br.book_id = b.book_id
    WHERE m.name = memberName;
END$$

DELIMITER ;

-- ✅ Call the procedure
-- CALL GetBorrowedBooksByMember('Alice');

-- 🧮 Function: Count how many times a book has been borrowed
DELIMITER $$

CREATE FUNCTION GetBorrowCount(bookTitle VARCHAR(200))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM BorrowRecords br
    JOIN Books b ON br.book_id = b.book_id
    WHERE b.title = bookTitle;
    RETURN total;
END$$

DELIMITER ;

-- ✅ Call the function
-- SELECT GetBorrowCount('Harry Potter and the Philosopher\'s Stone') AS BorrowedTimes;