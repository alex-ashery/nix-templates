# Repository Guide

This repository was initialized from the `go` template in
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

The shell provides Go, `gopls`, Delve, `golangci-lint`, Go tools,
`pre-commit`, and `just`. Go state is stored under the ignored `.go/`
directory.

Entering the shell from a Git repository installs the configured pre-commit
hook automatically.

## Project Setup

Initialize a module when creating a new project:

```sh
go mod init github.com/alex-ashery/REPOSITORY
just tidy
```

Replace the example module path with the repository's real import path.

## Common Commands

```sh
just fmt
just lint
just test
just tidy
```

Use `just` recipes when one covers the task. Run focused `go test` commands
while iterating, then run `just test` before completing changes.

## Adding Tools

Add project-specific Nix packages to `.packages.nix`:

```nix
{ pkgs }:
with pkgs; [
  sqlc
]
```

Language tooling belongs in the shared Go shell. Keep `.packages.nix` for
tools required specifically by this repository.

## Validation

Before completing changes, run:

```sh
just fmt
just lint
just test
pre-commit run --all-files
nix flake check
```
