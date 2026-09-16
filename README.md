# Multi-Model Database Design

The same domain — a library and its members, books, authors and loans — modelled three
different ways: as relational tables in Oracle, as documents in MongoDB, and as a graph
in Neo4j.

The point of building it three times is that each model makes different questions cheap.
Every script here is runnable, and the numbered PNGs are the query output captured as it
ran.

---

## Relational — Oracle SQL

| Script | Contents |
|---|---|
| [`01_schema.sql`](01_schema.sql) | Tables with primary and foreign key constraints |
| [`02_sequences.sql`](02_sequences.sql) | Sequences for surrogate key generation |
| [`03_seed_data.sql`](03_seed_data.sql) | Sample rows |
| [`04_views.sql`](04_views.sql) | A view joining instructors to their modules |
| [`05_procedures.sql`](05_procedures.sql) | A PL/SQL procedure for enrolment |

The schema uses a composite primary key on the registration table, made up of the two
foreign keys, so the table itself enforces that a student cannot be registered for the
same module twice. Referential integrity is declared through named constraints rather
than left to application code.

`register_student` guards the insert with a count check inside the procedure, so calling
it repeatedly with the same arguments is safe. That is the pattern worth noting: the
integrity rule lives in the database, not in whatever happens to be calling it.

**Output:** [01](01.png) · [02](02.png) · [03](03.png) · [04](04.png) ·
[05](05.png) · [06](06.png)

---

## Document — MongoDB

| Script | Contents |
|---|---|
| [`01_collections.js`](01_collections.js) | Collection creation |
| [`02_seed_data.js`](02_seed_data.js) | `insertMany` / `insertOne` sample documents |
| [`03_queries.js`](03_queries.js) | Filters, aggregation, deletion, `$lookup` |

Covers range filtering on a field, an aggregation pipeline that groups and sums fine
amounts to produce total revenue, targeted deletion, and a `$lookup` with `$unwind` to
join borrowed-book records back to member documents.

`$lookup` is the interesting one: it is how a document store performs a join it was not
really designed for, which is a useful contrast with the SQL version of the same query.

**Output:** [07](07.png) · [08](08.png) · [09](09.png) · [10](10.png) ·
[11](11.png) · [12 — total revenue](12.png) · [13 — deletion](13.png) · [14](14.png)

---

## Graph — Neo4j / Cypher

| Script | Contents |
|---|---|
| [`01_create_nodes.cypher`](01_create_nodes.cypher) | Member, author and book nodes |
| [`02_relationships.cypher`](02_relationships.cypher) | `IS_WRITTEN_BY` and `BORROWED` relationships |
| [`03_queries.cypher`](03_queries.cypher) | Traversals, aggregation, outstanding-loan query |

Loan details — borrow date, due date, return date, fine amount — are stored as properties
on the `BORROWED` relationship rather than on either node. That is the modelling decision
the graph makes natural: the facts belong to the act of borrowing, not to the member and
not to the book.

The outstanding-loans query is a good illustration of the payoff. Finding every book not
yet returned is a single pattern match with a null check on a relationship property,
where the relational version needs a join across three tables.

**Output:** [15](15.png) · [16](16.png) · [17](17.png) · [18](18.png) ·
[19](19.png) · [20](20.png) · [21](21.png) · [22](22.png) · [23](23.png) ·
[24](24.png) · [25](25.png) · [26](26.png) · [27](27.png)

---

## What the comparison shows

Same data, three shapes:

- **Relational** enforces the rules. Constraints make invalid states impossible to store.
- **Document** keeps related data together in one place, and pays for joins when it needs them.
- **Graph** makes relationships first-class, so traversal queries stay short as the number of hops grows.

## Running these

Oracle scripts run in SQL*Plus or SQL Developer, in numbered order. MongoDB scripts run
in `mongosh`. Cypher scripts run in Neo4j Browser.

The `.js` files are `mongosh` commands rather than Node scripts, and GitHub's language
detector reads them as JavaScript. It also doesn't recognise `.cypher` at all, so the
language bar on this page understates what's here.
