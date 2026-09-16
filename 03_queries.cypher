MATCH p=()-[]->() RETURN p;

MATCH (m:member)-[r:BORROWED]->(b:book)
RETURN m.memberID AS MemberID,
       m.lastName AS LastName,
       m.firstName AS FirstName,
       b.title AS BookTitle,
       r.dateBorrow AS BorrowedDate,
       r.dueDate AS DueDate,
       r.returnDate AS ReturnDate,
       r.fineAmount AS FineAmount;

MATCH (a:author {authorID: "au02"})<-[:IS_WRITTEN_BY]-(b:book)
RETURN a.authorID, a.firstName, a.lastName,
       count(b) AS NumberOfBooksByAuthorID_02;

MATCH (m:member)-[r:BORROWED]->(b:book)
WHERE r.returnDate IS NULL
RETURN m.memberID AS MemberIdentity,
       b.title AS BookHasNotBeenReturn,
       b.ISBN AS ISBN,
       r.returnDate AS returnDate;
