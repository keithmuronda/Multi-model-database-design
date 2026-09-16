# Multi-Model Database Design

The same domain — a library and its members, books, authors and loans — modelled three
different ways: as relational tables in Oracle, as documents in MongoDB, and as a graph
in Neo4j.

The point of building it three times is that each model makes different questions cheap.
Screenshots of every query and its output are in [`screenshots/`](screenshots).

---

## Relational — Oracle SQL

[`oracle/`](oracle)

| File | Contents |
|---|---|
| `01_schema.sql` | Tables with primary and foreign key constraints |
| `02_sequences.sql` | Sequences for surrogate key generation |
| `03_seed_data.sql` | Sample rows |
| `04_views.sql` | A view joining instructors to their modules |
| `05_procedures.sql` | A PL/SQL procedure for enrolment |

The schema uses a composite primary key on the registration table, made up of the two
foreign keys, so the table itself enforces that a student cannot be registered for the
same module twice. Referential integrity is declared through named constraints rather
than left to application code.

`register_student` guards the insert with a count check inside the procedure, so calling
it repeatedly with the same arguments is safe. That is the pattern worth noting: the
integrity rule lives in the database, not in whatever happens to be calling it.

---

## Document — MongoDB

[`mongodb/`](mongodb)

| File | Contents |
|---|---|
| `01_collections.js` | Collection creation |
| `02_seed_data.js` | `insertMany` / `insertOne` sample documents |
| `03_queries.js` | Filters, aggregation, deletion, `$lookup` |

Covers range filtering on a field, an aggregation pipeline that groups and sums fine
amounts to produce total revenue, targeted deletion, and a `$lookup` with `$unwind` to
join borrowed-book records back to member documents.

`$lookup` is the interesting one: it is how a document store performs a join it was not
really designed for, which is a useful contrast with the SQL version of the same query.

---

## Graph — Neo4j / Cypher

[`neo4j/`](neo4j)

| File | Contents |
|---|---|
| `01_create_nodes.cypher` | Member, author and book nodes |
| `02_relationships.cypher` | `IS_WRITTEN_BY` and `BORROWED` relationships |
| `03_queries.cypher` | Traversals, aggregation, outstanding-loan query |

Loan details — borrow date, due date, return date, fine amount — are stored as properties
on the `BORROWED` relationship rather than on either node. That is the modelling decision
the graph makes natural: the facts belong to the act of borrowing, not to the member and
not to the book.

The outstanding-loans query is a good illustration of the payoff. Finding every book not
yet returned is a single pattern match with a null check on a relationship property,
where the relational version needs a join across three tables.

---

## What the comparison shows

Same data, three shapes:

- **Relational** enforces the rules. Constraints make invalid states impossible to store.
- **Document** keeps related data together in one place, and pays for joins when it needs them.
- **Graph** makes relationships first-class, so traversal queries stay short as the number of hops grows.

## Running these

Oracle scripts run in SQL*Plus or SQL Developer, in numbered order. MongoDB scripts run
in `mongosh`. Cypher scripts run in Neo4j Browser.

## Notes

Originally built for the Database Systems module of my BSc IT (Network and Security) at
Eduvos, reorganised here as a standalone project.
