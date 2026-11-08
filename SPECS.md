# Project Specification

## Overview

The project is a curated repository of reusable technical interview exercises for Data Engineering roles. It provides interviewers with realistic assignments, supporting datasets, execution environments, reference solutions, and evaluation guidance.

An interviewer selects exercises by their identifiers to assemble an assessment. An assessment is a generated, self-contained collection of exercises and the resources necessary to complete them; it is not a persistent repository entity or a manifest-defined configuration.

The initial implementation focuses on SQL exercises, PostgreSQL-backed datasets, and an interviewer-facing deployment of the complete execution environment. Assessment packaging is a defined capability whose implementation is deferred.

## Goals and Scope

The repository must:

- Support reusable technical exercises for interviews rather than a sequential teaching curriculum.
- Provide repeatable environments and realistic data for hands-on assessment.
- Separate candidate-facing assignments from interviewer-facing guidance and reference solutions.
- Support both independent and progressive exercises.
- Allow interviewers to deploy the complete execution environment directly from the repository.
- Support, when packaging is implemented, on-demand generation of candidate assessments from selected exercise identifiers.
- Remain extensible to Python, Spark, data pipelines, data modeling, and other relevant Data Engineering topics.

The project does not provide submission collection or assessment administration. Automated grading and a custom candidate interface are outside the initial scope.

## Core Concepts

### Exercise

An **exercise** is a reusable technical problem with a defined candidate-facing assignment and associated execution requirements. An exercise has a globally unique, stable positive integer identifier.

- An **independent exercise** can be completed without another exercise's implementation or output.
- A **progressive exercise** explicitly depends on the implementation or output of one or more preceding exercises.
- Conceptual progression or shared data alone does not constitute an exercise dependency.

### Dataset

A **dataset** is a reusable set of related schemas, records, and initialization resources. Multiple exercises may reference the same dataset. Datasets are engine-specific for the initial implementation, which targets PostgreSQL.

### Execution environment

An **execution environment** supplies the runtime and services required by exercises. Environment definitions are reusable and distinct from exercise descriptions and dataset contents.

### Assessment

An **assessment** is an ephemeral package assembled from an interviewer-selected set of exercise identifiers and their resolved dependencies. Assessments are created on demand; they have no stored manifest or predefined configuration in the repository.

## Repository Organization

The repository organizes exercises in a flat `exercises/` directory, without discipline-specific subdirectories. Each exercise has its own directory named with a zero-padded numeric identifier and a descriptive slug.

Illustrative layout:

```text
.
├── SPECS.md
├── README.md
├── compose.yaml
├── exercises/
│   ├── 001-customer-revenue/
│   │   ├── README.md
│   │   ├── exercise.md
│   │   ├── metadata.yaml
│   │   └── solution.sql
│   └── 002-average-order-value/
│       ├── README.md
│       ├── exercise.md
│       ├── metadata.yaml
│       └── solution.sql
├── datasets/
│   └── ecommerce/
│       ├── schema.sql
│       ├── seed.sql
│       └── data/
└── environments/
    └── postgres/
```

This layout illustrates responsibilities; auxiliary script and test locations are implementation details.

## Exercise Specification

Every exercise directory must contain:

- `README.md`: interviewer-facing documentation, including context such as discipline, difficulty, estimated duration, evaluated competencies, and evaluation guidance where applicable.
- `exercise.md`: the candidate-facing problem statement, requirements, constraints, and expected results or deliverables. It must not contain reference solutions or solution-revealing hints.
- `metadata.yaml`: minimal machine-readable metadata required to identify and package the exercise.
- `solution.sql`: interviewer-facing reference implementation for the SQL exercise; other exercise types may use an appropriate solution format.

All exercise-specific materials, including reference solutions and evaluation guidance, must be colocated in the exercise directory. The repository must not require a separate `interviewer/` directory.

Metadata must identify the exercise using an integer `id`, supply its candidate-facing `title`, and declare its direct dependencies when present. Difficulty, discipline, and deliverable details do not belong in metadata unless a concrete automation requirement later necessitates them.

Example:

```yaml
id: 2
title: Average Order Value
dependencies:
  exercises: [1]
  datasets: [ecommerce]
  environments: [postgres]
```

Dependency categories with no entries may be omitted. Exercise metadata must not redundantly declare resource dependencies obtained through required prerequisite exercises unless the exercise independently requires them.

### Identifier conventions

- IDs must be positive integers, unique across the entire repository, stable, and never reused after retirement.
- The directory prefix must match the metadata ID, formatted with a minimum width of three digits: `001`, `023`, `105`, `1000`.
- Selection interfaces must accept numeric IDs without requiring leading zeros.
- IDs are internal references and must not be added to candidate-facing exercise titles.
- Renaming an exercise must not change its ID.

## Dependency Management

Exercises may declare direct dependencies on other exercises, datasets, and execution environments. Dependency resolution must support transitive exercise dependencies, deduplicate shared resources, and detect missing or circular references.

A selected progressive exercise must bring in its actual prerequisite exercises. Shared datasets or related subject matter do not, by themselves, require exercises to be packaged together. The resolved exercise order must respect dependencies.

Datasets and environments must be identified by reusable, repository-wide resource names. An exercise declares its requirements; the corresponding resources define how those requirements are fulfilled.

## Datasets

The initial dataset implementation targets PostgreSQL. Each dataset owns its schema, seed/loading scripts, and source records; it does not require a database-independent schema abstraction.

- Dataset initialization must be deterministic and repeatable.
- Selected datasets must be included only once in an assembled assessment.
- Multiple datasets deployed into one PostgreSQL instance must use separate PostgreSQL schemas to avoid naming collisions.
- Dataset-specific loading behavior belongs with the dataset; execution environment definitions must not embed exercise-specific sample data.
- Data and schemas should contain the edge cases necessary to evaluate the associated exercise requirements.

