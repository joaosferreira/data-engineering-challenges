# Dataset initialization

Place each PostgreSQL dataset in a directory named with a lowercase PostgreSQL schema identifier (letters, digits, and underscores; starting with a letter; at most 63 characters). A dataset is **registered** when it contains `init.sql`. The PostgreSQL environment discovers all registered datasets on first initialization and loads them in directory-name order. Directories without `init.sql` are not loaded.

The dataset owns its tables and records. Its `init.sql` must create and select its own schema, using the `dataset_schema` variable supplied by the environment:

```sql
CREATE SCHEMA :"dataset_schema";
SET search_path TO :"dataset_schema";
\ir schema.sql
\ir seed.sql
```

`\ir` resolves paths relative to `init.sql`; dataset-specific schema, loading scripts, and source records stay in the dataset directory. Initialization runs only when the database volume is first created. After changing dataset files, use the documented reset command in the root README to rebuild the database from scratch.
