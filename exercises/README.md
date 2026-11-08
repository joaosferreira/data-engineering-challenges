# Exercise conventions

Place every exercise directly under `exercises/`, not in a discipline-specific subdirectory. Name its directory `<zero-padded-id>-<descriptive-slug>` (for example, `001-customer-revenue`). IDs are positive integers, unique across the repository, stable even if an exercise is renamed, and never reused after retirement. Pad the directory prefix to at least three digits (`001`, `023`, `105`, `1000`); the prefix must equal the integer `id` in `metadata.yaml`. Exercise selection uses the numeric ID without requiring leading zeros.

Each SQL exercise directory contains:

```text
exercises/001-customer-revenue/
├── README.md       # Interviewer: context and evaluation guidance
├── exercise.md     # Candidate: assignment and expected deliverables
├── metadata.yaml   # ID, candidate-facing title, direct dependencies
└── solution.sql    # Interviewer: reference solution
```

For other exercise types, use an appropriate reference-solution format. Keep all exercise-specific materials in the exercise directory; no separate `interviewer/` directory is needed.

## Writing the files

- **`README.md`** is for interviewers. Include relevant context such as discipline, difficulty, estimated duration, evaluated competencies, and evaluation guidance.
- **`exercise.md`** is for candidates. State the problem, requirements, constraints, and expected results or deliverables without reference solutions, solution-revealing hints, rubrics, or internal exercise IDs in the title.
- **`metadata.yaml`** identifies the exercise with an integer `id` and a candidate-facing `title`. Add only direct dependencies that the exercise actually needs; omit empty dependency categories. Do not add difficulty, discipline, or deliverable details to metadata.
- **`solution.sql`** (for SQL exercises) is interviewer-facing. Do not include it with candidate instructions.

For example, an exercise requiring another exercise's output and a dataset and environment of its own can declare:

```yaml
id: 2
title: Average Order Value
dependencies:
  exercises: [1]
  datasets: [ecommerce]
  environments: [postgres]
```

An independent exercise with no dependencies needs only `id` and `title`. Declare an exercise dependency only when the candidate needs the prerequisite's implementation or output; related subject matter or shared data alone does not create a dependency. Do not repeat resource dependencies supplied solely by a required prerequisite exercise. Dataset and environment dependencies use reusable resource names.
