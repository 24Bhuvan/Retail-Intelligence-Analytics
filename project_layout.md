# Project Repository Layout

## Retail Sales Performance Analytics

This document defines the final repository structure for the **Retail Sales Performance Analytics** project.

The repository is organized by function so that raw data, processed data, analysis code, SQL development, Power BI assets, documentation, reports, and presentation deliverables remain clearly separated.

---

## Repository Structure

```text
Retail-Sales-Performance-Analytics/
│
├── .gitignore
├── LICENSE
├── project_layout.md
│
├── data/
│   ├── README.md
│   │
│   ├── raw/
│   │   └── source datasets
│   │
│   ├── cleaned/
│   │   └── cleaned datasets
│   │
│   └── processed/
│       ├── processed analytical datasets
│       │
│       └── features/
│           └── feature-engineered datasets
│
├── diagrams/
│   ├── er_diagram.png
│   └── star_schema.png
│
├── docs/
│   ├── README.md
│   ├── business_background.md
│   ├── business_requirements.md
│   ├── feature_dictionary.md
│   ├── kpi_dictionary.md
│   ├── kpi_specification.md
│   ├── project_charter.md
│   ├── project_scope.md
│   ├── references.md
│   ├── repository_audit_prompt.md
│   ├── schema_design.md
│   │
│   ├── archive/
│   │   └── kpi_dictionary_phase1_draft.md
│   │
│   └── powerbi/
│       ├── dax_plan.md
│       ├── filter_interaction_plan.md
│       ├── powerbi_blueprint.md
│       ├── powerbi_data_model.md
│       ├── report_page_plan.md
│       └── visual_plan.md
│
├── excel/
│   ├── README.md
│   └── Retail_Analysis.xlsx
│
├── notebooks/
│   ├── README.md
│   └── eda.ipynb
│
├── powerbi/
│   ├── README.md
│   ├── dax_measures.md
│   └── Retail_Sales_Performance_Analytics.pbix
│
├── presentation/
│   └── Retail_Sales_Case_Study.pptx
│
├── reports/
│   ├── README.md
│   │
│   ├── business_metrics/
│   ├── business_understanding/
│   ├── dashboard_validation/
│   ├── data_cleaning/
│   ├── data_modeling/
│   ├── data_quality/
│   ├── data_understanding/
│   ├── eda/
│   ├── feature_engineering/
│   ├── insights/
│   ├── kpi_design/
│   ├── profiling/
│   ├── python_processing/
│   ├── recommendations/
│   │
│   └── sql/
│       └── analytical_outputs/
│
├── sql/
│   ├── README.md
│   ├── analytical_queries.sql
│   ├── business_metrics_queries.sql
│   ├── business_queries.sql
│   ├── data_cleaning.sql
│   ├── data_modeling_fact_load.sql
│   ├── data_modeling_load.sql
│   ├── data_modeling_validation.sql
│   ├── data_profiling.sql
│   ├── data_validation.sql
│   ├── export_analytical_outputs.sql
│   ├── feature_engineering_validation.sql
│   ├── kpi_queries.sql
│   ├── python_cross_validation.sql
│   ├── schema.sql
│   ├── sql_validation.sql
│   │
│   └── validation/
│       ├── postgresql_additional_validation.sql
│       └── postgresql_reporting_layer_validation.sql
│
└── src/
    ├── README.md
    │
    ├── analysis/
    │   ├── business_metrics.py
    │   ├── create_final_kpi_results.py
    │   ├── cross_validate_postgres.py
    │   ├── data_quality_assessment.py
    │   ├── generate_dataset_profile.py
    │   ├── kpi_calculations.py
    │   ├── post_cleaning_validation.py
    │   ├── reconciliation_checks.py
    │   └── sql_python_validation.py
    │
    └── data/
        ├── clean_data.py
        ├── feature_engineering.py
        ├── load_data.py
        ├── preprocess.py
        ├── process_data.py
        └── validate_input.py
```

---

## Directory Responsibilities

### `data/`

Contains the project's data lifecycle.

| Directory             | Purpose                                 |
| --------------------- | --------------------------------------- |
| `raw/`                | Original source datasets                |
| `cleaned/`            | Datasets after data-cleaning operations |
| `processed/`          | Analysis-ready transformed datasets     |
| `processed/features/` | Feature-engineered datasets             |

Dataset contents are excluded from version control through `.gitignore`. Documentation files such as `README.md` remain version-controlled.

---

### `diagrams/`

Contains visual representations of the analytical architecture.

* `er_diagram.png` — Entity Relationship Diagram
* `star_schema.png` — dimensional/star-schema representation

---

### `docs/`

Contains project documentation and planning artifacts.

The directory covers:

* Business background
* Business requirements
* Project charter
* Project scope
* Data and feature definitions
* KPI definitions and specifications
* Schema design
* References
* Power BI planning documentation

The `archive/` directory contains superseded documentation retained for historical reference.

