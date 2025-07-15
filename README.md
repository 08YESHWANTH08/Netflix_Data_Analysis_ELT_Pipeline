
# 🎬 Netflix Data Analysis ELT Pipeline with dbt & Snowflake

This project is a modern data stack implementation of an end-to-end ELT pipeline using **dbt (Data Build Tool)** with **Snowflake** and **AWS S3** as the underlying platforms.

Inspired by [Darshil Parmar's Masterclass Project](https://github.com/darshilparmar/dbt-databuildtool--masterclass-netflix-project), this repo is a fully functional version rebuilt, debugged, and annotated with personal enhancements and documentation for a beginner to grasp the concepts.

---

## 📁 Project Structure

```
Netflix_Data_Analysis/
│
├── netflix_dbt_project/
│   ├── dbt_project.yml
│   ├── models/
│   │   ├── staging/
│   │   ├── dim/
│   │   └── fct/
│   ├── macros/
│   ├── snapshots/
│   ├── seeds/
│   └── target/
│
├── raw_data/              # CSVs from MovieLens (optional for local copy)
└── README.md              # This documentation
```

---

## 🚀 What This Project Covers

✅ ELT Pipeline using dbt  
✅ Data Ingestion from AWS S3 into Snowflake  
✅ dbt Materializations: view, table, incremental, ephemeral  
✅ Use of Sources, Seeds, Snapshots, Tests, Macros  
✅ Project-level data modeling: Staging → Dimensional → Fact  
✅ dbt testing and documentation generation  

---

## 📦 Data Source

- [MovieLens 20M Dataset](https://grouplens.org/datasets/movielens/20m/)
- Stored in: `s3://netflixdataset-yourname` (S3 bucket manually created)
- Loaded into: `Snowflake` → `NETFLIX_DB.RAW` tables

---

## 🧊 Snowflake Configuration

Run the `instructions.sql` file to:

- Create `TRANSFORM` role
- Create `COMPUTE_WH` warehouse
- Create `NETFLIX_DB` database and `RAW` schema
- Create user: `YESHWANTH7482`
- Grant necessary permissions
- Load CSV data using Snowflake stage from S3

> ❗ **Note:** All credentials and keys (like AWS access keys, Snowflake passwords) have been scrubbed and excluded from this repo.

---

## ⚙️ Local Environment Setup

```bash
# Step 1: Create virtual env
python -m venv netflix_env
.
etflix_env\Scripts\ctivate  # On Windows

# Step 2: Install dbt and dependencies
pip install dbt-snowflake

# Step 3: Initialize dbt project
dbt init netflix_dbt_project
```

### 🔑 DBT Profile Configuration

Edit `C:\Users\<your_user>\.dbt\profiles.yml`

```yaml
netflix_dbt_project:
  outputs:
    dev:
      type: snowflake
      account: <your_account>
      user: "YESHWANTH7482"
      password: "<your_password>"
      role: TRANSFORM
      warehouse: COMPUTE_WH
      database: NETFLIX_DB
      schema: RAW
      threads: 4
  target: dev
```

---

## 🏗️ dbt Modeling

### 1. 📦 Staging Models (`models/staging/`)

Each raw table is referenced and aliased to standardized column names.

Examples:
```sql
SELECT movieId AS movie_id, title, genres
FROM {{ source('raw', 'raw_movies') }}
```

### 2. 📦 Dimension Models (`models/dim/`)

Transformed views into clean dimension tables:
- `dim_movies`
- `dim_users`
- `dim_genome_tags`

### 3. 📦 Fact Models (`models/fct/`)

Derived transaction-like models:
- `fct_genome_scores` (filtering relevance > 0)
- `fct_ratings` (incremental load on timestamp)

### 4. ⚡ Ephemeral Models

Used for joining temporary logic:
- `dim_movies_with_tags` (ephemeral)
- `ep_movie_with_tags` (CTE from above)

---

## 🧪 Testing, Seeds, Snapshots

### ✅ Schema Tests:
- `not_null`, `relationships`, `expression_is_true`, etc.

### 📂 Seeds:
Seed CSVs directly create Snowflake tables using:

```bash
dbt seed
```

### 🕒 Snapshots:
Track history of slow-changing dimension data (like user-tagging behavior):

```bash
dbt snapshot
```

---

## 📊 dbt Commands

```bash
# Run all models
dbt run

# Run specific model
dbt run --select dim_movies

# Run incremental only
dbt run --full-refresh

# Run tests
dbt test

# Build everything (run + seed + snapshot + test)
dbt build

# Serve documentation
dbt docs generate
dbt docs serve
```

---

## 📚 dbt Materializations (Quick Summary)

| Materialization | Description                                 | When to Use                         |
|------------------|---------------------------------------------|--------------------------------------|
| `view`           | Virtual model, always reflects latest data | Small data, quick refresh            |
| `table`          | Physical table in Snowflake                | Stable transformed data              |
| `incremental`    | Adds new rows only                         | Large tables with append-only logic  |
| `ephemeral`      | No physical table, used as CTE             | Intermediate logic, reused once      |

---

## 🔐 Security Notes

- All passwords and AWS credentials are removed.
- Secrets like `AWS_SECRET_KEY`, `dbtPassword123` were **used locally only for demo** and should never be pushed to GitHub.

---

## 🙏 Credits

- **Darshil Parmar** — Original YouTube Masterclass
- You — For learning by building ❤️

---

## 📎 How to Clone and Use

```bash
git clone https://github.com/08YESHWANTH08/Netflix_Data_Analysis_ELT_Pipeline.git
cd Netflix_Data_Analysis_ELT_Pipeline

# (Optional) Setup virtual env
python -m venv netflix_env
.
etflix_env\Scripts\activate

pip install dbt-snowflake

# Add your profiles.yml in ~/.dbt/
# Add your own AWS S3 & Snowflake creds

dbt run
dbt test
dbt docs serve
```

---

Let’s build more together! 🚀
