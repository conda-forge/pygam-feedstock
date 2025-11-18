#!/bin/bash

# Fix pyproject.toml to remove poetry-dynamic-versioning dependency
sed -i 's/version = "0.9.1" # placeholder for dynamic versioning/version = "0.9.1"/' pyproject.toml
sed -i '/^python = /,/^]/c\python = "*"' pyproject.toml
sed -i '/^numpy = \[/,/^]/c\numpy = "*"' pyproject.toml
sed -i 's/progressbar2 = "\^4.2.0"/progressbar2 = "*"/' pyproject.toml
sed -i '/^scipy = \[/,/^]/c\scipy = "*"' pyproject.toml
sed -i 's/requires = \["poetry-core>=1.0.0", "poetry-dynamic-versioning"\]/requires = ["poetry-core>=1.0.0"]/' pyproject.toml
sed -i 's/build-backend = "poetry_dynamic_versioning.backend"/build-backend = "poetry.core.masonry.api"/' pyproject.toml
sed -i '/\[tool.poetry-dynamic-versioning\]/,/style = "semver"/d' pyproject.toml

# Install
${PYTHON} -m pip install . --no-deps -vv