The `powerbi/` subdirectory contains Power BI planning and design documentation.

---

### `excel/`

Contains the Excel-based analytical deliverable.

* `Retail_Analysis.xlsx` — Excel analysis workbook
* `README.md` — directory documentation

---

### `notebooks/`

Contains exploratory and analytical Jupyter notebooks.

* `eda.ipynb` — Exploratory Data Analysis notebook
* `README.md` — directory documentation

---

### `powerbi/`

Contains the implemented Power BI deliverable and supporting documentation.

* `Retail_Sales_Performance_Analytics.pbix` — final Power BI report
* `dax_measures.md` — DAX measure documentation
* `README.md` — directory documentation

Power BI planning documents are maintained separately under:

```text
docs/powerbi/
```

---

### `presentation/`

Contains the project case-study presentation.

* `Retail_Sales_Case_Study.pptx`

This is the presentation-ready communication layer of the project.

---

### `reports/`

Contains analytical outputs, validation evidence, and project-stage reports.

Major report categories include:

| Directory                 | Purpose                                                         |
| ------------------------- | --------------------------------------------------------------- |
| `business_metrics/`       | Final business metrics and KPI calculation outputs              |
| `business_understanding/` | Business-understanding analysis                                 |
| `dashboard_validation/`   | Power BI dashboard QA and validation                            |
| `data_cleaning/`          | Cleaning execution and validation evidence                      |
| `data_modeling/`          | Data-model validation outputs                                   |
| `data_quality/`           | Data-quality assessment results                                 |
| `data_understanding/`     | Data inventory, dictionary, relationships, and ER documentation |
| `eda/`                    | EDA findings and generated charts                               |
| `feature_engineering/`    | Feature-engineering validation                                  |
| `insights/`               | Validated business insights and supporting evidence             |
| `kpi_design/`             | KPI design and feasibility validation                           |
| `profiling/`              | Dataset profiling output                                        |
| `python_processing/`      | Python processing and reproducibility evidence                  |
| `recommendations/`        | Executive recommendations                                       |
| `sql/`                    | SQL analytical outputs                                          |

---

### `sql/`

Contains SQL development and analytical query assets.

Major areas include:

* Database schema creation
* Data loading
* Data profiling
* Data cleaning
* Data validation
* Business analysis
* KPI calculations
* Feature-engineering validation
* Python/SQL cross-validation
* Analytical output exports
* PostgreSQL validation

The `validation/` directory contains additional PostgreSQL validation scripts.

---

### `src/`

Contains reusable Python source code.

#### `src/data/`

Responsible for data ingestion and transformation.

Key responsibilities include:

* Input validation
* Loading data
* Preprocessing
* Cleaning
* Data processing
* Feature engineering

#### `src/analysis/`

Contains analytical and validation scripts.

Key responsibilities include:

* Dataset profiling
* Data-quality assessment
* KPI calculations
* Business metrics
* Reconciliation checks
* PostgreSQL cross-validation
* SQL/Python validation
* Post-cleaning validation

---

## Separation of Responsibilities

The repository follows this general separation:

```text
data/          → Data
src/           → Python implementation
sql/           → SQL implementation
notebooks/     → Interactive analysis
excel/         → Excel analysis
powerbi/       → BI implementation
diagrams/      → Data-model visuals
reports/       → Evidence and analytical outputs
docs/          → Methodology and documentation
presentation/  → Final business presentation
```

This separation prevents analytical code, source data, documentation, and final business outputs from being mixed together.

---

## Version-Control Policy

The repository tracks:

* Source code
* SQL scripts
* Jupyter notebooks
* Documentation
* Analytical reports
* Validation outputs
* Power BI deliverables
* Excel deliverables
* Presentation files
* Architecture diagrams

The repository does **not** track:

* Raw dataset contents
* Cleaned dataset contents
* Processed dataset contents
* Feature-engineered dataset contents
* Python virtual environments
* IDE-specific files
* Environment variables
* Secrets
* Temporary files
* Database files
* Power BI autosave/temp files
* Other files explicitly excluded by `.gitignore`

---

## Repository Design Principle

The repository is structured to support:

1. **Reproducibility** — analytical processing and validation logic are retained.
2. **Traceability** — reports and validation outputs provide evidence for analytical results.
3. **Maintainability** — implementation, documentation, data, and outputs are separated.
4. **Portfolio Presentation** — final analytical deliverables are easy to locate.
5. **Version Control Hygiene** — source datasets and machine-specific artifacts are excluded where appropriate.
6. **Business Communication** — insights, recommendations, dashboards, and presentations are separated from implementation code.

---

## Current Repository State

The structure represented in this document corresponds to the repository layout after the Project Structure phase organization.

Before the project is considered fully finalized, the repository should be verified for:

* Correct file placement
* Consistent naming
* Required README files
* Correct `.gitignore` behavior
* No unintended dataset commits
* No obsolete duplicate artifacts
* No temporary files
* Clean Git working tree
* Successful synchronization with the remote repository
