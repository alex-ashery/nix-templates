# Repository Guide

This repository publishes reusable Nix development shells and static project
templates under `github:alex-ashery/nix-templates`.

## Architecture

- `flake.nix` exposes the templates and per-system shell helper functions.
- `lib/base.nix` owns tooling shared by every shell, including `pre-commit`
  and `just`.
- `lib/go.nix` and `lib/python-uv.nix` extend the base shell with
  language-specific tooling and environment setup.
- `templates/base`, `templates/go`, and `templates/python-uv` are independent,
  static directories copied by `nix flake init`.
- Each template's `.packages.nix` is an empty extension point for packages
  needed by an initialized project.

Keep reusable shell behavior in `lib/`. Keep repository scaffolding and
language-specific workflow files in the relevant template directory.

Do not introduce template rendering, inheritance, symlink-based composition,
or generated template directories unless the repository architecture is
explicitly being reconsidered.

## Development Environment

Activate the repository shell with:

```sh
direnv allow
```

Alternatively:

```sh
nix develop
```

The shell installs the configured pre-commit hook automatically when entered
from this Git repository.

Add tools needed only for maintaining this repository to the root
`.packages.nix`. Add tools required by every generated repository to
`lib/base.nix`.

## Changing Shells

When modifying a language shell:

1. Compose it through `lib/base.nix`.
2. Keep common packages out of language-specific package lists.
3. Preserve `extraPackages` as the project-level extension mechanism.
4. Keep language state in ignored project-local directories when the existing
   shell already follows that convention.

Generated template flakes reference `github:alex-ashery/nix-templates`.
During local testing, override that input so the generated repo uses this
working copy:

```sh
NIX_TEMPLATES_REPO=/absolute/path/to/nix-templates
nix flake check \
  --override-input nix-templates \
  "path:$NIX_TEMPLATES_REPO"
```

Run that command from the initialized test repository.

## Changing Templates

Template directories are intentionally duplicated and self-contained. When a
shared convention changes, update every affected template explicitly:

- `.envrc`
- `.gitignore`
- `.packages.nix`
- `.pre-commit-config.yaml`
- `AGENTS.md`
- `flake.nix`

Preserve the established conventions unless the task requires otherwise.

New template files must be tracked or staged before Nix evaluates the flake.
Git-backed flakes do not include untracked files.

## Validation

Run the repository checks:

```sh
pre-commit run --all-files
nix flake check
```

For template changes, initialize each affected template in a fresh temporary
directory:

```sh
nix flake init -t "path:$NIX_TEMPLATES_REPO#base"
nix flake init -t "path:$NIX_TEMPLATES_REPO#go"
nix flake init -t "path:$NIX_TEMPLATES_REPO#python-uv"
```

Then run `nix flake check` in each initialized repository with the local
`nix-templates` input override described above.

Do not add generated lock files from temporary template tests to this
repository.
