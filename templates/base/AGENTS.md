# Repository Guide

This repository was initialized from the `base` template in
`alex-ashery/nix-templates`.

## Development Environment

Use the Nix development shell for all project commands:

```sh
direnv allow
```

If direnv is unavailable, run commands through Nix directly:

```sh
nix develop
```

The shell provides `pre-commit` and `just`. Entering the shell from a Git
repository installs the configured pre-commit hook automatically.

## Adding Tools

Add project-specific Nix packages to `.packages.nix`:

```nix
{ pkgs }:
with pkgs; [
  jq
]
```

Do not add common shell tooling directly to `flake.nix`. Keep `flake.nix`
focused on wiring this repository to the shared shell from
`alex-ashery/nix-templates`.

After changing `.packages.nix`, reload direnv or re-enter `nix develop`.

## Validation

Before completing changes, run:

```sh
pre-commit run --all-files
nix flake check
```

Update flake inputs deliberately with:

```sh
nix flake update
```
