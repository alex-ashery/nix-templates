# Repository Guide

This repository was initialized from the `python-uv` template in
`alex-ashery/nix-templates`.

## Development Environment

Activate the Nix development shell:

```sh
direnv allow
```

If direnv is unavailable, use:

```sh
nix develop
```

The shell provides Python, uv, Ruff, Pyright, `pre-commit`, and `just`.
The uv environment is stored in the ignored `.venv/` directory.

Entering the shell from a Git repository installs the configured pre-commit
hook automatically.

## Project Setup

Initialize and synchronize a new Python project with:

```sh
just init
just sync
```

Use uv for Python dependencies. Add dependencies with `uv add`, and run
project tools through `uv run`.

## Common Commands

```sh
just sync
just fmt
just lint
just test
```

Use `just` recipes when one covers the task. Run focused tests through
`uv run pytest` while iterating, then run `just test` before completing
changes.

## Adding Tools

Add project-level Python dependencies with uv. Add non-Python tools needed by
the repository to `.packages.nix`:

```nix
{ pkgs }:
with pkgs; [
  postgresql
]
```

Do not add Python application dependencies to `.packages.nix`.

## Validation

Before completing changes, run:

```sh
just fmt
just lint
just test
pre-commit run --all-files
nix flake check
```