The initial dataset is an e-commerce scenario with `customers`, `orders`, and `order_items`. Additional datasets may be added independently.

## Execution Environments

Reusable execution environments live under `environments/`. PostgreSQL is the initial environment and is deployed through Docker Compose.

An environment must supply the runtime services and configuration needed to execute its dependent exercises, while receiving dataset-specific initialization resources separately.

### Interviewer deployment

The repository must provide a root-level, interviewer-facing option to deploy the **complete** registered execution environment without generating an assessment or selecting exercises.

This deployment must:

- Start the services needed by all registered exercises and datasets.
- Initialize all registered datasets deterministically.
- Provide documented access to running services, including an interactive PostgreSQL connection.
- Allow interviewers to execute and inspect reference solutions.
- Support restoring the complete environment to its original initialized state.
- Remain independent of the assessment packaging capability.

Docker Compose is the primary deployment mechanism. Convenience commands may wrap Compose operations but must not require a separate orchestration framework. As additional runtimes are introduced, selective service startup may be supported without removing the complete-deployment option.

### Candidate deployment

A generated assessment must include only the execution services and resources necessary for its selected exercises and resolved dependencies. It must be usable independently of the source repository, with documented setup, connection, and reset instructions.

Candidate and interviewer deployments should reuse the same underlying environment definitions rather than duplicate incompatible implementations.

## Interviewer Workflow

An interviewer can:

1. Browse exercises and read their interviewer-facing documentation.
2. Deploy the complete execution environment for development and testing.
3. Execute reference solutions and examine expected behavior.
4. Select exercise IDs for a candidate assessment.
5. Once packaging is implemented, generate and distribute a self-contained assessment package.
6. Evaluate completed work outside an automated submission system using reference solutions and guidance.

Selection and packaging are on-demand operations; no persistent assessment manifest is required.

## Candidate Workflow

A candidate receives an assessment package containing only the selected assignments and their required resources. The candidate can read the instructions, initialize the provided environment, inspect schemas and data, implement solutions using a preferred editor or client, and run them locally.

The project does not prescribe or automate how completed work is submitted.

Candidate-facing materials must not expose internal exercise identifiers in titles or include reference solutions, grading rubrics, hidden evaluation fixtures, or unrelated repository resources.

## Assessment Packaging (Deferred Implementation)

The intended packaging interface accepts one or more integer exercise IDs directly, without requiring a manifest. It assembles an assessment automatically from the selected exercises and their transitive dependencies.

When implemented, the packaging mechanism must:

- Resolve selected IDs uniquely and reject unknown IDs.
- Include prerequisite exercises, deduplicated datasets, and the minimal compatible execution environment.
- Produce a self-contained, portable candidate distribution, such as an archive.
- Place candidate-facing exercise Markdown files in a **flat** `exercises/` directory.
- Rename each source `exercise.md` to a slug derived from the candidate-facing exercise title (for example, `customer-revenue.md`).
- Detect and reject destination filename collisions rather than overwrite files.
- Include appropriate candidate instructions and a place to implement solutions.
- Exclude interviewer-facing `README.md` files, `solution.sql` and other reference solutions, rubrics, hidden tests, and any unnecessary repository contents, even when they are colocated with candidate-facing files in exercise directories.
- Report invalid, cyclic, unresolved, or incompatible dependencies clearly.
- Produce equivalent content for the same exercise selection and repository revision, subject to intentional build metadata.

The candidate distribution must not contain an accessible Git history or other material that reveals excluded interviewer resources. Packaging does not entail automated submission or grading.

The CLI command syntax, archive layout beyond the established flat exercise directory, and internal packaging implementation are deferred decisions.

## Non-Functional Requirements

- **Reproducibility:** Environment initialization and seed data must produce a known state; repeatable reset operations must restore it.
- **Portability:** Containerized environments should work on common Docker-supported desktop operating systems, including macOS, Linux, and Windows.
- **Simplicity:** Candidates should be able to run assessments with minimal prerequisites and without learning repository internals.
- **Isolation:** Datasets and assessments must avoid unintended interference or naming collisions.
- **Maintainability:** Exercise and resource conventions should minimize duplicate configuration and unnecessary abstractions.
- **Extensibility:** New exercises and datasets should be addable without redesigning existing content; additional execution engines may be introduced when needed.
- **Security:** Local environments must avoid unnecessary privileges and exposure. Candidate packages must exclude interviewer-only material.
- **Clarity:** Candidate assignments must define observable requirements without prescribing the solution approach unless the assessment explicitly evaluates a prescribed technique.

## Initial Implementation Scope

The first implementation milestone includes:

- The repository conventions and exercise structure described above.
- An initial collection of SQL exercises based on the e-commerce scenario.
- PostgreSQL-compatible schema and deterministic seed data.
- A reusable PostgreSQL execution environment.
- A root-level deployment mechanism for the complete interviewer environment, including access and reset instructions.
- Interviewer-facing documentation and reference solutions sufficient to test the exercises.

The assessment packaging CLI is specified but **not implemented** in the initial milestone.

## Deferred Capabilities

The following are outside the initial implementation:

- On-demand candidate assessment packaging and its CLI implementation.
- Automated solution validation, grading, and hidden test execution.
- Submission collection, candidate management, and assessment administration.
- A custom web interface or SQL editor.
- Additional runtimes such as Python and Spark, and database engines beyond PostgreSQL.

These capabilities may be introduced as concrete needs emerge, without altering the core distinctions between exercises, reusable resources, and generated assessments.
