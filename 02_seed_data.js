MEMBERS
db.members.insertMany([
  { member_id: 1, first_name: "Alex", last_name: "Brown" },
  { member_id: 2, first_name: "Lerato", last_name: "Mokoena" }
])
BOOKS
db.books.insertMany([
  { book_id: 1, title: "1984", year_published: 1949 },
  { book_id: 2, title: "Future AI", year_published: 2027 }
])
BORROWED BOOKS
db.borrowed_books.insertOne({
  member_id: 1,
  book_title: "1984",
  date_borrowed: ISODate("2025-01-01"),
  due_date: ISODate("2025-01-10"),
  return_date: ISODate("2025-01-15")
})
FINES
db.fines.insertMany([
  { member_id: 1, amount: 50 },
  { member_id: 2, amount: 0 }
])



db.members.find()
db.books.find()
db.borrowed_books.find()
db.fines.find()
