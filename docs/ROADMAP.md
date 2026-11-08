# Project Roadmap

## Purpose

This roadmap organizes implementation of the Data Engineering interview exercise repository described in [SPECS.md](SPECS.md). Milestones describe usable outcomes and verification criteria rather than prescribing task-level implementation. `SPECS.md` remains authoritative for project requirements and conventions.

The initial release provides a working repository of SQL exercises, an e-commerce dataset, and a complete interviewer-facing PostgreSQL environment. Candidate assessment packaging is a planned but deferred capability.

## Milestone 1 — Repository Foundation

**Outcome:** The repository establishes consistent, discoverable conventions for authoring and maintaining exercises and resources.

**Deliverables**

- Root-level project README with purpose, repository overview, and contributor/interviewer entry points.
- Flat `exercises/` directory with directories named `<zero-padded-id>-<slug>`.
- Standard exercise file layout: interviewer `README.md`, candidate `exercise.md`, `metadata.yaml`, and SQL `solution.sql`.
- `datasets/` and `environments/` directories ready for reusable resources.
- Minimal documented conventions for integer exercise IDs, direct dependencies, and candidate/interviewer content separation.

**Acceptance criteria**

- A new exercise can be added by following documented conventions without introducing discipline-based subdirectories.
- The metadata ID agrees with the directory prefix, and identifiers remain globally unique.
- Candidate-facing titles do not contain internal exercise identifiers.
- No separate `interviewer/` directory is required.

## Milestone 2 — Reusable PostgreSQL Environment

**Outcome:** An interviewer can deploy and access the repository's PostgreSQL execution environment without generating an assessment.

**Deliverables**

- Reusable PostgreSQL environment definition under `environments/postgres/`.
- Root-level Docker Compose entry point for interviewer deployment.
- Documented commands to start, connect to, stop, and reset the environment.
- A database initialization mechanism that can load all registered datasets and isolate them in separate PostgreSQL schemas.

**Acceptance criteria**

- A fresh checkout can start PostgreSQL using the documented procedure.
- An interviewer can connect using a standard PostgreSQL client.
- The environment can be stopped and reset to its initial state.
- Deployment does not depend on the deferred packaging CLI.
- The environment definition is reusable by future scoped candidate packages.

## Milestone 3 — E-commerce Dataset

**Outcome:** The existing e-commerce scenario is reproducibly available in PostgreSQL for SQL assessments.

**Deliverables**

- `datasets/ecommerce/` containing PostgreSQL schema definitions, dataset-specific loading scripts, and source records.
- `customers`, `orders`, and `order_items` tables with the agreed sample records.
- Initialization through the full interviewer environment, using a dedicated PostgreSQL schema.
- Documentation for the dataset's table structure and relationships, where needed for exercise authors.

**Acceptance criteria**

- A clean deployment initializes the dataset without manual import steps.
- Re-initializing from a reset produces the same schema and records.
- Foreign-key relationships and relevant data types are represented appropriately.
- The seed data supports completed and cancelled orders and customers with no completed orders.
- Dataset loading remains owned by the dataset, not hard-coded into exercise files.

## Milestone 4 — Initial SQL Exercise Collection

**Outcome:** The repository contains a coherent initial set of executable, independently understandable SQL interview assignments.

**Deliverables**

- Candidate assignments for customer revenue, average order value, most recent completed order, ranking, and revenue changes, with exact requirements and appropriate datasets.
- A local interviewer `README.md`, `metadata.yaml`, and reference `solution.sql` for each exercise.
- Explicit exercise dependencies only where a candidate genuinely needs a prerequisite's work or output.
- Candidate instructions that specify observable results without revealing SQL techniques or solutions.

**Acceptance criteria**

- Every exercise has a unique positive integer ID and a matching zero-padded directory prefix.
- Every candidate assignment can be interpreted without relying on conversation history.
- Reference solutions execute against the initialized PostgreSQL dataset and satisfy the stated requirements.
- Independent exercises can be solved in isolation; genuine progressive dependencies are explicit.
- Interviewer-only hints, rubrics, and solutions remain outside `exercise.md`.

## Milestone 5 — End-to-End Verification and Initial Release

**Outcome:** An interviewer can use a fresh checkout to deploy the complete environment, browse exercises, and verify reference results.

**Deliverables**

- Documented end-to-end interviewer workflow.
- Verification of clean initialization, database connectivity, dataset reset, and reference-query execution.
- Checks for exercise ID uniqueness, path/metadata consistency, and resolvable declared dependencies (manual or automated at this stage).
- Resolved issues in setup instructions, SQL portability to PostgreSQL, and exercise expected outputs.

**Acceptance criteria**

- Following the root README from a clean checkout results in a working full environment.
- All initial reference solutions produce the documented expected outcomes.
- The interviewer can reset modified data and reproduce those outcomes.
- The repository is useful for composing and testing exercises even though candidate package generation is not yet implemented.

## Later Milestone — On-Demand Assessment Packaging (Deferred)

**Outcome:** An interviewer can select exercise IDs through a CLI and generate a self-contained, scoped candidate assessment package without an assessment manifest.

**Planned deliverables**

- CLI accepting integer exercise IDs without requiring leading zeros.
- Resolution of transitive exercise dependencies and deduplicated datasets/environments.
- Generation of the minimal compatible execution environment and candidate workspace.
- Flat `exercises/` directory with Markdown filenames derived from exercise titles, without identifiers in candidate-facing titles.
- Strict exclusion of local interviewer READMEs, reference solutions, rubrics, hidden tests, and revealing Git history.
- Actionable errors for unknown IDs, unresolved or circular dependencies, incompatible resources, and filename collisions.
- Verification that generated packages initialize and run independently of the source repository.

**Status:** Deferred until the initial interviewer-facing repository and execution environment are functioning. No manifest-based assessment definitions, automated submission system, or grading system are part of this milestone.

## Other Deferred Capabilities

Additional execution engines and exercise disciplines (including Python and Spark), automated solution validation, hidden test execution, and richer evaluation tooling may be considered after the initial release. Submission collection, candidate management, and a custom web interface are not planned requirements.

## Milestone Sequence

Milestones 1–5 define the initial implementation path. The PostgreSQL environment and e-commerce dataset may be developed together where practical, but the initial release is complete only when the end-to-end acceptance criteria are satisfied. The packaging milestone remains separate and deferred.
