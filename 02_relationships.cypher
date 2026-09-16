MATCH (b:book {ISBN: 50001}), (a:author {authorID: "au01"})
CREATE (b)-[:IS_WRITTEN_BY]->(a);

MATCH (b:book {ISBN: 50002}), (a:author {authorID: "au02"})
CREATE (b)-[:IS_WRITTEN_BY]->(a);

MATCH (b:book {ISBN: 50003}), (a:author {authorID: "au03"})
CREATE (b)-[:IS_WRITTEN_BY]->(a);

3.2 (ii)
MATCH (m:member {memberID: "MEM001"}), (b:book {ISBN: 50002})
CREATE (m)-[:BORROWED {dateBorrow: "2024-09-15", dueDate: "2024-10-25", fineAmount: 0.0}]->(b);
MATCH (m:member {memberID: "MEM002"}), (b:book {ISBN: 50003})
CREATE (m)-[:BORROWED {dateBorrow: "2024-04-15", dueDate: "2024-06-25", returnDate: "2024-09-25", fineAmount: 50.0}]->(b);
MATCH (m:member {memberID: "MEM003"}), (b:book {ISBN: 50001})
CREATE (m)-[:BORROWED {dateBorrow: "2024-09-15", dueDate: "2024-11-25", fineAmount: 0.0}]->(b);
