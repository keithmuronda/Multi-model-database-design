db.books.find({ year_published: { $gt: 2026 } })

db.fines.aggregate([
  { $group: { _id: null, totalRevenue: { $sum: "$amount" } } }
])

db.borrowed_books.deleteOne({ member_id: 1 })

db.borrowed_books.aggregate([
  {
    $lookup: {
      from: "members",
      localField: "member_id",
      foreignField: "member_id",
      as: "member"
    }
  },
  { $unwind: "$member" }
])
