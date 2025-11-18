#!/bin/bash
set -ex

# Remove the dynamic versioning comment from version field
sed -i 's/version = "0.9.1" # placeholder for dynamic versioning/version = "0.9.1"/' pyproject.toml

# Simplify dependency specifications (conda handles version constraints)
sed -i '/^python = /,/^]/c\python = "*"' pyproject.toml
sed -i '/^numpy = \[/,/^]/c\numpy = "*"' pyproject.toml
sed -i 's/progressbar2 = "\^4.2.0"/progressbar2 = "*"/' pyproject.toml
sed -i '/^scipy = \[/,/^]/c\scipy = "*"' pyproject.toml

# Replace poetry-dynamic-versioning backend with poetry.core
sed -i 's/requires = \["poetry-core>=1.0.0", "poetry-dynamic-versioning"\]/requires = ["poetry-core>=1.0.0"]/' pyproject.toml
sed -i 's/build-backend = "poetry_dynamic_versioning.backend"/build-backend = "poetry.core.masonry.api"/' pyproject.toml

# Remove the poetry-dynamic-versioning configuration section
sed -i '/\[tool.poetry-dynamic-versioning\]/,/style = "semver"/d' pyproject.toml

# Install the package
${PYTHON} -m pip install . --no-deps -vv
